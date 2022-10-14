import 'package:orchestrator/orchestrator.dart';
import 'package:server/server.dart';

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
}) {
  if (type is ArrayTypeConfig) {
    final closure = Method(
      lambda: true,
      parameters: const [
        Parameter(name: 'v'),
      ],
      body: buildDeserializer(
        'v',
        namespace,
        type.nested,
        isLocal: isLocal,
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
      parameters: const [
        Parameter(name: 'k'),
        Parameter(name: 'v'),
      ],
      // body: nested.deserializer('v'),
      body: invoke(
        const TypeReference('MapEntry', url: 'dart:core'),
        [
          const Static('k'),
          buildDeserializer(
            'v',
            namespace,
            type.nested,
            isLocal: isLocal,
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
    return Static(name) //
        .property('name', isNullSafe: type.isNullable);
  }

  if (type is UnionTypeConfig) {
    return Static(name) //
        .property('toJson', isNullSafe: type.isNullable)
        .invoke();
  }

  return Static(name);
}
