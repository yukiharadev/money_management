import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_lover/widgets/recent_transactions.dart';

import '../models/transactions.dart';
import '../widgets/add_transaction_widget.dart';
import '../widgets/my_wallet_widget.dart';

class HomeScreen extends StatefulWidget {
  final Currency selectedCurrency;

  const HomeScreen({Key? key, required this.selectedCurrency}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0.0;
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      final response = await http.get(
        Uri.parse('https://660c4a8d3a0766e85dbddb47.mockapi.io/money'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          transactions = jsonData.map((item) => Transaction.fromJson(item)).toList();
          calculateBalance(transactions);
        });
      } else {
        throw Exception('Failed to fetch transactions');
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  void calculateBalance(List<Transaction> transactions) {
    balance = transactions.fold(0, (prev, transaction) {
      if (transaction.type == 'income') {
        return prev + transaction.amount;
      } else {
        return prev - transaction.amount;
      }
    });
  }

  Future<void> addTransaction(String type, double amount) async {
    try {
      final response = await http.post(
        Uri.parse('https://660c4a8d3a0766e85dbddb47.mockapi.io/money'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'type': type,
          'amount': amount,
          'time': DateTime.now().toIso8601String(),
          'category': type == 'income' ? 'Thu' : 'Chi',
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          transactions.add(Transaction(
            type: type,
            amount: amount,
            time: DateTime.now(),
            category: type == 'income' ? 'Thu' : 'Chi',
          ));
          calculateBalance(transactions);
        });
      } else {
        throw Exception('Failed to add transaction');
      }
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: HomeScreenContent(
        selectedCurrency: widget.selectedCurrency,
        balance: balance,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => AddTransactionDialog(
              onTransactionAdded: addTransaction,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final Currency selectedCurrency;
  final double balance;

  const HomeScreenContent({
    Key? key,
    required this.selectedCurrency,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${balance.toStringAsFixed(2)} ${selectedCurrency.symbol}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.remove_red_eye, color: Colors.white),
                ],
              ),
            ),
            const Text(
              "Total Balance",
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MyWallet(selectedCurrency: selectedCurrency, balance: balance),
            SizedBox(height: 20,),
            RecenTrasactionWidget(transactions: [],)
          ],
        ),
      ),
    );
  }
}
