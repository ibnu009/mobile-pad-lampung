import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pad_lampung/core/data/model/response/parking_quota_response.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const String bikeType = "bikeType";
const String carType = "carType";
const String busType = "busType";

class DataHolderWidget extends StatefulWidget {
  final ParkingQuota? motorQuota, carQuota, busQuota;
  final int totalVehicle;
  const DataHolderWidget(
      {Key? key,
      required this.motorQuota,
      required this.carQuota,
      required this.busQuota, required this.totalVehicle})
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
      ChartData('Motor', (widget.motorQuota?.jumlah ?? 0).toDouble(),
          const Color.fromRGBO(141, 113, 224, 1.0)),
      ChartData('Mobil', (widget.carQuota?.jumlah ?? 0).toDouble(),
          const Color.fromRGBO(112, 204, 85, 1.0)),
      ChartData('Bus', (widget.busQuota?.jumlah ?? 0).toDouble(),
          const Color.fromRGBO(92, 99, 108, 1.0)),
      ChartData('Others', 0, const Color.fromRGBO(190, 190, 190, 1.0))
    ];
  }

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
            buildPieChart(widget.totalVehicle),
            buildCounter(bikeType, widget.motorQuota?.jumlah ?? 0, widget.motorQuota?.quota ?? 1),
            buildCounter(carType, widget.carQuota?.jumlah ?? 0, widget.carQuota?.quota ?? 1),
            buildCounter(busType, widget.busQuota?.jumlah ?? 0, widget.busQuota?.quota ?? 1),
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
      leading: SvgPicture.asset(getSvgBasedOnType(type),
          semanticsLabel: 'A red up arrow'),
      title: Text(getTitleBasedOnType(type)),
      subtitle: Text(
        getSubTitleBasedOnType(type),
        style: TextStyle(fontSize: 12),
      ),
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
