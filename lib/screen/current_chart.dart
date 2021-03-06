import 'package:flutter/material.dart';
import 'package:monitoring_energi/data/get_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class CurrentChart extends StatefulWidget {
  final List<GetData> data;
  const CurrentChart({Key? key, required this.data}) : super(key: key);

  @override
  State<CurrentChart> createState() => _CurrentChartState();
}

class _CurrentChartState extends State<CurrentChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 250,
        child: widget.data.isEmpty
            ? const Center(
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()))
            : SfCartesianChart(
                legend: Legend(isVisible: true),
                title: ChartTitle(
                    text: 'Current', textStyle: const TextStyle(fontSize: 10)),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                ),
                enableAxisAnimation: true,
                tooltipBehavior: TooltipBehavior(enable: true, duration: 1.0),
                primaryXAxis: DateTimeCategoryAxis(
                  dateFormat: DateFormat('dd/MM/yy\nHH:mm'),
                  // maximumLabels: 5,
                  visibleMaximum: widget.data.length > 1
                      ? widget.data[widget.data.length - 1].timestamp
                      // DateTime.fromMillisecondsSinceEpoch(
                      //     widget.data[widget.data.length - 1].timestamp)
                      : null,
                  visibleMinimum: widget.data.length > 15
                      ? widget.data[widget.data.length - 15].timestamp
                      // DateTime.fromMillisecondsSinceEpoch(
                      //     widget.data[widget.data.length - 15].timestamp)
                      : null,

                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                ),
                // primaryYAxis: NumericAxis(labelFormat: '{value} A'),
                series: <LineSeries<GetData, DateTime>>[
                  LineSeries<GetData, DateTime>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Ir',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      // DateTime.fromMillisecondsSinceEpoch(
                      //     dataResult.timestamp),
                      yValueMapper: (GetData dataResult, _) =>
                          dataResult.arusR),
                  LineSeries<GetData, DateTime>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Is',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      // DateTime.fromMillisecondsSinceEpoch(
                      //     dataResult.timestamp),
                      yValueMapper: (GetData dataResult, _) =>
                          dataResult.arusS),
                  LineSeries<GetData, DateTime>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'It',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      // DateTime.fromMillisecondsSinceEpoch(
                      //     dataResult.timestamp),
                      yValueMapper: (GetData dataResult, _) =>
                          dataResult.arusT),
                ],
              ),
      ),
    );
  }
}
