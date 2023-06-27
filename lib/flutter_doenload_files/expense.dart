import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff7165e3),
        title: const Text(
          "Expense History",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Column(
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Total Expense is \$2,639',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.3025,
                color: const Color(0xff1c1939),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
