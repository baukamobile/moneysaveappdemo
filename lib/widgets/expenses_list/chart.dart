import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'dart:math';

class MyChart extends StatelessWidget {
  const MyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Chart(
              layers: [
                ChartAxisLayer(
                  settings: ChartAxisSettings(
                    x: ChartAxisSettingsAxis(
              frequency: 1.0,
              max: 13.0,
              min: 7.0,
              textStyle: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 10.0,
                ),
              ),
              y: ChartAxisSettingsAxis(
                frequency: 100.0,
                max: 300.0,
                min: 0.0,
                textStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10.0,
                ),
              ),
                    ),
                    labelX: (value) => value.toInt().toString(),
                    labelY: (value) => value.toInt().toString(),
                  ),
                  ChartBarLayer(
                    items: List.generate(
              13 - 7 + 1,
              (index) => ChartBarDataItem(
                color: const Color.fromARGB(255, 71, 186, 130),
                value: Random().nextInt(280) + 20,
                x: index.toDouble() + 7,
              ),
                    ),
                    settings: const ChartBarSettings(
              thickness: 8.0,
              radius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                
              ]
            ),
            
    );
  }
}
