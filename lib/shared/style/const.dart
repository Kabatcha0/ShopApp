import 'package:flutter/material.dart';
import 'package:shopapp/networks/local/chachehelper.dart';

const primary = Colors.deepPurple;
const String url = "https://student.valuxapps.com/api/";
void printFull(String? text) {
  final pattern = RegExp(".{1,800}"); //800 is the size of each chunk
  pattern.allMatches(text!).forEach((match) {
    print(match.group(0));
  });
}

String? token;
