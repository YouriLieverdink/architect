import 'package:orchestrator/orchestrator.dart' as i1;
import 'package:shared/shared.dart';

extension BuildDeserializer on Definition {
  //
  i1.Builder deserializer(
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

i1.Builder buildDeserializer(
  String name,
  String namespace,
  TypeConfig type, {
  bool isLocal = false,
}) {
  if (type is ArrayTypeConfig) {
    final closure = i1.Method(
      lambda: true,
      parameters: const [
        i1.Parameter(name: 'v'),
      ],
      body: buildDeserializer(
        'v',
        namespace,
        type.nested,
        isLocal: isLocal,
      ),
    );

    return i1.Static(name) //
        .property('map', isNullSafe: type.isNullable)
        .invoke([closure])
        .property('toList')
        .invoke();
  }

  if (type is MapTypeConfig) {
    final closure = i1.Method(
      lambda: true,
      parameters: const [
        i1.Parameter(name: 'k'),
        i1.Parameter(name: 'v'),
      ],
      // body: nested.deserializer('v'),
      body: i1.invoke(
        const i1.TypeReference('MapEntry', url: 'dart:core'),
        [
          const i1.Static('k'),
          buildDeserializer(
            'v',
            namespace,
            type.nested,
            isLocal: isLocal,
          ),
        ],
      ),
    );

    return i1.Static(name) //
        .property('map', isNullSafe: type.isNullable)
        .invoke([closure]);
  }

  if (type is PrimitiveTypeConfig) {
    switch (type.value) {
      case 'date-iso8601':
      case 'date-time-iso8601':
        return i1.Static(name) //
            .property('toIso8601String', isNullSafe: type.isNullable)
            .invoke();

      default:
        return i1.Static(name);
    }
  }

  if (type is ModelTypeConfig) {
    return i1.Static(name) //
        .property('toJson', isNullSafe: type.isNullable)
        .invoke();
  }

  if (type is EnumTypeConfig) {
    return i1.Static(name) //
        .property('name', isNullSafe: type.isNullable);
  }

  if (type is UnionType) {
    return i1.Static(name) //
        .property('toJson', isNullSafe: type.isNullable)
        .invoke();
  }

  return i1.Static(name);
}
