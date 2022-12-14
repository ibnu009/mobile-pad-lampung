import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:pad_lampung/common/exception.dart';
import 'package:pad_lampung/common/failure.dart';
import 'package:dartz/dartz.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

abstract class NetworkService {
  Future<dynamic> getMethod(String endPoint,
      [Map<String, String>? headers]) async {
    try {
      final response = await http.get(Uri.parse(endPoint), headers: headers);
      logger.d("URL ${endPoint}");
      logger.d("Raw res is ${response.body}");

      var res = json.decode(response.body);
      logger.d(headers);
      logger.d(endPoint);
      logger.d(res);

      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> postMethod(String endPoint,
      {dynamic body, Map<String, String>? headers}) async {
    try {
      final response = await http.post(Uri.parse(endPoint),
          body: json.encode(body), headers: headers);

      logger.d(response.body);
      logger.d(headers);
      logger.d(body);
      logger.d(endPoint);
      print("json encode from server ${json.encode(body)}");
      print("response from server raw ${response.body}");
      print("status from server raw ${response.statusCode}");

      var res = json.decode(response.body);
      logger.d(res);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return res;
      }

      throw ServerException(response.body.toString());
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> multipartPost(String endPoint,
      {Map<String, String>? body,
      Map<String, String>? header,
      Map<String, File>? files}) async {
    try {
      var uri = Uri.parse(endPoint);
      var request = http.MultipartRequest("POST", uri);

      if (files!.isNotEmpty) {
        print('file is not empty');

        files.forEach((key, value) async {
          print('key i $key');
          print('value is $value');
          request.files.add(await http.MultipartFile.fromPath(key, value.path,
              contentType: MediaType('image', '*')));
        });
      }

      if (header != null) request.headers.addAll(header);
      if (body != null) request.fields.addAll(body);

      debugPrint('REQUEST IS ${request.files} with body ${request.fields}');

      var response = await request.send().then(http.Response.fromStream);
      var res = jsonDecode(response.body);

      logger.d(endPoint);
      logger.d(header);
      logger.d(body);
      logger.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> multipartPostNew(String endPoint,
      {Map<String, String>? body,
        Map<String, String>? header,
        required File file}) async {
    try {
      var uri = Uri.parse(endPoint);
      var request = http.MultipartRequest("POST", uri);

      request.files.add(await http.MultipartFile.fromPath('foto_kendaraan', file.path,
          contentType: MediaType('image', '*')));

      if (header != null) request.headers.addAll(header);
      if (body != null) request.fields.addAll(body);

      debugPrint('REQUEST IS ${request.files.single} with body ${request.fields}');

      var response = await request.send().then(http.Response.fromStream);
      var res = jsonDecode(response.body);

      logger.d(endPoint);
      logger.d(header);
      logger.d(body);
      logger.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> multipartUpdate(String endPoint,
      {Map<String, String>? body,
      Map<String, String>? header,
      Map<String, File>? files}) async {
    try {
      var uri = Uri.parse(endPoint);
      var request = http.MultipartRequest("PUT", uri);

      if (files!.isNotEmpty) {
        files.forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value.path,
              contentType: MediaType('image', '*')));
        });
      }

      request.headers.addAll(header!);
      if (body != null) request.fields.addAll(body);

      var response = await request.send().then(http.Response.fromStream);
      var res = jsonDecode(response.body);
      logger.d(endPoint);
      logger.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> putMethod(String endPoint,
      {dynamic body, Map<String, String>? header}) async {
    try {
      final response = await http.put(Uri.parse(endPoint),
          body: json.encode(body), headers: header);
      var res = json.decode(response.body);
      logger.d(endPoint);
      logger.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }

  Future<dynamic> deleteMethod(String endPoint,
      [Map<String, String>? headers]) async {
    try {
      final response = await http.delete(Uri.parse(endPoint), headers: headers);
      var res = json.decode(response.body);
      logger.d(endPoint);
      logger.d(res);
      return res;
    } on SocketException {
      throw Exception("Connection Failed");
    }
  }
}
