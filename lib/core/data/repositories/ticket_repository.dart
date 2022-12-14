import 'package:dartz/dartz.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_detail_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_quota_response.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../model/holder/ticket_home_content_holder.dart';
import '../model/request/proses_transaksi_tiket_request.dart';
import '../model/response/error_response.dart';
import '../model/response/ticket_booking_response.dart';
import '../model/response/ticket_list_response.dart';
import '../model/response/ticket_price_response.dart';
import '../sources/remote/ticket_remote_data_source.dart';

class TicketRepository {
  final TicketRemoteDataSourceImpl dataSource;

  TicketRepository(this.dataSource);

  Future<Either<ErrorResponse, TicketQuotaResponse>> fetchTicketHomeContent(
      String accessToken, String idWisata) async {
    return dataSource.fetchTicketQuota(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, TicketPriceResponse>> fetchTicketPrice(
      String accessToken, String idWisata) async {
    return dataSource.fetchTicketPrice(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, ResponseProsesTransaksiTiket>>
      processTicketBooking(
          {required String accessToken,
          required String phoneNumber,
          required String email,
          required String paymentMethod,
          required int idTempatWisata,
          required int quantity,
          required int idTarif}) async {
    TransaksiBookingTiketRequest transaksiBookingTiket =
    TransaksiBookingTiketRequest(jumlah: quantity, idTarifTiket: idTarif);

    RequestProsesTransaksiTiket rawRequest = RequestProsesTransaksiTiket(
        noTelp: phoneNumber,
        email: email,
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
      String accessToken, String idWisata) async {
    String todayDate = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchTicketTransactionList(
        accessToken, idWisata, todayDate, true);
  }

  Future<Either<ErrorResponse, ResponseTicket>> fetchEmployeeTicketTransaction(
      String accessToken, String idWisata) async {
    String todayDate = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchTicketTransactionList(
        accessToken, idWisata, todayDate, false);
  }

  Future<Either<ErrorResponse, GenericResponse>> scanTicket(
      String accessToken, String noTransaksi) async {
    return dataSource.scanOnlineTicket(accessToken, noTransaksi);
  }

  Future<Either<ErrorResponse, ResponseDetailTicket>> fetchTicketTransactionDetail(
      String accessToken, String noTransaksi) async {
    return dataSource.fetchTicketTransactionDetail(accessToken, noTransaksi);
  }
}
