import 'package:flutter/material.dart';
import 'package:monitoring_energi/data/get_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenTab extends StatefulWidget {
  final List<GetData> data;
  const ScreenTab({Key? key, required this.data}) : super(key: key);

  @override
  State<ScreenTab> createState() => _ScreenTabState();
}

class _ScreenTabState extends State<ScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              side: const BorderSide(style: BorderStyle.solid, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 160,
            child: Column(
              children: [
                const Text(
                  'Konsumsi Daya',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.data.isNotEmpty
                          ? '${widget.data[widget.data.length - 1].daya} W'
                          : '0 W',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 250,
            child: widget.data.isEmpty
                ? const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()))
                : SfCartesianChart(
                    zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                    enableAxisAnimation: true,
                    tooltipBehavior:
                        TooltipBehavior(enable: true, duration: 1.0),
                    primaryXAxis: CategoryAxis(
                      labelIntersectAction:
                          AxisLabelIntersectAction.multipleRows,
                      maximumLabels: 5,
                      // visibleMinimum: widget.data.length > 10
                      //     ? widget.data[widget.data.length - 10].timestamp
                      //     : null,
                      // visibleMaximum: widget.data.isNotEmpty
                      //     ? widget.data[widget.data.length - 1].timestamp
                      //     : null,
                    ),
                    series: <ScatterSeries<GetData, String>>[
                        ScatterSeries<GetData, String>(
                            name: 'Daya',
                            // Bind data source
                            dataSource: widget.data.isNotEmpty
                                ? widget.data
                                : [
                                    GetData(
                                        id: "id",
                                        daya: 0,
                                        timestamp:
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    0)
                                                .toString()),
                                  ],
                            xValueMapper: (GetData dataResult, _) =>
                                dataResult.timestamp,
                            yValueMapper: (GetData dataResult, _) =>
                                dataResult.daya)
                      ]),
          ),
        ),
      ],
    );
  }
}
