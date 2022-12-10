import 'package:dartz/dartz.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_quota_response.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../model/request/proses_transaksi_tiket_request.dart';
import '../model/response/error_response.dart';
import '../model/response/ticket_price_response.dart';
import '../sources/remote/ticket_remote_data_source.dart';

class TicketRepository {
  final TicketRemoteDataSourceImpl dataSource;

  TicketRepository(this.dataSource);

  Future<Either<ErrorResponse, TicketQuotaResponse>> fetchTicketQuota(
      String accessToken, String idWisata) async {
    return dataSource.fetchTicketQuota(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, TicketPriceResponse>> fetchTicketPrice(
      String accessToken, String idWisata) async {
    return dataSource.fetchTicketPrice(accessToken, idWisata);
  }

  Future<Either<ErrorResponse, GenericResponse>> processTicketBooking(
      {required String accessToken,
      required String phoneNumber,
      required String email,
      required String paymentMethod,
      required int idTempatWisata,
      required int quantity,
      required int idTarif}) async {
    TransaksiBookingTiket transaksiBookingTiket =
        TransaksiBookingTiket(jumlah: quantity, idTarifTiket: idTarif);

    RequestProsesTransaksiTiket rawRequest = RequestProsesTransaksiTiket(
        noTelp: phoneNumber,
        email: email,
        metodePembayaran: paymentMethod,
        tanggal: DateTime.now().toFormattedDate(format: 'yyyy-MM-dd'),
        idTempatWisata: idTempatWisata,
        transaksiBookingTiket: transaksiBookingTiket);

    return dataSource.processTicketBooking(accessToken, rawRequest);
  }
}
