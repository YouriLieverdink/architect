import 'package:recase/recase.dart';

const keywords = [
  'abstract', 'else', 'import', 'super', 'as', 'enum', 'in', 'switch',
  'assert', 'export', 'interface', 'sync', 'async', 'extends', 'is', 'this',
  'await', 'extension', 'library', 'throw', 'break', 'external', 'mixin',
  'true', 'case', 'factory', 'new', 'try', 'class', 'final', 'catch',
  'false', 'null', 'typedef', 'on', 'var', 'const', 'finally', 'operator',
  'void', 'continue', 'for', 'part', 'while', 'covariant', 'Function',
  'rethrow', 'with', 'default', 'get', 'return', 'yield', 'deferred', 'hide',
  'set', 'do', 'if', 'show', 'dynamic', 'implements', 'static', //
];

/// Adds an underscore (_) to the value when it is a reserver keyword in Dart.
String escapeIfKeyword(
  String value,
) {
  return keywords.contains(value.trim()) ? '${value}_' : value;
}

/// Returns an camel case identifier.
String getIdentifier(
  String value,
) {
  return escapeIfKeyword(value.camelCase);
}
