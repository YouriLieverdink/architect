import 'package:architect/architect.dart';
import 'package:orchestrator/orchestrator.dart';

extension BuildDeserializer on Definition {
  //
  Builder deserializer(
    String name,
  ) {
    return buildDeserializer(
      name,
      namespace,
      type,
      isLocal: isLocal,
    );
  }
}

Builder buildDeserializer(
  String name,
  String namespace,
  TypeConfig type, {
  bool isLocal = false,
  int depth = 0,
}) {
  final reference = buildReference(
    namespace,
    type,
    isLocal: isLocal,
  );

  if (type is ArrayTypeConfig) {
    final closure = Method(
      lambda: true,
      parameters: [
        Parameter(name: 'v$depth'),
      ],
      body: buildDeserializer(
        'v$depth',
        namespace,
        type.nested,
        isLocal: isLocal,
        depth: depth + 1,
      ),
    );

    return Static(name) //
        .property('map', isNullSafe: type.isNullable)
        .invoke([closure])
        .property('toList')
        .invoke();
  }

  if (type is MapTypeConfig) {
    final closure = Method(
      lambda: true,
      parameters: [
        Parameter(name: 'k$depth'),
        Parameter(name: 'v$depth'),
      ],
      // body: nested.deserializer('v'),
      body: invoke(
        const TypeReference('MapEntry', url: 'dart:core'),
        [
          Static('k$depth'),
          buildDeserializer(
            'v$depth',
            namespace,
            type.nested,
            isLocal: isLocal,
            depth: depth + 1,
          ),
        ],
      ),
    );

    return Static(name) //
        .property('map', isNullSafe: type.isNullable)
        .invoke([closure]);
  }

  if (type is PrimitiveTypeConfig) {
    switch (type.value) {
      case 'date-iso8601':
      case 'date-time-iso8601':
        return Static(name) //
            .property('toIso8601String', isNullSafe: type.isNullable)
            .invoke();

      default:
        return Static(name);
    }
  }

  if (type is ModelTypeConfig) {
    return Static(name) //
        .property('toJson', isNullSafe: type.isNullable)
        .invoke();
  }

  if (type is EnumTypeConfig) {
    return TypeReference(
      '${reference.symbol}EnumMap',
      url: reference.url,
    ) //
        .index(Static(name));
  }

  if (type is UnionTypeConfig) {
    return Static(name) //
        .property('toJson', isNullSafe: type.isNullable)
        .invoke();
  }

  return Static(name);
}
