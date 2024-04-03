import 'package:flutter/material.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(String type, double amount) onTransactionAdded;

  const AddTransactionDialog({Key? key, required this.onTransactionAdded})
      : super(key: key);

  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  String? _selectedType;
  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Add Transaction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _amount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField(
              dropdownColor: Colors.grey[800],
              value: _selectedType,
              hint: Text(
                'Select Type',
                style: TextStyle(color: Colors.grey[600]),
              ),
              items: ['income', 'expense']
                  .map((type) => DropdownMenuItem(
                value: type,
                child: Text(
                  type,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value as String?;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_selectedType != null && _amount > 0) {
                    widget.onTransactionAdded(_selectedType!, _amount);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}