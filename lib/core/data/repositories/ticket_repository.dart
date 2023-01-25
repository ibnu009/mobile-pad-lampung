import 'package:dartz/dartz.dart';
import 'package:pad_lampung/core/data/model/request/xendit_create_payment_request.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_detail_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_income_total_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_quota_response.dart';
import 'package:pad_lampung/core/data/model/response/xendit_check_payment_response.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../model/request/proses_transaksi_tiket_request.dart';
import '../model/response/error_response.dart';
import '../model/response/scan_ticket_response.dart';
import '../model/response/ticket_booking_response.dart';
import '../model/response/ticket_income_response.dart';
import '../model/response/ticket_list_response.dart';
import '../model/response/ticket_price_response.dart';
import '../model/response/xendit_create_payment_response.dart';
import '../model/response/xendit_payment_method_response.dart';
import '../sources/remote/ticket_remote_data_source.dart';

class TicketRepository {
  final TicketRemoteDataSourceImpl dataSource;

  TicketRepository(this.dataSource);

  Future<Either<ErrorResponse, TicketQuotaResponse>> fetchTicketHomeContent(
      String accessToken, String idWisata) async {
    print('getting ticket content');
    return dataSource.fetchTicketQuota(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, ResponseTicketIncomeTotal>>
      fetchTicketIncomeTotal(String accessToken, String idWisata) async {
    print('getting ticket content');
    return dataSource.fetchIncomeTotal(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, TicketPriceResponse>> fetchTicketPrice(
      String accessToken, String idWisata) async {
    return dataSource.fetchTicketPrice(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, ResponseProsesTransaksiTiket>>
      processTicketBooking(
          {required String accessToken,
          required String paymentMethod,
          String? email,
          String? phoneNumber,
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
      String accessToken, String idWisata, int offset, int limit) async {
    String todayDate = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchTicketTransactionList(
        accessToken, idWisata, todayDate, true, offset, limit);
  }

  Future<Either<ErrorResponse, ResponseIncomeTicket>> fetchOnlineIncomeTicket(
      String accessToken, String idWisata, int offset, int limit) async {
    String todayDate = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchTicketIncomeList(
        accessToken, idWisata, todayDate, true, offset, limit);
  }

  Future<Either<ErrorResponse, ResponseIncomeTicket>> fetchOfflineIncomeTicket(
      String accessToken, String idWisata, int offset, int limit) async {
    String todayDate = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchTicketIncomeList(
        accessToken, idWisata, todayDate, false, offset, limit);
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

  Future<Either<ErrorResponse, GenericResponse>> scanTicketCode(
      String accessToken, String noTransaksi) async {
    return dataSource.scanTicket(accessToken, noTransaksi);
  }

  Future<Either<ErrorResponse, ResponseDetailTicket>>
      fetchTicketTransactionDetail(
          String accessToken, String noTransaksi) async {
    return dataSource.fetchTicketTransactionDetail(accessToken, noTransaksi);
  }

  Future<Either<ErrorResponse, XenditCreatePaymentResponse>>
      createPaymentXendit(
          {required String accessToken,
          required String email,
          required String noTransaksi,
          required int totalPrice,
          required int price,
          required int quantity,
          required int servicePrice,
          required String paymentMethod,
          required String wisataName}) async {
    PaymentItem paymentItem =
        PaymentItem(name: wisataName, quantity: quantity, price: price);
    PaymentItem paymentItemService =
    PaymentItem(name: 'Biaya Layanan', quantity: 1, price: servicePrice);
    XenditCreatePaymentRequest request = XenditCreatePaymentRequest(
        externalId: 'PAD-${DateTime.now().millisecondsSinceEpoch}',
        amount: totalPrice,
        payerEmail: email,
        description: 'Invoice PAD',
        paymentMethods: [paymentMethod],
        items: [paymentItem, paymentItemService], noTransaksi: noTransaksi);

    return dataSource.createPaymentXendit(accessToken, request);
  }

  Future<Either<ErrorResponse, XenditCheckPaymentResponse>> checkPaymentXendit(
      String accessToken, String transactionNumber, String invoiceId) async {
    return dataSource.checkPaymentXendit(
        accessToken, transactionNumber, invoiceId);
  }

  Future<Either<ErrorResponse, GenericResponse>> deletePaymentXendit(
      String accessToken, String invoiceId) async {
    return dataSource.deletePaymentXendit(accessToken, invoiceId);
  }

  Future<Either<ErrorResponse, XenditPaymentMethodResponse>>
      fetchXenditPaymentMethod(String accessToken) async {
    return dataSource.fetchXenditPaymentMethod(accessToken);
  }
}
