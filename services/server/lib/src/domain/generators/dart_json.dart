import 'package:orchestrator/orchestrator.dart';
import 'package:recase/recase.dart';
import 'package:server/server.dart';

import '../../generated/io_apibuilder_generator_v0_json.dart' as i1;
import '../../generated/io_apibuilder_spec_v0_json.dart' as i2;

const unions = [
  'Nonet', 'Singlet', 'Doublet', 'Triplet', 'Quartet', 'Quintet', 'Sextet',
  'Septet', 'Octet', 'Nonet', //
];

const factories = [
  'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth',
  'ninth' //
];

class DartJson extends Generator {
  //
  const DartJson({
    required super.key,
    required super.name,
    required super.version,
  }) : super(
          description: 'Classes with toJson, fromJson, and copyWith methods.',
          language: 'dart',
          attributes: const [],
        );

  @override
  i1.Invocation build(
    i1.InvocationForm form,
  ) {
    final services = [form.service, ...?form.importedServices];

    final files = services //
        .map((v) => buildFile(v.namespace, services))
        .toList();

    return i1.Invocation(
      files: files,
      source: '',
    );
  }

  i1.File buildFile(
    String namespace,
    List<i2.Service> services,
  ) {
    final context = BuildContext(
      namespace: namespace,
      services: services,
    );

    final library = buildLibrary(context);

    return i1.File(
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
    i2.Enum enum_,
  ) {
    final enumDef = context.find(enum_.name);

    return Enum(
      name: enumDef.reference.symbol,
      values: () sync* {
        //
        for (final v in enum_.values) {
          yield EnumValue(
            v.name,
          );
        }
      }(),
    );
  }

  Class buildModel(
    BuildContext context,
    i2.Model model,
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
        buildCopyWith(context, model),
        buildModelProps(context, model),
      ],
    );
  }

  Constructor buildModelConstructor(
    BuildContext context,
    i2.Model model,
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
    i2.Model model,
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
    i2.Model model,
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

  Method buildCopyWith(
    BuildContext context,
    i2.Model model,
  ) {
    final modelDef = context.find(model.name);

    return Method(
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

          yield Parameter(
            name: name,
            type: fieldDef.reference,
            kind: ParameterKind.named,
          );
        }
      }(),
      body: () {
        //
        final List<Builder> arguments = [];

        for (final v in model.fields) {
          final name = getName(v.name);

          arguments.add(
            Static(name) //
                .ifNullThen(const Static('this').property(name))
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

  Method buildModelProps(
    BuildContext context,
    i2.Model model,
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
    i2.Union union,
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
      constructors: () sync* {
        //
        switch (version) {
          case GeneratorVersion.v215:
            yield Constructor(
              name: '_',
              parameters: [
                Parameter(
                  name: 'union',
                  type: TypeReference(
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
                ),
              ],
              initializers: () sync* {
                //
                yield invoke(
                  const Static('super'),
                  [const Static('union')],
                );
              }(),
            );
            break;

          case GeneratorVersion.v217:
            yield const Constructor(
              name: '_',
              parameters: [
                Parameter(
                  name: 'union',
                  isToSuper: true,
                ),
              ],
            );
            break;
        }

        yield buildUnionFromJson(context, union);
      }(),
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
    i2.Union union,
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

                    final a = typeDef.type is ModelTypeConfig //
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
    i2.Union union,
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
                final a = typeDef.type is ModelTypeConfig //
                    ? typeDef.deserializer('v')
                    : LiteralMap({
                        Literal.of('value'): typeDef.deserializer('v'),
                      });

                final b = Literal.of({
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
}
