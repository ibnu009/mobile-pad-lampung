import 'dart:math';

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));