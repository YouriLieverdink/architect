import 'package:orchestrator/orchestrator.dart';
import 'package:recase/recase.dart';
import 'package:shared/shared.dart';

extension BuildReference on Definition {
  //
  TypeReference get reference {
    return buildReference(
      namespace,
      type,
      isLocal: isLocal,
    );
  }
}

TypeReference buildReference(
  String namespace,
  Type type, {
  bool isLocal = false,
}) {
  if (type is ArrayType) {
    return TypeReference(
      'List',
      url: 'dart:core',
      isNullable: type.isNullable,
      types: [
        buildReference(namespace, type.nested, isLocal: isLocal),
      ],
    );
  }

  if (type is MapType) {
    return TypeReference(
      'Map',
      url: 'dart:core',
      isNullable: type.isNullable,
      types: [
        const TypeReference('String', url: 'dart:core'),
        buildReference(namespace, type.nested, isLocal: isLocal),
      ],
    );
  }

  if (type is PrimitiveType) {
    TypeReference base(String value) {
      return TypeReference(
        value,
        url: 'dart:core',
        isNullable: type.isNullable,
      );
    }

    switch (type.value) {
      case 'boolean':
        return base('bool');

      case 'date-iso8601':
      case 'date-time-iso8601':
        return base('DateTime');

      case 'decimal':
      case 'double':
        return base('double');

      case 'integer':
      case 'long':
        return base('int');

      case 'string':
      case 'uuid':
        return base('String');

      case 'unit':
        return base('void');

      default:
        return base('dynamic');
    }
  }

  if (type is BaseType) {
    final short = getShortTypeName(type.value);

    return TypeReference(
      short.pascalCase,
      isNullable: type.isNullable,
      url: isLocal ? null : './${namespace.snakeCase}_json.dart',
    );
  }

  return const TypeReference(
    'dynamic',
    url: 'dart:core',
  );
}
