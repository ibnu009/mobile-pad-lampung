import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataHolderWidget extends StatefulWidget {
  final int quota, currentTotal;
  final String wisataName;

  DataHolderWidget(
      {Key? key,
      required this.quota,
      required this.currentTotal,
      required this.wisataName})
      : super(key: key);

  @override
  State<DataHolderWidget> createState() => _DataHolderWidgetState();
}

class _DataHolderWidgetState extends State<DataHolderWidget> {
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    chartData = [
      ChartData('Tiket Terjual', widget.currentTotal.toDouble(),
          AppTheme.primaryColor),
      ChartData(
          'Tiket Tersedia',
          setDefaultValueIfValueIsZero(widget.currentTotal.toDouble(),
              widget.quota - widget.currentTotal.toDouble()),
          AppTheme.lightGrey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                buildPieChart(widget.currentTotal, widget.quota),
                buildCounter(widget.currentTotal, widget.quota),
              ],
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: buildCounterToilet(1200),
        ),
      ],
    );
  }

  Widget buildPieChart(int currentTotal, int total) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data Ticketing',
                style: AppTheme.subTitle,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '$currentTotal',
                style: AppTheme.subTitle.copyWith(fontSize: 26),
              ),
              const Text('Total Pengunjung'),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 135,
          height: 135,
          child: Stack(
            children: [
              SfCircularChart(series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    innerRadius: '80%',
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ]),
              Center(
                child: Text(currentTotal.toPercentage(total),
                    style: AppTheme.subTitle),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildCounter(int currentCounter, int max) {
    return ListTile(
      leading: SvgPicture.asset("assets/icons/ticket_icon.svg",
          semanticsLabel: 'A red up arrow'),
      title: const Text('Tiket'),
      subtitle: Text(
        'Masuk ${widget.wisataName}',
        style: const TextStyle(fontSize: 13),
      ),
      trailing:
          Text("$currentCounter / $max Orang", style: AppTheme.smallTitle),
    );
  }

  Widget buildCounterToilet(int currentCounter) {
    return ListTile(
      leading: SvgPicture.asset("assets/icons/toilet_icon.svg",
          semanticsLabel: 'A red up arrow'),
      title: const Text('Toilet'),
      subtitle: const Text(
        'Fasilitas',
        style: TextStyle(fontSize: 13),
      ),
      trailing: Text(
        "$currentCounter Orang",
        style: AppTheme.smallTitle,
      ),
    );
  }
}

double setDefaultValueIfValueIsZero(double soldTicket, double value) {
  if (soldTicket != 0) {
    return value;
  }

  return value == 0 ? 1.0 : value;
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
