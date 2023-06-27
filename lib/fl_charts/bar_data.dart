import 'package:flutter_bloc_application/fl_charts/individual_bar.dart';

class BarData {
  final double income;
  final double budget;
  final double expense;

  BarData({
    required this.income,
    required this.budget,
    required this.expense,
  });

  List<Individual> barData = [];

  //initialize bar data
  void initialize() {
    barData = [
      Individual(x: 0, y: income),
      Individual(x: 1, y: budget),
      Individual(x: 2, y: expense),
    ];
  }
}
