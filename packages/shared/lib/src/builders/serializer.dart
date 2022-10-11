import 'package:orchestrator/orchestrator.dart' as i1;
import 'package:shared/shared.dart';

extension BuildSerializer on Definition {
  //
  i1.Builder serializer(
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

i1.Builder buildSerializer(
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
    final closure = i1.Method(
      lambda: true,
      parameters: const [
        i1.Parameter(name: 'v'),
      ],
      body: buildSerializer(
        'v',
        namespace,
        type.nested,
        isLocal: isLocal,
      ),
    );

    return i1.Static(name)
        .as(
          i1.TypeReference(
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
    final closure = i1.Method(
      lambda: true,
      parameters: const [
        i1.Parameter(name: 'k'),
        i1.Parameter(name: 'v'),
      ],
      body: i1.invoke(
        const i1.TypeReference('MapEntry', url: 'dart:core'),
        [
          const i1.Static('k'),
          buildSerializer(
            'v',
            namespace,
            type.nested,
            isLocal: isLocal,
          ),
        ],
      ),
    );

    return i1.Static(name) //
        .as(
          i1.TypeReference(
            'Map',
            url: 'dart:core',
            isNullable: type.isNullable,
          ),
        )
        .property('map', isNullSafe: type.isNullable)
        .invoke([closure]);
  }

  if (type is PrimitiveTypeConfig) {
    final string = i1.TypeReference(
      'String',
      url: 'dart:core',
      isNullable: type.isNullable,
    );

    switch (type.value) {
      case 'date-iso8601':
      case 'date-time-iso8601':
        return const i1.TypeReference('DateTime', url: 'dart:core')
            .property(type.isNullable ? 'tryParse' : 'parse')
            .invoke([i1.Static(name).as(string)]);

      default:
        return i1.Static(name).as(reference);
    }
  }

  if (type is ModelTypeConfig) {
    final closure = reference //
        .property('fromJson')
        .invoke([i1.Static(name)]);

    if (type.isNullable) {
      return i1.Static(name) //
          .equalTo(const i1.LiteralNull())
          .conditional(const i1.LiteralNull(), closure);
    }

    return closure;
  }

  if (type is EnumTypeConfig) {
    const string = i1.TypeReference('String', url: 'dart:core');

    final closure = reference //
        .property('values')
        .property('byName')
        .invoke([i1.Static(name).as(string)]);

    if (type.isNullable) {
      return i1.Static(name) //
          .equalTo(const i1.LiteralNull())
          .conditional(const i1.LiteralNull(), closure);
    }

    return closure;
  }

  if (type is UnionType) {
    final closure = reference //
        .property('fromJson')
        .invoke([i1.Static(name)]);

    if (type.isNullable) {
      return i1.Static(name) //
          .equalTo(const i1.LiteralNull())
          .conditional(const i1.LiteralNull(), closure);
    }

    return closure;
  }

  return i1.Static(name);
}
