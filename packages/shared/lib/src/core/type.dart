import 'package:shared/shared.dart';

abstract class Type {
  //
  const Type({
    this.isNullable = false,
  });

  factory Type.of(
    String value, {
    bool isNullable = false,
    String? kind,
  }) {
    final nested = getNestedTypeName(value);

    if (isArrayTypeName(value)) {
      return ArrayType(
        Type.of(nested, kind: kind),
        isNullable: isNullable,
      );
    }

    if (isMapTypeName(value)) {
      return MapType(
        Type.of(nested, kind: kind),
        isNullable: isNullable,
      );
    }

    if (isPrimitiveTypeName(value)) {
      return PrimitiveType(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    if (isModelTypeName(value) || kind == 'models') {
      return ModelType(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    if (isEnumTypeName(value) || kind == 'enums') {
      return EnumType(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    if (isUnionTypeName(value) || kind == 'unions') {
      return UnionType(
        getShortTypeName(value),
        isNullable: isNullable,
      );
    }

    return const UnknownType();
  }

  final bool isNullable;
}

class UnknownType extends Type {
  const UnknownType();
}

abstract class EnclosingType extends Type {
  const EnclosingType(
    this.nested, {
    super.isNullable,
  });

  final Type nested;
}

class ArrayType extends EnclosingType {
  const ArrayType(
    super.nested, {
    super.isNullable,
  });
}

class MapType extends EnclosingType {
  const MapType(
    super.nested, {
    super.isNullable,
  });
}

abstract class BaseType extends Type {
  const BaseType(
    this.value, {
    super.isNullable,
  });

  final String value;
}

class PrimitiveType extends BaseType {
  const PrimitiveType(
    super.value, {
    super.isNullable,
  });
}

class ModelType extends BaseType {
  const ModelType(
    super.value, {
    super.isNullable,
  });
}

class EnumType extends BaseType {
  const EnumType(
    super.value, {
    super.isNullable,
  });
}

class UnionType extends BaseType {
  const UnionType(
    super.value, {
    super.isNullable,
  });
}
