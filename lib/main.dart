import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      title: 'Penny Box',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? accountType;
  String? transactionType;
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final List<String> accountTypes = ["Cash", "Bank", "Credit", "Wallet"];
  final List<String> transactionTypes = ["Income", "Expense", "Transfer"];

  void _saveTransaction() {
    debugPrint("AccountType: $accountType");
    debugPrint("TransactionType: $transactionType");
    debugPrint("Amount: ${amountController.text}");
    debugPrint("Date: $selectedDate");
    // TODO: Insert into Drift database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penny Box'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Type Dropdown
            ShadSelect<String>(
              placeholder: const Text("Select Account Type"),
              selectedOptionBuilder: (context, value) {
                return Text(value);
              },
              options: accountTypes
                  .map((type) => ShadOption(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) => setState(() => accountType = val),
            ),
            const SizedBox(height: 16),

            // Transaction Type Dropdown
            ShadSelect<String>(
              selectedOptionBuilder: (context, value) {
                return Text(value);
              },
              placeholder: const Text("Select Transaction Type"),
              options: transactionTypes
                  .map((type) => ShadOption(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) => setState(() => transactionType = val),
            ),
            const SizedBox(height: 16),

            // Amount Input
            ShadInput(
              controller: amountController,
              placeholder: const Text("Enter Amount"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 24),

            // Save Button
            ShadButton(
              onPressed: _saveTransaction,
              child: const Text("Save Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
