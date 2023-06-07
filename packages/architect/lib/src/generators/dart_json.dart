import 'package:architect/architect.dart';
import 'package:orchestrator/orchestrator.dart';
import 'package:recase/recase.dart';

import '../generated/io_apibuilder_generator_v0_json.dart' as i1;
import '../generated/io_apibuilder_spec_v0_json.dart' as i2;

class DartJson extends Generator {
  //
  const DartJson({
    required super.key,
    required super.name,
    required super.version,
  }) : super(
          language: 'dart',
          description: 'Classes with toJson, fromJson, and copyWith methods',
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
      docs: () sync* {
        //
        if (context.service.description != null) {
          yield Docs('{@template $name}');

          if (context.service.description != null) {
            yield buildDescription(context.service.description!);
          }

          yield const Docs('{@endtemplate}');
        }
      }(),
      elements: () sync* {
        //
        for (final v in context.service.enums) {
          yield buildEnumMap(context, v);
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

  Element buildEnumMap(
    BuildContext context,
    i2.Enum enum_,
  ) {
    final enumDef = context.find(enum_.name);

    final Map<Builder, Builder> arguments = {};

    for (final v in enum_.values) {
      final name = getName(v.name);
      final value = v.value;

      if (value != null) {
        arguments.addAll({
          enumDef.reference.property(name): Literal.of(value),
        });
      } else {
        arguments.addAll({
          enumDef.reference.property(name): Literal.of(v.name),
        });
      }
    }

    return Static('${enumDef.reference.symbol}EnumMap')
        .declareConst
        .assign(Literal.of(arguments))
        .statement;
  }

  Enum buildEnum(
    BuildContext context,
    i2.Enum enum_,
  ) {
    final enumDef = context.find(enum_.name);

    return Enum(
      name: enumDef.reference.symbol,
      annotations: () sync* {
        //
        if (enum_.deprecation != null) {
          yield buildDeprecation(enum_.deprecation!);
        }
      }(),
      docs: () sync* {
        //
        if (enum_.description != null) {
          yield Docs('{@template ${enum_.name}}');

          if (enum_.description != null) {
            yield buildDescription(enum_.description!);
          }

          yield const Docs('{@endtemplate}');
        }
      }(),
      values: () sync* {
        //
        for (final v in enum_.values) {
          final name = getName(v.name);

          yield EnumValue(
            name,
            annotations: () sync* {
              //
              if (enum_.deprecation != null) {
                yield buildDeprecation(v.deprecation!);
              }
            }(),
            docs: () sync* {
              //
              if (v.description != null) {
                yield Docs('{@template ${v.name}}');

                if (v.description != null) {
                  yield buildDescription(v.description!);
                }

                yield const Docs('{@endtemplate}');
              }
            }(),
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
      annotations: () sync* {
        //
        if (model.deprecation != null) {
          yield buildDeprecation(model.deprecation!);
        }
      }(),
      docs: () sync* {
        //
        if (model.description != null) {
          yield Docs('{@template ${model.name}}');

          if (model.description != null) {
            yield buildDescription(model.description!);
          }

          yield const Docs('{@endtemplate}');
        }
      }(),
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
            annotations: () sync* {
              //
              if (v.deprecation != null) {
                yield buildDeprecation(v.deprecation!);
              }
            }(),
            docs: () sync* {
              //
              if (v.description != null) {
                yield buildDescription(v.description!);
              }
            }(),
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
      docs: () sync* {
        //
        if (model.description != null) {
          yield Docs('{@macro ${model.name}}');
        }
      }(),
      parameters: () sync* {
        //
        for (final v in model.fields) {
          final name = getName(v.name);

          yield Parameter(
            name: name,
            kind: ParameterKind.named,
            isToThis: true,
            isRequired: v.required,
            annotations: () sync* {
              //
              if (v.deprecation != null) {
                yield buildDeprecation(v.deprecation!);
              }
            }(),
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
            annotations: () sync* {
              //
              if (v.deprecation != null) {
                yield buildDeprecation(v.deprecation!);
              }
            }(),
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
      docs: () sync* {
        //
        if (union.description != null) {
          yield buildDescription(union.description!);
        }
      }(),
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
          case DartVersion.twoFifteen:
            yield Constructor(
              name: '_',
              parameters: [
                Parameter(
                  name: 'union',
                  type: TypeReference(
                    'Union$n',
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

          case DartVersion.twoSeventeen:
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
                    final a = () {
                      //
                      if (union.discriminator != null) {
                        return typeDef.type is ModelTypeConfig //
                            ? typeDef.serializer('json')
                            : typeDef.serializer("json['value']");
                      } //
                      else {
                        final selector = "json['$discriminator']";

                        return typeDef.type is ModelTypeConfig //
                            ? typeDef.serializer(selector)
                            : typeDef.serializer("$selector['value']");
                      }
                    }();

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
                Parameter(name: 'v0'),
              ],
              body: () {
                //
                final a = typeDef.type is ModelTypeConfig //
                    ? typeDef.deserializer('v0')
                    : Literal.of({
                        Literal.of('value'): typeDef.deserializer('v0'),
                      });

                final b = () {
                  //
                  if (union.discriminator != null) {
                    return LiteralSet({
                      Literal.of(discriminator)
                          .named("'${union.discriminator!}'"),
                      a.spread,
                    });
                  } //
                  else {
                    return LiteralMap({
                      Literal.of(discriminator): a,
                    });
                  }
                }();

                // final a = Literal.of({
                //   LiteralString(discriminator)
                //       .named("'${union.discriminator}'"),
                //   typeDef.deserializer('v').spread,
                // });
                // final a = typeDef.type is ModelTypeConfig //
                //     ? typeDef.deserializer('v')
                //     : LiteralMap({
                //         Literal.of('value'): typeDef.deserializer('v'),
                //       });

                // final b = Literal.of({
                //   Literal.of(discriminator): a,
                // });

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
