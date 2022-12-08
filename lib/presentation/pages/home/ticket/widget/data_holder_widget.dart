import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataHolderWidget extends StatelessWidget {
  DataHolderWidget({Key? key}) : super(key: key);

  final List<ChartData> chartData = [
    ChartData('Tiket', 300, AppTheme.lightGrey),
    ChartData('Tiket Terjual', 1200, AppTheme.primaryColor),
  ];

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
                buildPieChart(1200),
                buildCounter(1200),
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

  Widget buildPieChart(int total) {
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
                '$total',
                style: AppTheme.subTitle.copyWith(fontSize: 26),
              ),
              const Text('Total Pengunjung'),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 100,
          height: 100,
          child: SfCircularChart(series: <CircularSeries>[
            // Renders doughnut chart

            DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ]),
        )
      ],
    );
  }

  Widget buildCounter(int currentCounter) {
    return ListTile(
      leading: SvgPicture.asset("assets/icons/ticket_icon.svg",
          semanticsLabel: 'A red up arrow'),
      title: Text('Tiket'),
      subtitle: Text(
        'Masuk pantai Ketapang',
        style: TextStyle(fontSize: 13),
      ),
      trailing: Text("$currentCounter Orang", style: AppTheme.smallTitle),
    );
  }

  Widget buildCounterToilet(int currentCounter) {
    return ListTile(
      leading: SvgPicture.asset("assets/icons/toilet_icon.svg",
          semanticsLabel: 'A red up arrow'),
      title: Text('Toilet'),
      subtitle: Text(
        'Fasilitas',
        style: TextStyle(fontSize: 13),
      ),
      trailing: Text("$currentCounter Orang", style: AppTheme.smallTitle,),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
