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
      final match = RegExp(r':(\w+)').firstMatch(operation.path);

      if (match != null) {
        return '$method-by-${match[1]}'.camelCase;
      }

      return method;
    }();

    return Method(
      name: name,
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
              .invoke([const Static('baseUrl')]);

          if (path.isNotEmpty && path != '/') {
            uri = uri //
                .property('replace')
                .invoke([Literal.of(path).named('path')]);
          }

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
