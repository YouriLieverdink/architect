import 'package:orchestrator/orchestrator.dart';
import 'package:recase/recase.dart';
import 'package:shared/shared.dart';

IoApibuilderGeneratorV0ModelsInvocation buildDart217Client(
  IoApibuilderGeneratorV0ModelsInvocationForm form,
) {
  final services = [form.service, ...?form.importedServices];

  final file = _buildFile(form.service.namespace, services);

  return IoApibuilderGeneratorV0ModelsInvocation(
    files: [file],
    source: '',
  );
}

IoApibuilderGeneratorV0ModelsFile _buildFile(
  String namespace,
  List<IoApibuilderSpecV0ModelsService> services,
) {
  final context = BuildContext(
    namespace: namespace,
    services: services,
    isLocal: false,
  );

  final library = _buildLibrary(context);

  return IoApibuilderGeneratorV0ModelsFile(
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
  IoApibuilderSpecV0ModelsResource resource,
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
  IoApibuilderSpecV0ModelsOperation operation,
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
            final parameterDef = context.find(v.type);

            arguments.addAll({
              LiteralString(name): parameterDef.deserializer(name),
            });
          }

          yield const Static('queryParameters') //
              .declareFinal
              .assign(Literal.of(arguments))
              .statement;
        }

        yield const Static('');

        final uri = invoke(
          const TypeReference('Uri', url: 'dart:core'),
          () sync* {
            //
            yield Literal.of(context.service.baseUrl ?? '').named('host');

            final path = operation //
                .path
                .replaceAll(':', r'$');

            yield Literal.of(path).named('path');

            if (query.isNotEmpty) {
              yield const Static('queryParameters').named('queryParameters');
            }
          }(),
        );

        yield const Static('uri') //
            .declareFinal
            .assign(uri)
            .statement;

        yield const Static('');

        final arguments = () sync* {
          //
          yield const Static('uri');

          if (operation.body != null) {
            final bodyDef = context.find(operation.body!.type);

            yield bodyDef.deserializer('body').named('body');
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
