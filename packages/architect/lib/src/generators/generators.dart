import 'package:architect/architect.dart';

export './dart_client.dart';
export './dart_json.dart';

const generators = [
  DartJson(
    key: 'dart_2_15_json',
    name: 'Dart 2.15 json',
    version: DartVersion.twoFifteen,
  ),
  DartJson(
    key: 'dart_2_17_json',
    name: 'Dart 2.17 json',
    version: DartVersion.twoSeventeen,
  ),
  DartClient(
    key: 'dart_2_15_client',
    name: 'Dart 2.15 client',
    version: DartVersion.twoFifteen,
  ),
  DartClient(
    key: 'dart_2_17_client',
    name: 'Dart 2.17 client',
    version: DartVersion.twoSeventeen,
  ),
];
