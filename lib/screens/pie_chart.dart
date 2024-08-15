import 'package:flutter/material.dart';
import 'package:flutter_pie_chart/flutter_pie_chart.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  final List<Pie> pies = [
    Pie(color: const Color(0xFFFF6262), proportion: 8),
    Pie(color: const Color(0xFFFF9494), proportion: 3),
    Pie(color: const Color(0xFFFFDCDC), proportion: 8),
  ];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: deviceSize.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterPieChart(
                  pies: pies,
                  selected: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
