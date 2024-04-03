import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';

class MyWallet extends StatelessWidget {
  final Currency selectedCurrency;
  final double balance;

  const MyWallet({
    Key? key,
    required this.selectedCurrency,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Wallets',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See all",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.wallet),
                  SizedBox(width: 8),
                  Text(
                    'Tiền mặt ',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text("${selectedCurrency.symbol} $balance"),
            ],
          ),
        ],
      ),
    );
  }
}
