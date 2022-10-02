import 'package:orchestrator/orchestrator.dart';
import 'package:recase/recase.dart';
import 'package:shared/shared.dart';

const unions = [
  'Nonet', 'Singlet', 'Doublet', 'Triplet', 'Quartet', 'Quintet', 'Sextet',
  'Septet', 'Octet', 'Nonet', //
];

const factories = [
  'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth',
  'ninth' //
];

IoApibuilderGeneratorV0ModelsInvocation buildDart217Json(
  IoApibuilderGeneratorV0ModelsInvocationForm form,
) {
  final services = [form.service, ...?form.importedServices];

  final files = services //
      .map((v) => buildFile(v.namespace, services))
      .toList();

  return IoApibuilderGeneratorV0ModelsInvocation(
    files: files,
    source: '',
  );
}

IoApibuilderGeneratorV0ModelsFile buildFile(
  String namespace,
  List<IoApibuilderSpecV0ModelsService> services,
) {
  final context = BuildContext(
    namespace: namespace,
    services: services,
  );

  final library = buildLibrary(context);

  return IoApibuilderGeneratorV0ModelsFile(
    name: '${context.namespace.snakeCase}_json.dart',
    contents: emit(library),
  );
}

Library buildLibrary(
  BuildContext context,
) {
  final name = '${context.namespace.snakeCase}_json';

  return Library(
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

Enum buildEnum(
  BuildContext context,
  IoApibuilderSpecV0ModelsEnum enum_,
) {
  final enumDef = context.find(enum_.name);

  return Enum(
    name: enumDef.reference.symbol,
    values: () sync* {
      //
      for (final v in enum_.values) {
        final name = getName(v.name);

        yield EnumValue(
          name,
        );
      }
    }(),
  );
}

Class buildModel(
  BuildContext context,
  IoApibuilderSpecV0ModelsModel model,
) {
  final modelDef = context.find(model.name);

  return Class(
    name: modelDef.reference.symbol,
    extends_: const TypeReference(
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

        yield Field(
          name: name,
          modifier: FieldModifier.final_,
          type: fieldDef.reference,
        );
      }
    }(),
    methods: [
      buildModelToJson(context, model),
      buildModelProps(context, model),
    ],
  );
}

Constructor buildModelConstructor(
  BuildContext context,
  IoApibuilderSpecV0ModelsModel model,
) {
  return Constructor(
    isConst: true,
    parameters: () sync* {
      //
      for (final v in model.fields) {
        final name = getName(v.name);

        yield Parameter(
          name: name,
          kind: ParameterKind.named,
          isToThis: true,
          isRequired: v.required,
        );
      }
    }(),
  );
}

Constructor buildModelFromJson(
  BuildContext context,
  IoApibuilderSpecV0ModelsModel model,
) {
  final modelDef = context.find(model.name);

  return Constructor(
    isFactory: true,
    name: 'fromJson',
    parameters: const [
      Parameter(
        name: 'json',
        type: TypeReference(
          'dynamic',
          url: 'dart:core',
        ),
      ),
    ],
    body: () {
      //
      final List<Builder> arguments = [];

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

Method buildModelToJson(
  BuildContext context,
  IoApibuilderSpecV0ModelsModel model,
) {
  return Method(
    name: 'toJson',
    returns: const TypeReference(
      'dynamic',
      url: 'dart:core',
    ),
    body: () {
      //
      final Map<Builder, Builder> arguments = {};

      for (final v in model.fields) {
        final name = getName(v.name);
        final fieldDef = context.find(
          v.type,
          isNullable: !v.required,
        );

        arguments.addAll({
          LiteralString(v.name): fieldDef.deserializer(name),
        });
      }

      return LiteralMap(arguments) //
          .returned
          .statement;
    }(),
  );
}

Method buildModelProps(
  BuildContext context,
  IoApibuilderSpecV0ModelsModel model,
) {
  return Method(
    annotations: const [
      Annotation(
        type: TypeReference(
          'override',
          url: 'dart:core',
        ),
      ),
    ],
    name: 'props',
    kind: MethodKind.get,
    returns: const TypeReference(
      'List',
      url: 'dart:core',
      types: [
        TypeReference(
          'Object',
          url: 'dart:core',
          isNullable: true,
        ),
      ],
    ),
    body: () {
      //
      final List<Builder> arguments = [];

      for (final v in model.fields) {
        final name = getName(v.name);

        arguments.add(
          Static(name),
        );
      }

      return LiteralList(arguments) //
          .returned
          .statement;
    }(),
  );
}

Class buildUnion(
  BuildContext context,
  IoApibuilderSpecV0ModelsUnion union,
) {
  final unionDef = context.find(union.name);

  // We need the number of types to create the correct reference.
  final n = union.types.length;

  return Class(
    name: unionDef.reference.symbol,
    extends_: TypeReference(
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
      const Constructor(
        name: '_',
        parameters: [
          Parameter(
            name: 'union',
            isToSuper: true,
          ),
        ],
      ),
      buildUnionFromJson(context, union),
    ],
    fields: [
      Field(
        name: 'factory',
        isStatic: true,
        modifier: FieldModifier.const_,
        type: const TypeReference(''),
        assign: () {
          //
          final reference = TypeReference(
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

Constructor buildUnionFromJson(
  BuildContext context,
  IoApibuilderSpecV0ModelsUnion union,
) {
  final unionDef = context.find(union.name);

  return Constructor(
    isFactory: true,
    name: 'fromJson',
    parameters: const [
      Parameter(
        name: 'json',
        type: TypeReference(
          'dynamic',
          url: 'dart:core',
        ),
      ),
    ],
    body: Column(
      () sync* {
        //
        if (union.discriminator != null) {
          yield const Static('type') //
              .declareFinal
              .assign(
                const Static('json') //
                    .index(LiteralString(union.discriminator!)),
              )
              .statement;
        } //
        else {
          yield const Static('type') //
              .declareFinal
              .assign(
                const Static('json')
                    .as(
                      const TypeReference(
                        'Map',
                        url: 'dart:core',
                      ),
                    )
                    .property('keys')
                    .property('first'),
              )
              .statement;
        }

        yield const Static('');

        yield Switch(
          condition: const Static('type'),
          cases: () sync* {
            //
            var index = 0;

            for (final v in union.types) {
              final typeDef = context.find(v.type);
              final discriminator = v.discriminatorValue ?? v.type;

              yield SwitchCase(
                condition: LiteralString(discriminator),
                body: () {
                  //
                  final selector = "json['$discriminator']";

                  final a = typeDef.type is ModelType //
                      ? typeDef.serializer(selector)
                      : typeDef.serializer("$selector['value']");

                  final b = const Static('factory') //
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
            return const TypeReference(
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

Method buildUnionToJson(
  BuildContext context,
  IoApibuilderSpecV0ModelsUnion union,
) {
  return Method(
    name: 'toJson',
    returns: const TypeReference(
      'dynamic',
      url: 'dart:core',
    ),
    body: () {
      //
      final List<Builder> arguments = [];

      for (final v in union.types) {
        final typeDef = context.find(v.type);
        final discriminator = v.discriminatorValue ?? v.type;

        arguments.add(
          Method(
            parameters: const [
              Parameter(name: 'v'),
            ],
            body: () {
              //
              final a = typeDef.type is ModelType //
                  ? typeDef.deserializer('v')
                  : LiteralMap({
                      const LiteralString('value'): typeDef.deserializer('v'),
                    });

              final b = LiteralMap({
                Literal.of(discriminator): a,
              });

              return b //
                  .returned
                  .statement;
            }(),
          ),
        );
      }

      return const Static('join') //
          .invoke(arguments)
          .returned
          .statement;
    }(),
  );
}
