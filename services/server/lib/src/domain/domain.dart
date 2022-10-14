import 'package:server/server.dart';

export './builders/builders.dart';
export './core/core.dart';
export './generators/generators.dart';
export './utilities/utilities.dart';

const generators = [
  DartJson(
    key: 'dart_2_15_json',
    name: 'Dart 2.15. json',
    version: GeneratorVersion.v215,
  ),
  DartJson(
    key: 'dart_2_17_json',
    name: 'Dart 2.17. json',
    version: GeneratorVersion.v217,
  ),
  DartClient(
    key: 'dart_2_15_client',
    name: 'Dart 2.15. client',
    version: GeneratorVersion.v215,
  ),
  DartClient(
    key: 'dart_2_17_client',
    name: 'Dart 2.17. client',
    version: GeneratorVersion.v217,
  ),
];
