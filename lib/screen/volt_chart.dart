import 'package:flutter/material.dart';
import 'package:monitoring_energi/data/get_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class VoltChart extends StatefulWidget {
  final List<GetData> data;
  const VoltChart({Key? key, required this.data}) : super(key: key);

  @override
  State<VoltChart> createState() => _VoltChartState();
}

class _VoltChartState extends State<VoltChart> {
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
                title: ChartTitle(
                    text: "Voltage", textStyle: const TextStyle(fontSize: 10)),
                // zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                enableAxisAnimation: true,
                tooltipBehavior: TooltipBehavior(enable: true, duration: 1.0),
                primaryXAxis: DateTimeCategoryAxis(
                  dateFormat: DateFormat('''dd/MM/yy\nHH:mm'''),
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  maximumLabels: 5,
                ),
                series: <ScatterSeries<GetData, DateTime>>[
                  ScatterSeries<GetData, DateTime>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Vr',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.teg),
                  ScatterSeries<GetData, DateTime>(
                      name: 'Vs',
                      markerSettings: const MarkerSettings(isVisible: true),
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.teg),
                  ScatterSeries<GetData, DateTime>(
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Vt',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.teg),
                ],
              ),
      ),
    );
  }
}
