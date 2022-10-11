import 'package:orchestrator/orchestrator.dart' as i1;
import 'package:recase/recase.dart';
import 'package:server/server.dart';
import 'package:shared/shared.dart';

const unions = [
  'Nonet', 'Singlet', 'Doublet', 'Triplet', 'Quartet', 'Quintet', 'Sextet',
  'Septet', 'Octet', 'Nonet', //
];

const factories = [
  'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth',
  'ninth' //
];

Invocation buildDart217Json(
  InvocationForm form,
) {
  final services = [form.service, ...?form.importedServices];

  final files = services //
      .map((v) => buildFile(v.namespace, services))
      .toList();

  return Invocation(
    files: files,
    source: '',
  );
}

File buildFile(
  String namespace,
  List<Service> services,
) {
  final context = BuildContext(
    namespace: namespace,
    services: services,
  );

  final library = buildLibrary(context);

  return File(
    name: '${context.namespace.snakeCase}_json.dart',
    contents: emit(library),
  );
}

i1.Library buildLibrary(
  BuildContext context,
) {
  final name = '${context.namespace.snakeCase}_json';

  return i1.Library(
    docs: buildHeader('dart_2_17_json'),
    name: name,
    elements: () sync* {
      //
      for (final v in context.service.enums) {
        yield buildEnum(context, v);
      }

      for (final v in context.service.models) {
        yield buildModel(context, v);
      }

      for (final v in context.service.unions) {
        yield buildUnion(context, v);
      }
    }(),
  );
}

i1.Enum buildEnum(
  BuildContext context,
  Enum enum_,
) {
  final enumDef = context.find(enum_.name);

  return i1.Enum(
    name: enumDef.reference.symbol,
    values: () sync* {
      //
      for (final v in enum_.values) {
        yield i1.EnumValue(
          v.name,
        );
      }
    }(),
  );
}

i1.Class buildModel(
  BuildContext context,
  Model model,
) {
  final modelDef = context.find(model.name);

  return i1.Class(
    name: modelDef.reference.symbol,
    extends_: const i1.TypeReference(
      'Equatable',
      url: 'package:equatable/equatable.dart',
    ),
    constructors: [
      buildModelConstructor(context, model),
      buildModelFromJson(context, model),
    ],
    fields: () sync* {
      //
      for (final v in model.fields) {
        final name = getName(v.name);
        final fieldDef = context.find(
          v.type,
          isNullable: !v.required,
        );

        yield i1.Field(
          name: name,
          modifier: i1.FieldModifier.final_,
          type: fieldDef.reference,
        );
      }
    }(),
    methods: [
      buildModelToJson(context, model),
      buildCopyWith(context, model),
      buildModelProps(context, model),
    ],
  );
}

i1.Constructor buildModelConstructor(
  BuildContext context,
  Model model,
) {
  return i1.Constructor(
    isConst: true,
    parameters: () sync* {
      //
      for (final v in model.fields) {
        final name = getName(v.name);

        yield i1.Parameter(
          name: name,
          kind: i1.ParameterKind.named,
          isToThis: true,
          isRequired: v.required,
        );
      }
    }(),
  );
}

i1.Constructor buildModelFromJson(
  BuildContext context,
  Model model,
) {
  final modelDef = context.find(model.name);

  return i1.Constructor(
    isFactory: true,
    name: 'fromJson',
    parameters: const [
      i1.Parameter(
        name: 'json',
        type: i1.TypeReference(
          'dynamic',
          url: 'dart:core',
        ),
      ),
    ],
    body: () {
      //
      final List<i1.Builder> arguments = [];

      for (final v in model.fields) {
        final name = getName(v.name);
        final fieldDef = context.find(
          v.type,
          isNullable: !v.required,
        );

        arguments.add(
          fieldDef //
              .serializer("json['${v.name}']")
              .named(name),
        );
      }

      return modelDef //
          .reference
          .invoke(arguments)
          .returned
          .statement;
    }(),
  );
}

i1.Method buildModelToJson(
  BuildContext context,
  Model model,
) {
  return i1.Method(
    name: 'toJson',
    returns: const i1.TypeReference(
      'dynamic',
      url: 'dart:core',
    ),
    body: () {
      //
      final Map<i1.Builder, i1.Builder> arguments = {};

      for (final v in model.fields) {
        final name = getName(v.name);
        final fieldDef = context.find(
          v.type,
          isNullable: !v.required,
        );

        arguments.addAll({
          i1.LiteralString(v.name): fieldDef.deserializer(name),
        });
      }

      return i1.LiteralMap(arguments) //
          .returned
          .statement;
    }(),
  );
}

i1.Method buildCopyWith(
  BuildContext context,
  Model model,
) {
  final modelDef = context.find(model.name);

  return i1.Method(
    name: 'copyWith',
    returns: modelDef.reference,
    parameters: () sync* {
      //
      for (final v in model.fields) {
        final name = getName(v.name);
        final fieldDef = context.find(
          v.type,
          isNullable: true,
        );

        yield i1.Parameter(
          name: name,
          type: fieldDef.reference,
          kind: i1.ParameterKind.named,
        );
      }
    }(),
    body: () {
      //
      final List<i1.Builder> arguments = [];

      for (final v in model.fields) {
        final name = getName(v.name);

        arguments.add(
          i1.Static(name) //
              .ifNullThen(const i1.Static('this').property(name))
              .named(name),
        );
      }

      return modelDef //
          .reference
          .invoke(arguments)
          .returned
          .statement;
    }(),
  );
}

