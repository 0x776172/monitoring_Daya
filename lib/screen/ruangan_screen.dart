import 'package:flutter/material.dart';
import 'package:monitoring_energi/data/get_data.dart';
import 'package:monitoring_energi/screen/current_chart.dart';
import 'package:monitoring_energi/screen/power_chart.dart';
import 'package:monitoring_energi/screen/volt_chart.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
            // Card(
            //   elevation: 5,
            //   shape: RoundedRectangleBorder(
            //       side: const BorderSide(style: BorderStyle.solid, width: 1.0),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: Container(
            //     padding: const EdgeInsets.all(8.0),
            //     height: 100,
            //     width: 160,
            //     child: Column(
            //       children: [
            //         const Text(
            //           'Konsumsi Daya',
            //           style: TextStyle(
            //             fontSize: 15,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         Expanded(
            //           child: Container(
            //             alignment: Alignment.center,
            //             child: Text(
            //               widget.data.isNotEmpty
            //                   ? '${widget.data[widget.data.length - 1].daya} W'
            //                   : '0 W',
            //               style: const TextStyle(
            //                 fontSize: 30,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        PowerChart(data: widget.data),
        VoltChart(data: widget.data),
        CurrentChart(data: widget.data),
      ],
    );
  }
}
