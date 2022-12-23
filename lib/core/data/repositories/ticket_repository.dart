import 'package:dartz/dartz.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_detail_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_quota_response.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../model/request/proses_transaksi_tiket_request.dart';
import '../model/response/error_response.dart';
import '../model/response/scan_ticket_response.dart';
import '../model/response/ticket_booking_response.dart';
import '../model/response/ticket_list_response.dart';
import '../model/response/ticket_price_response.dart';
import '../sources/remote/ticket_remote_data_source.dart';

class TicketRepository {
  final TicketRemoteDataSourceImpl dataSource;

  TicketRepository(this.dataSource);

  Future<Either<ErrorResponse, TicketQuotaResponse>> fetchTicketHomeContent(
      String accessToken, String idWisata) async {
    print('getting ticket content');
    return dataSource.fetchTicketQuota(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, TicketPriceResponse>> fetchTicketPrice(
      String accessToken, String idWisata) async {
    return dataSource.fetchTicketPrice(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, ResponseProsesTransaksiTiket>>
      processTicketBooking(
          {required String accessToken,
          required String paymentMethod,
          required int idTempatWisata,
          required int quantity,
          required int idTarif}) async {
    TransaksiBookingTiketRequest transaksiBookingTiket =
    TransaksiBookingTiketRequest(jumlah: quantity, idTarifTiket: idTarif);

    RequestProsesTransaksiTiket rawRequest = RequestProsesTransaksiTiket(
        noTelp: null,
        email: null,
        metodePembayaran: paymentMethod,
        tanggal: DateTime.now().toFormattedDate(format: 'yyyy-MM-dd'),
        idTempatWisata: idTempatWisata,
        transaksiBookingTiket: transaksiBookingTiket);

    return dataSource.processTicketBooking(accessToken, rawRequest);
  }

  Future<Either<ErrorResponse, GenericResponse>> checkPaymentStatus(
      String accessToken, String transactionNumber) async {
    return dataSource.checkPaymentStatus(accessToken, transactionNumber);
  }

  Future<Either<ErrorResponse, ResponseTicket>> fetchOnlineTicketTransaction(
      String accessToken, String idWisata, int offset, int limit) async {
    String todayDate = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchTicketTransactionList(
        accessToken, idWisata, todayDate, true, offset, limit);
  }

  Future<Either<ErrorResponse, ResponseTicket>> fetchEmployeeTicketTransaction(
      String accessToken, String idWisata, int offset, int limit) async {
    String todayDate = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchTicketTransactionList(
        accessToken, idWisata, todayDate, false, offset, limit);
  }

  Future<Either<ErrorResponse, ResponseScanTicket>> scanTicket(
      String accessToken, String noTransaksi) async {
    return dataSource.scanOnlineTicket(accessToken, noTransaksi);
  }

  Future<Either<ErrorResponse, ResponseDetailTicket>> fetchTicketTransactionDetail(
      String accessToken, String noTransaksi) async {
    return dataSource.fetchTicketTransactionDetail(accessToken, noTransaksi);
  }
}
