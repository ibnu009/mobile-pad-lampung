import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../../../common/app_const.dart';

extension StringConverter on String {
  String convertToSha256() {
    List<int> bytes = utf8.encode(this);
    String hash = sha256.convert(bytes).toString();
    return hash;
  }

  bool isEmailValid() {
    RegExp regex = RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (regex.hasMatch(this)) {
      return true;
    } else {
      return false;
    }
  }

  int toVehicleId() {
   if (toLowerCase() == motorType) return ID_MOTOR;
   if (toLowerCase() == carType) return ID_MOBIL;
    return ID_BUS;
  }

  bool isSelectedBike() {
    if(isEmpty) return false;
    if (toLowerCase() == motorType) return true;
    return false;
  }

  bool isSelectedCar() {
    if(isEmpty) return false;
    if (toLowerCase() == carType) return true;
    return false;
  }

  bool isSelectedBus() {
    if(isEmpty) return false;
    if (toLowerCase() == busType) return true;
    return false;
  }

}