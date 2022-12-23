import 'package:pad_lampung/core/data/model/response/scan_ticket_response.dart';

extension TicketMasukExtention on List<DataTicketMasuk> {

  List<String> extractTicketCode() {
    List<String> listCodes = [];
    for (int i = 0; i < length; i++){
      listCodes.add(this[i].noTiket);
    }
    return listCodes;
  }

}