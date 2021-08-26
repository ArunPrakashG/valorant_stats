import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key, required this.sectionData}) : super(key: key);

  final List<MapEntry<String, double>> sectionData;

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                    setState(() {
                      final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent && pieTouchResponse.touchInput is! PointerUpEvent;
                      if (desiredTouch && pieTouchResponse.touchedSection != null) {
                        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      } else {
                        touchedIndex = -1;
                      }
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var value in widget.sectionData)
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Indicator(
                    color: generateColorFromKey(value.key) ?? Colors.grey,
                    text: value.key,
                    isSquare: true,
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  Color? generateColorFromKey(String? key) {
    switch (key) {
      case 'Kills':
        return Colors.green[300];
      case 'Deaths':
        return Colors.red[300];
      case 'Assists':
        return Colors.orange[200];
      case null:
        return Colors.purple[200];
    }
  }

  List<PieChartSectionData> showingSections() {
    double total = 0;
    widget.sectionData.map((e) => e.value).forEach((element) => total += element);

    List<PieChartSectionData> sectionDataList = [];
    for (var i = 0; i < widget.sectionData.length; i++) {
      var section = widget.sectionData[i];
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      final percentage = ((section.value / total) * 100).truncateToDouble();

      sectionDataList.add(
        PieChartSectionData(
          color: generateColorFromKey(section.key),
          value: section.value,
          title: isTouched ? '${section.value.toInt()}' : '$percentage%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        ),
      );
    }

    return sectionDataList;
  }
}
