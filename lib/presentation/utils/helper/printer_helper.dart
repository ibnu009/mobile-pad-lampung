import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'printer_enum.dart';

class PrinterHelper {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  printStruct(
      {required String transactionCode,
      required String location,
      required int total,
      required int price}) async {
    String today = DateTime.now().toFormattedDate(format: 'dd MMM yyyy HH:mm');
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        bluetooth.printCustom("Bukti Bayar", Size.bold.val, Align.center.val);
        bluetooth.printNewLine();
        bluetooth.printCustom("No Transaksi", Size.bold.val, Align.left.val);
        bluetooth.printCustom(transactionCode, Size.medium.val, Align.left.val);
        bluetooth.printCustom("Lokasi", Size.bold.val, Align.left.val);
        bluetooth.printCustom(location, Size.medium.val, Align.left.val);
        bluetooth.printCustom("Waktu Transaksi", Size.bold.val, Align.left.val);
        bluetooth.printCustom(today, Size.medium.val, Align.left.val);
        bluetooth.printCustom("Produk", Size.medium.val, Align.left.val);
        bluetooth.printLeftRight("$total Tiket Masuk", (total * price).toRupiah(), Size.medium.val);
        bluetooth.printNewLine();
        bluetooth.printCustom("Terimakasih", Size.bold.val, Align.center.val);
        bluetooth.paperCut();
        bluetooth.printNewLine();
      }
    });
  }

  printTicket({
    required List<String> ticketCodes,
    required String location,
  }) {
    String today = DateTime.now().toFormattedDate(format: 'dd MMM yyyy HH:mm');
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        for (int i = 0; i < ticketCodes.length; i++) {
          bluetooth.printCustom("Tiket Masuk", Size.bold.val, Align.center.val);
          bluetooth.printNewLine();
          bluetooth.printQRcode(ticketCodes[i], 200, 200, Align.center.val);
          bluetooth.printCustom("scan untuk akses masuk", Size.medium.val, Align.center.val);
          bluetooth.printCustom("No Tiket", Size.bold.val, Align.left.val);
          bluetooth.printCustom(ticketCodes[i], Size.medium.val, Align.left.val);
          bluetooth.printCustom("Lokasi", Size.bold.val, Align.left.val);
          bluetooth.printCustom(location, Size.medium.val, Align.left.val);
          bluetooth.printCustom("Waktu masuk", Size.bold.val, Align.left.val);
          bluetooth.printCustom(today, Size.medium.val, Align.left.val);
          bluetooth.paperCut();
          bluetooth.printNewLine();
        }
      }
    });
  }

  printIncome(
      {required String operatorName,
        required String location,
        required int total}) async {
    String today = DateTime.now().toFormattedDate(format: 'dd MMM yyyy HH:mm');
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        bluetooth.printCustom("PENDAPATAN", Size.bold.val, Align.left.val);
        bluetooth.printNewLine();
        bluetooth.printCustom("Lokasi", Size.bold.val, Align.left.val);
        bluetooth.printCustom(location, Size.medium.val, Align.left.val);
        bluetooth.printCustom("Waktu Transaksi", Size.bold.val, Align.left.val);
        bluetooth.printCustom(today, Size.medium.val, Align.left.val);
        bluetooth.printCustom("Pendapatan", Size.medium.val, Align.left.val);
        bluetooth.printLeftRight("- Tiket Masuk", total.toRupiah(), Size.medium.val);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Total:", total.toRupiah(), Size.medium.val);
        bluetooth.printLeftRight("Diterima Oleh: ", operatorName, Size.medium.val);
        bluetooth.printNewLine();
        bluetooth.paperCut();
        bluetooth.printNewLine();
      }
    });
  }
}