i1.Method buildModelProps(
  BuildContext context,
  Model model,
) {
  return i1.Method(
    annotations: const [
      i1.Annotation(
        type: i1.TypeReference(
          'override',
          url: 'dart:core',
        ),
      ),
    ],
    name: 'props',
    kind: i1.MethodKind.get,
    returns: const i1.TypeReference(
      'List',
      url: 'dart:core',
      types: [
        i1.TypeReference(
          'Object',
          url: 'dart:core',
          isNullable: true,
        ),
      ],
    ),
    body: () {
      //
      final List<i1.Builder> arguments = [];

      for (final v in model.fields) {
        final name = getName(v.name);

        arguments.add(
          i1.Static(name),
        );
      }

      return i1.LiteralList(arguments) //
          .returned
          .statement;
    }(),
  );
}

i1.Class buildUnion(
  BuildContext context,
  Union union,
) {
  final unionDef = context.find(union.name);

  // We need the number of types to create the correct reference.
  final n = union.types.length;

  return i1.Class(
    name: unionDef.reference.symbol,
    extends_: i1.TypeReference(
      'Union${n}Impl',
      url: 'package:sealed_unions/sealed_unions.dart',
      types: () sync* {
        //
        for (final v in union.types) {
          //
          final typeDef = context.find(v.type);

          yield typeDef.reference;
        }
      }(),
    ),
    constructors: [
      const i1.Constructor(
        name: '_',
        parameters: [
          i1.Parameter(
            name: 'union',
            isToSuper: true,
          ),
        ],
      ),
      buildUnionFromJson(context, union),
    ],
    fields: [
      i1.Field(
        name: 'factory',
        isStatic: true,
        modifier: i1.FieldModifier.const_,
        type: const i1.TypeReference(''),
        assign: () {
          //
          final reference = i1.TypeReference(
            unions[n],
            url: 'package:sealed_unions/sealed_unions.dart',
            types: () sync* {
              //
              for (final v in union.types) {
                final typeDef = context.find(v.type);

                yield typeDef.reference;
              }
            }(),
          );

          return reference.invoke();
        }(),
      ),
    ],
    methods: [
      buildUnionToJson(context, union),
    ],
  );
}

i1.Constructor buildUnionFromJson(
  BuildContext context,
  Union union,
) {
  final unionDef = context.find(union.name);

  return i1.Constructor(
    isFactory: true,
    name: 'fromJson',
    parameters: const [
      i1.Parameter(
        name: 'json',
        type: i1.TypeReference(
          'dynamic',
          url: 'dart:core',
        ),
      ),
    ],
    body: i1.Column(
      () sync* {
        //
        if (union.discriminator != null) {
          yield const i1.Static('type') //
              .declareFinal
              .assign(
                const i1.Static('json') //
                    .index(i1.LiteralString(union.discriminator!)),
              )
              .statement;
        } //
        else {
          yield const i1.Static('type') //
              .declareFinal
              .assign(
                const i1.Static('json')
                    .as(
                      const i1.TypeReference(
                        'Map',
                        url: 'dart:core',
                      ),
                    )
                    .property('keys')
                    .property('first'),
              )
              .statement;
        }

        yield const i1.Static('');

        yield i1.Switch(
          condition: const i1.Static('type'),
          cases: () sync* {
            //
            var index = 0;

            for (final v in union.types) {
              final typeDef = context.find(v.type);
              final discriminator = v.discriminatorValue ?? v.type;

              yield i1.SwitchCase(
                condition: i1.LiteralString(discriminator),
                body: () {
                  //
                  final selector = "json['$discriminator']";

                  final a = typeDef.type is ModelTypeConfig //
                      ? typeDef.serializer(selector)
                      : typeDef.serializer("$selector['value']");

                  final b = const i1.Static('factory') //
                      .property(factories[index])
                      .invoke([a]);

                  return unionDef //
                      .reference
                      .property('_')
                      .invoke([b])
                      .returned
                      .statement;
                }(),
              );

              index++;
            }
          }(),
          default_: () {
            //
            return const i1.TypeReference(
              'Exception',
              url: 'dart:core',
            ) //
                .invoke()
                .thrown
                .statement;
          }(),
        );
      }(),
    ),
  );
}

i1.Method buildUnionToJson(
  BuildContext context,
  Union union,
) {
  return i1.Method(
    name: 'toJson',
    returns: const i1.TypeReference(
      'dynamic',
      url: 'dart:core',
    ),
    body: () {
      //
      final List<i1.Builder> arguments = [];

      for (final v in union.types) {
        final typeDef = context.find(v.type);
        final discriminator = v.discriminatorValue ?? v.type;

        arguments.add(
          i1.Method(
            parameters: const [
              i1.Parameter(name: 'v'),
            ],
            body: () {
              //
              final a = typeDef.type is ModelTypeConfig //
                  ? typeDef.deserializer('v')
                  : i1.LiteralMap({
                      i1.Literal.of('value'): typeDef.deserializer('v'),
                    });

              final b = i1.Literal.of({
                i1.Literal.of(discriminator): a,
              });

              return b //
                  .returned
                  .statement;
            }(),
          ),
        );
      }

      return const i1.Static('join') //
          .invoke(arguments)
          .returned
          .statement;
    }(),
  );
}
