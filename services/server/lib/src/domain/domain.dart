import 'package:server/server.dart';

export './common/common.dart';
export './generators/generators.dart';

final generators = [
  const InvokableGenerator(
    key: 'dart_2_17_client',
    name: 'Dart 2.17 client',
    description: 'An http client for every defined operation.',
    language: 'dart',
    attributes: [],
    build: buildDart217Client,
  ),
  InvokableGenerator(
    key: 'dart_2_15_json',
    name: 'Dart 2.15 json',
    description: 'Classes with toJson, fromJson, and copyWith methods.',
    language: 'dart',
    attributes: const [],
    build: const DartJson(version: DartJsonVersion.v215).build,
  ),
  InvokableGenerator(
    key: 'dart_2_17_json',
    name: 'Dart 2.17 json',
    description: 'Classes with toJson, fromJson, and copyWith methods.',
    language: 'dart',
    attributes: const [],
    build: const DartJson(version: DartJsonVersion.v217).build,
  ),
];
