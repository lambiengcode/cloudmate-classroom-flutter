import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/common/widgets/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

class PieChartRevenue extends StatefulWidget {
  final List<double> data;
  PieChartRevenue({required this.data});
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartRevenue> {
  double? touchedIndex;

  List<Color> colors = [
    Colors.redAccent,
    colorPrimary,
    Colors.deepPurple,
    Colors.deepOrangeAccent,
    Colors.amberAccent,
    Colors.blue,
    Colors.indigoAccent,
    Colors.yellow,
    Colors.tealAccent,
    Colors.pinkAccent,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        padding: EdgeInsets.only(bottom: 48.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: AspectRatio(
                aspectRatio: 1.23,
                child: PieChart(
                  PieChartData(
                    // pieTouchData:
                    //     PieTouchData(touchCallback: (pieTouchResponse) {
                    //   setState(() {
                    //     final desiredTouch =
                    //         pieTouchResponse.touchInput is! PointerExitEvent &&
                    //             pieTouchResponse.touchInput is! PointerUpEvent;
                    //     if (desiredTouch &&
                    //         pieTouchResponse.touchedSection != null) {
                    //       touchedIndex = pieTouchResponse
                    //           .touchedSection.titlePositionPercentageOffset;
                    //     } else {
                    //       touchedIndex = -1;
                    //     }
                    //   });
                    // }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListView.builder(
                    padding: EdgeInsets.all(.0),
                    shrinkWrap: true,
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Indicator(
                          color: colors[index],
                          text: widget.data.length == 7
                              ? DateFormat('dd/MM').format(DateTime.now()
                                  .subtract(Duration(days: index)))
                              : DateFormat('MMM').format(DateTime.now()
                                  .subtract(Duration(days: 30 * index))),
                          isSquare: false,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.data.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 15 : 10;
      final double radius = isTouched ? 80 : 60;
      return PieChartSectionData(
        color: colors[i],
        value: widget.data[i] * 100,
        title: '${widget.data[i] * 100}%',
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }
}
