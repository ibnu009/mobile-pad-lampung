import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const String bikeType = "bikeType";
const String carType = "carType";
const String busType = "busType";

class DataHolderWidget extends StatelessWidget {
  DataHolderWidget({Key? key}) : super(key: key);

  final List<ChartData> chartData = [
    ChartData('David', 25, const Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Steve', 38, const Color.fromRGBO(147, 0, 119, 1)),
    ChartData('Jack', 34, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1))
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            buildPieChart(124),
            buildCounter(bikeType, 0, 100),
            buildCounter(carType, 0, 100),
            buildCounter(busType, 0, 100),
          ],
        ));
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
                'Data Parkir',
                style: AppTheme.subTitle,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '$total',
                style: AppTheme.subTitle.copyWith(fontSize: 26),
              ),
              const Text('Total Kendaraan'),
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

  Widget buildCounter(String type, int currentCounter, int total) {
    return ListTile(
      leading: SvgPicture.asset(getSvgBasedOnType(type), semanticsLabel: 'A red up arrow'),
      title: Text(getTitleBasedOnType(type)),
      subtitle: Text(getSubTitleBasedOnType(type), style: TextStyle(fontSize: 12),),
      trailing: Text("$currentCounter/$total Unit"),
    );
  }

  String getSvgBasedOnType(String type) {
    if (type == bikeType) {
      return "assets/icons/bicycle_icon.svg";
    }
    if (type == carType) {
      return "assets/icons/car_icon.svg";
    }
    return "assets/icons/bus_icon.svg";
  }

  String getTitleBasedOnType(String type) {
    if (type == bikeType) {
      return "Sepeda Motor";
    }
    if (type == carType) {
      return "Mobil";
    }
    return "Bus";
  }

  String getSubTitleBasedOnType(String type) {
    if (type == bikeType) {
      return "Kendaran Roda 2";
    }
    if (type == carType) {
      return "Kendaran Roda 4";
    }
    return "Kendaran Roda 6 Atau Lebih";
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
