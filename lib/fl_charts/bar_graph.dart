import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_application/fl_charts/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List monthlySummary;
  const MyBarGraph({super.key, required this.monthlySummary});

  @override
  Widget build(BuildContext context) {
    //initialize Bar Data structure
    BarData myBarData = BarData(
      income: monthlySummary[0],
      expense: monthlySummary[1],
      budget: monthlySummary[2],
    );
    myBarData.initialize();
    return BarChart(
      BarChartData(
        //alignment: BarChartAlignment.spaceBetween,
        minY: 0,
        maxY: 100,
        gridData: const FlGridData(show: false),
        //  borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: data.x == 0
                        ? Color(0xFF1ABC9C)
                        : data.x == 1
                            ? Color(0xFF3498DB)
                            : Color(0xFFE62020).withOpacity(0.7),
                    width: 50,
                    borderRadius: BorderRadius.circular(10),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: Colors.grey[200],
                      toY: 100,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text("Income", style: style);
      break;

    case 1:
      text = const Text("Budget", style: style);
      break;

    case 2:
      text = const Text("Expense", style: style);

      break;
    default:
      text = const Text("", style: style);

      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
