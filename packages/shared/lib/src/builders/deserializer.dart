import 'package:orchestrator/orchestrator.dart';
import 'package:shared/shared.dart';

extension BuildDeserializer on Definition {
  //
  Element deserializer(
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

Element buildDeserializer(
  String name,
  String namespace,
  Type type, {
  bool isLocal = false,
}) {
  if (type is ArrayType) {
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

  if (type is MapType) {
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

  if (type is PrimitiveType) {
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

  if (type is ModelType) {
    return Static(name) //
        .property('toJson', isNullSafe: type.isNullable)
        .invoke();
  }

  if (type is EnumType) {
    return Static(name) //
        .property('name', isNullSafe: type.isNullable);
  }

  if (type is UnionType) {
    return Static(name) //
        .property('toJson', isNullSafe: type.isNullable)
        .invoke();
  }

  return Static(name);
}
