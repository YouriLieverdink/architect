import 'package:shared/shared.dart';

class BuildContext {
  //
  const BuildContext({
    required this.namespace,
    required this.services,
  });

  final String namespace;

  final List<IoApibuilderSpecV0ModelsService> services;

  IoApibuilderSpecV0ModelsService get service {
    return services //
        .where((service) => service.namespace == namespace)
        .first;
  }

  Set<String> types(
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
        //
        if (types(kind).contains(value)) {
          final type = Type.of(value, kind: kind, isNullable: isNullable);

          return Definition(
            this.namespace,
            type,
            isLocal: true,
          );
        }
      }

      // Will resolved to an unknown type.
      return Definition(
        this.namespace,
        Type.of('', isNullable: isNullable),
        isLocal: true,
      );
    }

    return Definition(
      namespace,
      Type.of(value, isNullable: isNullable),
    );
  }
}
