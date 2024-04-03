import 'package:flutter/material.dart';

import '../models/transactions.dart';

class RecenTrasactionWidget extends StatelessWidget {
  final List<Transaction> transactions;
  const RecenTrasactionWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("See report"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text(transaction.category),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount: ${transaction.amount}'),
                      Text('Time: ${transaction.time.toString()}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
