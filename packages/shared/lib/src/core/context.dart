import 'package:shared/shared.dart';

class BuildContext {
  //
  const BuildContext({
    required this.namespace,
    required this.services,
    this.isLocal = true,
  });

  final String namespace;

  final List<IoApibuilderSpecV0ModelsService> services;

  final bool isLocal;

  IoApibuilderSpecV0ModelsService get service {
    return services //
        .where((service) => service.namespace == namespace)
        .first;
  }

  Set<String> _types(
    String kind,
  ) {
    switch (kind) {
      case 'models':
        return {...service.models.map((v) => v.name)};

      case 'enums':
        return {...service.enums.map((v) => v.name)};

      case 'unions':
        return {...service.unions.map((v) => v.name)};

      default:
        return const {};
    }
  }

  Definition find(
    String value, {
    bool isNullable = false,
  }) {
    final namespace = getNamespace(value);

    if (namespace == null) {
      // Check whether it's a model, enum, or union type.
      for (final kind in ['models', 'enums', 'unions']) {
        final base = getBaseTypeName(value);

        if (_types(kind).contains(base)) {
          final type = Type.of(value, kind: kind, isNullable: isNullable);

          return Definition(
            this.namespace,
            type,
            isLocal: isLocal,
          );
        }
      }

      return Definition(
        this.namespace,
        Type.of(value, isNullable: isNullable),
        isLocal: isLocal,
      );
    }

    return Definition(
      namespace,
      Type.of(value, isNullable: isNullable),
    );
  }
}
