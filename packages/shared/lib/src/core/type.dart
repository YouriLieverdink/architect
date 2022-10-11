import 'package:shared/shared.dart';

abstract class TypeConfig {
  //
  const TypeConfig({
    this.isNullable = false,
  });

  factory TypeConfig.of(
    String value, {
    bool isNullable = false,
    String? kind,
  }) {
    final nested = getNestedTypeName(value);

    if (isArrayTypeName(value)) {
      return ArrayTypeConfig(
        TypeConfig.of(nested, kind: kind),
        isNullable: isNullable,
      );
    }

    if (isMapTypeName(value)) {
      return MapTypeConfig(
        TypeConfig.of(nested, kind: kind),
        isNullable: isNullable,
      );
    }

    if (isPrimitiveTypeName(value)) {
      return PrimitiveTypeConfig(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    if (isModelTypeName(value) || kind == 'models') {
      return ModelTypeConfig(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    if (isEnumTypeName(value) || kind == 'enums') {
      return EnumTypeConfig(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    if (isUnionTypeName(value) || kind == 'unions') {
      return UnionTypeConfig(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    return const UnknownTypeConfig();
  }

  final bool isNullable;
}

class UnknownTypeConfig extends TypeConfig {
  const UnknownTypeConfig();
}

abstract class EnclosingTypeConfig extends TypeConfig {
  const EnclosingTypeConfig(
    this.nested, {
    super.isNullable,
  });

  final TypeConfig nested;
}

class ArrayTypeConfig extends EnclosingTypeConfig {
  const ArrayTypeConfig(
    super.nested, {
    super.isNullable,
  });
}

class MapTypeConfig extends EnclosingTypeConfig {
  const MapTypeConfig(
    super.nested, {
    super.isNullable,
  });
}

abstract class BaseTypeConfig extends TypeConfig {
  const BaseTypeConfig(
    this.value, {
    super.isNullable,
  });

  final String value;
}

class PrimitiveTypeConfig extends BaseTypeConfig {
  const PrimitiveTypeConfig(
    super.value, {
    super.isNullable,
  });
}

class ModelTypeConfig extends BaseTypeConfig {
  const ModelTypeConfig(
    super.value, {
    super.isNullable,
  });
}

class EnumTypeConfig extends BaseTypeConfig {
  const EnumTypeConfig(
    super.value, {
    super.isNullable,
  });
}

class UnionTypeConfig extends BaseTypeConfig {
  const UnionTypeConfig(
    super.value, {
    super.isNullable,
  });
}
