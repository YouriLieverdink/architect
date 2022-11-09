import 'package:architect/architect.dart';
import 'package:orchestrator/orchestrator.dart';
import 'package:recase/recase.dart';

import '../generated/io_apibuilder_generator_v0_json.dart' as i1;
import '../generated/io_apibuilder_spec_v0_json.dart' as i2;

class DartClient extends Generator {
  //
  const DartClient({
    required super.key,
    required super.name,
    required super.version,
  }) : super(
          language: 'dart',
          description: 'Complete Http client using the Dart http package.',
          attributes: const [],
        );

  @override
  i1.Invocation build(
    i1.InvocationForm form,
  ) {
    final services = [form.service, ...?form.importedServices];

    final file = _buildFile(form.service.namespace, services);

    return i1.Invocation(
      files: [file],
      source: '',
    );
  }

  i1.File _buildFile(
    String namespace,
    List<i2.Service> services,
  ) {
    final context = BuildContext(
      namespace: namespace,
      services: services,
      isLocal: false,
    );

    final library = _buildLibrary(context);

    return i1.File(
      name: '${context.namespace.snakeCase}_client.dart',
      contents: emit(library),
    );
  }

  Library _buildLibrary(
    BuildContext context,
  ) {
    final name = '${context.namespace.snakeCase}_client';

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
        for (final v in context.service.resources) {
          yield _buildResource(context, v);
        }

        yield _buildClient(context);
      }(),
    );
  }

  Class _buildResource(
    BuildContext context,
    i2.Resource resource,
  ) {
    final resourceDef = context.find(resource.type);

    return Class(
      name: '${resourceDef.reference.symbol}Resource',
      docs: () sync* {
        //
        if (resource.description != null) {
          yield Docs('{@template ${resource.type}}');

          if (resource.description != null) {
            yield buildDescription(resource.description!);
          }

          yield const Docs('{@endtemplate}');
        }
      }(),
      constructors: () sync* {
        //
        yield Constructor(
          isConst: true,
          docs: () sync* {
            //
            if (resource.description != null) {
              yield Docs('{@macro ${resource.type}}');
            }
          }(),
          parameters: () sync* {
            //
            yield const Parameter(
              name: 'client',
              kind: ParameterKind.named,
              isToThis: true,
              isRequired: true,
            );

            yield const Parameter(
              name: 'baseUrl',
              kind: ParameterKind.named,
              isToThis: true,
              isRequired: true,
            );
          }(),
        );
      }(),
      fields: () sync* {
        //
        yield const Field(
          name: 'client',
          type: TypeReference(
            'Client',
            url: 'package:http/http.dart',
          ),
          modifier: FieldModifier.final_,
        );

        yield const Field(
          name: 'baseUrl',
          type: TypeReference(
            'String',
            url: 'dart:core',
          ),
          modifier: FieldModifier.final_,
        );
      }(),
      methods: () sync* {
        //
        for (final v in resource.operations) {
          yield _buildOperation(context, v);
        }
      }(),
    );
  }

  Method _buildOperation(
    BuildContext context,
    i2.Operation operation,
  ) {
    final name = () {
      //
      final method = operation.method.name.camelCase;
      final parameter = RegExp(r':(\w+)');

      final resources = operation.path //
          .split('/')
          .where((v) => !parameter.hasMatch(v))
          .skip(2);

      final parameters = operation.path //
          .split('/')
          .where((v) => parameter.hasMatch(v))
          .map((v) => parameter.firstMatch(v));

      // We compose the name out of the method, resources, and parameters.
      final name = StringBuffer();

      name.write(method);

      for (final v in resources) {
        name.write(v.pascalCase);
      }

      if (parameters.isNotEmpty) {
        name.write('By');

        for (final v in parameters) {
          name.write(v![1]);
        }
      }

      return '$name';
    }();

    return Method(
      name: name,
      docs: () sync* {
        //
        if (operation.description != null) {
          yield buildDescription(operation.description!);
        }
      }(),
      annotations: () sync* {
        //
        if (operation.deprecation != null) {
          yield buildDeprecation(operation.deprecation!);
        }
      }(),
      modifier: MethodMofifier.async,
      returns: () {
        //
        final responseDef = context.find(
          operation.responses.first.type,
        );

        return TypeReference(
          'Future',
          url: 'dart:core',
          types: [
            responseDef.reference,
          ],
        );
      }(),
      parameters: () sync* {
        //
        if (operation.body != null) {
          final bodyDef = context.find(operation.body!.type);

          yield Parameter(
            name: 'body',
            type: bodyDef.reference,
            annotations: () sync* {
              //
              if (operation.body!.deprecation != null) {
                yield buildDeprecation(operation.body!.deprecation!);
              }
            }(),
          );
        }

        for (final v in operation.parameters) {
          final name = getName(v.name);
          final parameterDef = context.find(
            v.type,
            isNullable: !v.required,
          );

          yield Parameter(
            name: name,
            type: parameterDef.reference,
            kind: ParameterKind.named,
            isRequired: v.required && v.default_ == null,
            assign: () {
              //
              if (v.default_ != null) {
                return Static(v.default_!);
              }
            }(),
            annotations: () sync* {
              //
              if (v.deprecation != null) {
                yield buildDeprecation(v.deprecation!);
              }
            }(),
          );
        }
      }(),
      body: Column(
        () sync* {
          //
          final query = operation.parameters //
              .where((v) => v.location.name == 'Query')
              .toList();

          if (query.isNotEmpty) {
            final Map<Builder, Builder> arguments = {};

            for (final v in query) {
              final name = getName(v.name);
              final parameterDef = context.find(
                v.type,
                isNullable: !v.required,
              );

              arguments.addAll({
                LiteralString(name): parameterDef //
                    .deserializer(name)
                    .property('toString', isNullSafe: !v.required)
                    .invoke(),
              });
            }

            yield const Static('query') //
                .declareFinal
                .assign(Literal.of(arguments))
                .statement;
          }

          yield const Static('');

          final path = operation //
              .path
              .replaceAll(':', r'$');

          var uri = const TypeReference('Uri', url: 'dart:core') //
              .property('parse')
              .invoke([Literal.of('\$baseUrl$path')]);

          if (query.isNotEmpty) {
            uri = uri //
                .property('replace')
                .invoke([const Static('query').named('queryParameters')]);
          }

          yield const Static('uri') //
              .declareFinal
              .assign(uri)
              .statement;

          yield const Static('');

          final arguments = () sync* {
            //
            yield const Static('uri');

            if (operation.body != null) {
              yield const TypeReference('jsonEncode', url: 'dart:convert')
                  .invoke([const Static('body')]) //
                  .named('body');
            }
          }();

          final request = const Static('client') //
              .property(operation.method.name.camelCase)
              .invoke(arguments) //
              .awaited;

          yield const Static('response') //
              .declareFinal
              .assign(request)
              .statement;

          yield const Static('');

          yield Switch(
            condition: const Static('response').property('statusCode'),
            cases: () sync* {
              //
              for (final v in operation.responses) {
                final responseDef = context.find(v.type);

                final code = v.code.join((v) => v, (v) => 0);

                yield SwitchCase(
                  condition: Literal.of(code),
                  body: Column(
                    () sync* {
                      //
                      if (v.type != 'unit') {
                        final decode = invoke(
                          const TypeReference(
                            'jsonDecode',
                            url: 'dart:convert',
                          ),
                          [
                            const Static('response').property('body'),
                          ],
                        );

                        yield const Static('json') //
                            .declareFinal
                            .assign(decode)
                            .statement;

                        yield const Static('');

                        if (code >= 200 && code < 300) {
                          yield responseDef //
                              .serializer('json')
                              .returned
                              .statement;
                        } //
                        else {
                          yield responseDef //
                              .serializer('json')
                              .thrown
                              .statement;
                        }
                      } //
                      else {
                        if (code >= 200 && code < 300) {
                          yield const Static('break').statement;
                        } //
                        else {
                          yield invoke(
                            const TypeReference(
                              'Exception',
                              url: 'dart:core',
                            ),
                            [],
                          ).thrown.statement;
                        }
                      }
                    }(),
                  ),
                );
              }
            }(),
            default_: () {
              //
              return invoke(
                const TypeReference(
                  'Exception',
                  url: 'dart:core',
                ),
                [],
              ).thrown.statement;
            }(),
          );
        }(),
      ),
    );
  }

  Class _buildClient(
    BuildContext context,
  ) {
    return Class(
      name: 'Client',
      constructors: () sync* {
        //
        yield Constructor(
          isConst: true,
          parameters: () sync* {
            //
            yield const Parameter(
              name: 'client',
              kind: ParameterKind.named,
              isToThis: true,
              isRequired: true,
            );

            yield const Parameter(
              name: 'baseUrl',
              kind: ParameterKind.named,
              isToThis: true,
              isRequired: true,
            );
          }(),
        );
      }(),
      fields: () sync* {
        //
        yield const Field(
          name: 'client',
          type: TypeReference(
            'Client',
            url: 'package:http/http.dart',
          ),
          modifier: FieldModifier.final_,
        );

        yield const Field(
          name: 'baseUrl',
          type: TypeReference(
            'String',
            url: 'dart:core',
          ),
          modifier: FieldModifier.final_,
        );
      }(),
      methods: () sync* {
        //
        for (final v in context.service.resources) {
          final resourceDef = context.find(v.type);

          yield Method(
            annotations: () sync* {
              //
              if (v.deprecation != null) {
                yield buildDeprecation(v.deprecation!);
              }
            }(),
            docs: () sync* {
              //
              if (v.description != null) {
                yield Docs('{@macro ${v.type}}');
              }
            }(),
            name: v.plural.camelCase,
            kind: MethodKind.get,
            returns: TypeReference(
              '${resourceDef.reference.symbol}Resource',
            ),
            body: () {
              //
              final resource = invoke(
                Static('${resourceDef.reference.symbol}Resource'),
                [
                  const Static('client').named('client'),
                  const Static('baseUrl').named('baseUrl'),
                ],
              );

              return resource //
                  .returned
                  .statement;
            }(),
          );
        }
      }(),
    );
  }
}
