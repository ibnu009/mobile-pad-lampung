import 'package:flutter/material.dart';

class Event {
  Event({
    this.id,
    required this.date,
    this.title,
    this.description,
    this.location,
    this.icon,
    this.dot
  });

  int? id;
  DateTime date;
  String? title;
  String? description;
  String? location;
  Widget? icon;
  Widget? dot;
}