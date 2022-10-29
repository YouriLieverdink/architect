import 'package:architect/architect.dart';
import 'package:orchestrator/orchestrator.dart';

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
      body: buildSerializer(
        'v$depth',
        namespace,
        type.nested,
        isLocal: isLocal,
        depth: depth + 1,
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
      parameters: [
        Parameter(name: 'k$depth'),
        Parameter(name: 'v$depth'),
      ],
      body: invoke(
        const TypeReference('MapEntry', url: 'dart:core'),
        [
          Static('k$depth'),
          buildSerializer(
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
    const string = TypeReference(
      'String',
      url: 'dart:core',
    );

    switch (type.value) {
      case 'date-iso8601':
      case 'date-time-iso8601':
        final closure = const TypeReference('DateTime', url: 'dart:core')
            .property('parse')
            .invoke([Static(name).as(string)]);

        return type.isNullable //
            ? Static(name) //
                .equalTo(Literal.of(null))
                .conditional(Literal.of(null), closure)
            : closure;

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

    final filter = Method(
      lambda: true,
      parameters: [
        Parameter(name: 'v$depth'),
      ],
      body: Static('v$depth') //
          .property('value')
          .equalTo(Static(name).as(string)),
    );

    final closure = TypeReference(
      '${reference.symbol}EnumMap',
      url: reference.url,
    ) //
        .property('entries')
        .property('firstWhere')
        .invoke([filter]) //
        .property('key');

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
