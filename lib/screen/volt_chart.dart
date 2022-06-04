import 'package:flutter/material.dart';
import 'package:monitoring_energi/data/get_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                  maximumLabels: 5,
                ),
                series: <ScatterSeries<GetData, DateTime>>[
                  ScatterSeries<GetData, DateTime>(
                      name: 'Vr',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.tegR),
                  ScatterSeries<GetData, DateTime>(
                      name: 'Vs',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.tegS),
                  ScatterSeries<GetData, DateTime>(
                      name: 'Vt',
                      // Bind data source
                      dataSource: widget.data,
                      xValueMapper: (GetData dataResult, _) =>
                          dataResult.timestamp,
                      yValueMapper: (GetData dataResult, _) => dataResult.tegT),
                ],
              ),
      ),
    );
  }
}
