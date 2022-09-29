import 'package:server/server.dart';

export './common/common.dart';
export './generators/generators.dart';

const generators = [
  InvokableGenerator(
    key: 'dart_2_17_json',
    name: 'Dart 2.17 json',
    description: 'Classes with toJson, fromJson, and copyWith methods.',
    language: 'dart',
    attributes: [],
    invoke: dart217Json,
  ),
];
