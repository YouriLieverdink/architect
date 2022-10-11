import 'package:orchestrator/orchestrator.dart' as i1;
import 'package:recase/recase.dart';
import 'package:server/server.dart';
import 'package:shared/shared.dart';

Invocation buildDart217Client(
  InvocationForm form,
) {
  final services = [form.service, ...?form.importedServices];

  final file = _buildFile(form.service.namespace, services);

  return Invocation(
    files: [file],
    source: '',
  );
}

File _buildFile(
  String namespace,
  List<Service> services,
) {
  final context = BuildContext(
    namespace: namespace,
    services: services,
    isLocal: false,
  );

  final library = _buildLibrary(context);

  return File(
    name: '${context.namespace.snakeCase}_client.dart',
    contents: emit(library),
  );
}

i1.Library _buildLibrary(
  BuildContext context,
) {
  final name = '${context.namespace.snakeCase}_client';

  return i1.Library(
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

i1.Class _buildResource(
  BuildContext context,
  Resource resource,
) {
  final resourceDef = context.find(resource.type);

  return i1.Class(
    name: '${resourceDef.reference.symbol}Resource',
    constructors: () sync* {
      //
      yield i1.Constructor(
        isConst: true,
        parameters: () sync* {
          //
          yield const i1.Parameter(
            name: 'client',
            kind: i1.ParameterKind.named,
            isToThis: true,
            isRequired: true,
          );

          yield const i1.Parameter(
            name: 'baseUrl',
            kind: i1.ParameterKind.named,
            isToThis: true,
            isRequired: true,
          );
        }(),
      );
    }(),
    fields: () sync* {
      //
      yield const i1.Field(
        name: 'client',
        type: i1.TypeReference(
          'Client',
          url: 'package:http/http.dart',
        ),
        modifier: i1.FieldModifier.final_,
      );

      yield const i1.Field(
        name: 'baseUrl',
        type: i1.TypeReference(
          'String',
          url: 'dart:core',
        ),
        modifier: i1.FieldModifier.final_,
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

i1.Method _buildOperation(
  BuildContext context,
  Operation operation,
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

  return i1.Method(
    name: name,
    modifier: i1.MethodMofifier.async,
    returns: () {
      //
      final responseDef = context.find(
        operation.responses.first.type,
      );

      return i1.TypeReference(
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

        yield i1.Parameter(
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

        yield i1.Parameter(
          name: name,
          type: parameterDef.reference,
          kind: i1.ParameterKind.named,
          isRequired: v.required && v.default_ == null,
          assign: () {
            //
            if (v.default_ != null) {
              return i1.Static(v.default_!);
            }
          }(),
        );
      }
    }(),
    body: i1.Column(
      () sync* {
        //
        final query = operation.parameters //
            .where((v) => v.location.name == 'Query')
            .toList();

        if (query.isNotEmpty) {
          final Map<i1.Builder, i1.Builder> arguments = {};

          for (final v in query) {
            final name = getName(v.name);
            final parameterDef = context.find(
              v.type,
              isNullable: !v.required,
            );

            arguments.addAll({
              i1.LiteralString(name): parameterDef //
                  .deserializer(name)
                  .property('toString', isNullSafe: !v.required)
                  .invoke(),
            });
          }

          yield const i1.Static('query') //
              .declareFinal
              .assign(i1.Literal.of(arguments))
              .statement;
        }

        yield const i1.Static('');

        final path = operation //
            .path
            .replaceAll(':', r'$');

        var uri = const i1.TypeReference('Uri', url: 'dart:core') //
            .property('parse')
            .invoke([const i1.Static('baseUrl')]);

        uri = uri //
            .property('replace')
            .invoke([i1.Literal.of(path).named('path')]);

        if (query.isNotEmpty) {
          uri = uri //
              .property('replace')
              .invoke([const i1.Static('query').named('queryParameters')]);
        }

        yield const i1.Static('uri') //
            .declareFinal
            .assign(uri)
            .statement;

        yield const i1.Static('');

        final arguments = () sync* {
          //
          yield const i1.Static('uri');

          if (operation.body != null) {
            yield const i1.TypeReference('jsonEncode', url: 'dart:convert')
                .invoke([const i1.Static('body')]) //
                .named('body');
          }
        }();

        final request = const i1.Static('client') //
            .property(operation.method.name.camelCase)
            .invoke(arguments) //
            .awaited;

        yield const i1.Static('response') //
            .declareFinal
            .assign(request)
            .statement;

        yield const i1.Static('');

        yield i1.Switch(
          condition: const i1.Static('response').property('statusCode'),
          cases: () sync* {
            //
            for (final v in operation.responses) {
              final responseDef = context.find(v.type);

              final code = v.code.join((v) => v, (v) => 0);

              yield i1.SwitchCase(
                condition: i1.Literal.of(code),
                body: i1.Column(
                  () sync* {
                    //
                    if (v.type != 'unit') {
                      final decode = i1.invoke(
                        const i1.TypeReference(
                          'jsonDecode',
                          url: 'dart:convert',
                        ),
                        [
                          const i1.Static('response').property('body'),
                        ],
                      );

                      yield const i1.Static('json') //
                          .declareFinal
                          .assign(decode)
                          .statement;

                      yield const i1.Static('');

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
                        yield const i1.Static('break').statement;
                      } //
                      else {
                        yield i1
                            .invoke(
                              const i1.TypeReference(
                                'Exception',
                                url: 'dart:core',
                              ),
                              [],
                            )
                            .thrown
                            .statement;
                      }
                    }
                  }(),
                ),
              );
            }
          }(),
          default_: () {
            //
            return i1
                .invoke(
                  const i1.TypeReference(
                    'Exception',
                    url: 'dart:core',
                  ),
                  [],
                )
                .thrown
                .statement;
          }(),
        );
      }(),
    ),
  );
}

i1.Class _buildClient(
  BuildContext context,
) {
  return i1.Class(
    name: 'Client',
    constructors: () sync* {
      //
      yield i1.Constructor(
        isConst: true,
        parameters: () sync* {
          //
          yield const i1.Parameter(
            name: 'client',
            kind: i1.ParameterKind.named,
            isToThis: true,
            isRequired: true,
          );

          yield const i1.Parameter(
            name: 'baseUrl',
            kind: i1.ParameterKind.named,
            isToThis: true,
            isRequired: true,
          );
        }(),
      );
    }(),
    fields: () sync* {
      //
      yield const i1.Field(
        name: 'client',
        type: i1.TypeReference(
          'Client',
          url: 'package:http/http.dart',
        ),
        modifier: i1.FieldModifier.final_,
      );

      yield const i1.Field(
        name: 'baseUrl',
        type: i1.TypeReference(
          'String',
          url: 'dart:core',
        ),
        modifier: i1.FieldModifier.final_,
      );
    }(),
    methods: () sync* {
      //
      for (final v in context.service.resources) {
        final resourceDef = context.find(v.type);

        yield i1.Method(
          name: v.plural.camelCase,
          kind: i1.MethodKind.get,
          returns: i1.TypeReference(
            '${resourceDef.reference.symbol}Resource',
          ),
          body: () {
            //
            final resource = i1.invoke(
              i1.Static('${resourceDef.reference.symbol}Resource'),
              [
                const i1.Static('client').named('client'),
                const i1.Static('baseUrl').named('baseUrl'),
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
