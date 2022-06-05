import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:monitoring_energi/data/get_data.dart';

class PowerChart extends StatefulWidget {
  final List<GetData> data;
  const PowerChart({Key? key, required this.data}) : super(key: key);

  @override
  State<PowerChart> createState() => _PowerChartState();
}

class _PowerChartState extends State<PowerChart> {
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
                    text: 'Power', textStyle: const TextStyle(fontSize: 10)),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enablePanning: true,
                ),
                enableAxisAnimation: true,
                tooltipBehavior: TooltipBehavior(enable: true, duration: 1.0),
                primaryXAxis: DateTimeCategoryAxis(
                  maximumLabels: 5,
                  visibleMaximum: widget.data.isNotEmpty
                      ? widget.data[widget.data.length - 1].timestamp
                      : null,
                  visibleMinimum: widget.data.length > 15
                      ? widget.data[widget.data.length - 15].timestamp
                      : null,
                  dateFormat: DateFormat('''dd/MM/yy\nHH:mm'''),
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  // visibleMinimum: DateTime.parse("2022-05-31"),
                  // visibleMaximum: DateTime.parse("2022-05-31"),
                ),
                primaryYAxis: NumericAxis(labelFormat: '{value} W'),
                series: <LineSeries<GetData, DateTime>>[
                  LineSeries<GetData, DateTime>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Daya',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.daya),
                  LineSeries<GetData, DateTime>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'kWh',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.kwh),
                ],
              ),
      ),
    );
  }
}
