const symbols = [
  'boolean', 'date-iso8601', 'date-time-iso8601', 'decimal', 'double',
  'integer', 'json', 'long', 'object', 'string', 'uuid', 'unit', //
];

const array = r'^\[(.+)\]$';
const map = r'^map\[(.+)\]$';

/// Returns `true` when the provided type name represents an array.
bool isArrayTypeName(
  String value,
) {
  return RegExp(array).hasMatch(value);
}

/// Returns `true` when the provided type name represents a map.
bool isMapTypeName(
  String value,
) {
  return RegExp(map).hasMatch(value);
}

/// Returns `true` when the provided type name is primitive in Apibuilder.
bool isPrimitiveTypeName(
  String value,
) {
  return symbols.contains(value);
}

/// Returns `true` when the provided type name is a model.
bool isModelTypeName(
  String value,
) {
  return value.contains('models');
}

/// Returns `true` when the provided type name is a enum.
bool isEnumTypeName(
  String value,
) {
  return value.contains('enums');
}

/// Returns `true` when the provided type name is a union.
bool isUnionTypeName(
  String value,
) {
  return value.contains('unions');
}

/// Returns the nested type name for the provided type name.
String getNestedTypeName(
  String value,
) {
  final mArray = RegExp(array).firstMatch(value);
  if (mArray != null) return mArray.group(1)!;

  final mMap = RegExp(map).firstMatch(value);
  if (mMap != null) return mMap.group(1)!;

  return value;
}

/// Returns the base type name for the provided type name.
String getBaseTypeName(
  String value,
) {
  final nested = getNestedTypeName(value);

  if (nested != value) {
    return getNestedTypeName(nested);
  }

  return value;
}

/// Returns the base type name without the namespace.
String getShortTypeName(
  String value,
) {
  final base = getBaseTypeName(value);
  final index = base.lastIndexOf('.');

  if (index == -1) {
    return value;
  }

  return base.substring(index + 1);
}

/// Returns the namespace without the base type name and kind.
String? getNamespace(
  String value,
) {
  final base = getBaseTypeName(value);
  final index = base.lastIndexOf('.');

  if (index == -1) {
    return null;
  }

  return base
      .substring(0, index)
      .replaceAll('.models', '')
      .replaceAll('.enums', '')
      .replaceAll('.unions', '');
}
