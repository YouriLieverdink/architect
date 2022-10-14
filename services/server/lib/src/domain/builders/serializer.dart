import 'package:orchestrator/orchestrator.dart';
import 'package:server/server.dart';

extension BuildSerializer on Definition {
  //
  Builder serializer(
    String name,
  ) {
    return buildSerializer(
      name,
      namespace,
      type,
      isLocal: isLocal,
    );
  }
}

Builder buildSerializer(
  String name,
  String namespace,
  TypeConfig type, {
  bool isLocal = false,
}) {
  final reference = buildReference(
    namespace,
    type,
    isLocal: isLocal,
  );

  if (type is ArrayTypeConfig) {
    final closure = Method(
      lambda: true,
      parameters: const [
        Parameter(name: 'v'),
      ],
      body: buildSerializer(
        'v',
        namespace,
        type.nested,
        isLocal: isLocal,
      ),
    );

    return Static(name)
        .as(
          TypeReference(
            'List',
            url: 'dart:core',
            isNullable: type.isNullable,
          ),
        )
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
      body: invoke(
        const TypeReference('MapEntry', url: 'dart:core'),
        [
          const Static('k'),
          buildSerializer(
            'v',
            namespace,
            type.nested,
            isLocal: isLocal,
          ),
        ],
      ),
    );

    return Static(name) //
        .as(
          TypeReference(
            'Map',
            url: 'dart:core',
            isNullable: type.isNullable,
          ),
        )
        .property('map', isNullSafe: type.isNullable)
        .invoke([closure]);
  }

  if (type is PrimitiveTypeConfig) {
    final string = TypeReference(
      'String',
      url: 'dart:core',
      isNullable: type.isNullable,
    );

    switch (type.value) {
      case 'date-iso8601':
      case 'date-time-iso8601':
        return const TypeReference('DateTime', url: 'dart:core')
            .property(type.isNullable ? 'tryParse' : 'parse')
            .invoke([Static(name).as(string)]);

      default:
        return Static(name).as(reference);
    }
  }

  if (type is ModelTypeConfig) {
    final closure = reference //
        .property('fromJson')
        .invoke([Static(name)]);

    if (type.isNullable) {
      return Static(name) //
          .equalTo(const LiteralNull())
          .conditional(const LiteralNull(), closure);
    }

    return closure;
  }

  if (type is EnumTypeConfig) {
    const string = TypeReference('String', url: 'dart:core');

    final closure = reference //
        .property('values')
        .property('byName')
        .invoke([Static(name).as(string)]);

    if (type.isNullable) {
      return Static(name) //
          .equalTo(const LiteralNull())
          .conditional(const LiteralNull(), closure);
    }

    return closure;
  }

  if (type is UnionTypeConfig) {
    final closure = reference //
        .property('fromJson')
        .invoke([Static(name)]);

    if (type.isNullable) {
      return Static(name) //
          .equalTo(const LiteralNull())
          .conditional(const LiteralNull(), closure);
    }

    return closure;
  }

  return Static(name);
}
