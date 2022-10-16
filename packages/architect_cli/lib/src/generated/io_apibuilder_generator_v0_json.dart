/// {@template io_apibuilder_generator_v0_json}
/// Documentation for an apibuilder code generator API
/// {@endtemplate}
library io_apibuilder_generator_v0_json;

import 'dart:core' as _i2;

import 'package:equatable/equatable.dart' as _i1;

import './io_apibuilder_spec_v0_json.dart' as _i3;

/// {@template file_flag}
/// Allows generator authors to flag files with special characteristics. It is
/// up to the client (i.e. the cli) to decide how to interpret them.
/// {@endtemplate}
enum FileFlag {
  /// {@template scaffolding}
  /// Indicates files that an end user starts from but should edit. Not intended
  /// to be the final product (see:
  /// https://stackoverflow.com/questions/235018/what-is-scaffolding-is-it-a-term-for-a-particular-platform).
  /// Consider not overwriting these files when code is re-generated.
  /// {@endtemplate}
  scaffolding
}

/// {@template attribute}
/// An attribute represents a key/value pair that is optionally used to provide
/// additional instructions / data to the code generator. An example could
/// be an attribute to specify the root import path for a go client..
/// {@endtemplate}
class Attribute extends _i1.Equatable {
  /// {@macro attribute}
  const Attribute({
    required this.name,
    required this.value,
  });

  factory Attribute.fromJson(_i2.dynamic json) {
    return Attribute(
      name: (json['name'] as _i2.String),
      value: (json['value'] as _i2.String),
    );
  }

  final _i2.String name;

  final _i2.String value;

  _i2.dynamic toJson() {
    return {'name': name, 'value': value};
  }

  Attribute copyWith({
    _i2.String? name,
    _i2.String? value,
  }) {
    return Attribute(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, value];
  }
}

class Error extends _i1.Equatable {
  const Error({
    required this.code,
    required this.message,
  });

  factory Error.fromJson(_i2.dynamic json) {
    return Error(
      code: (json['code'] as _i2.String),
      message: (json['message'] as _i2.String),
    );
  }

  /// Machine readable code for this specific error message
  final _i2.String code;

  /// Description of the error
  final _i2.String message;

  _i2.dynamic toJson() {
    return {'code': code, 'message': message};
  }

  Error copyWith({
    _i2.String? code,
    _i2.String? message,
  }) {
    return Error(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [code, message];
  }
}

/// {@template file}
/// Represents a source file
/// {@endtemplate}
class File extends _i1.Equatable {
  /// {@macro file}
  const File({
    required this.name,
    this.dir,
    required this.contents,
    this.flags,
  });

  factory File.fromJson(_i2.dynamic json) {
    return File(
      name: (json['name'] as _i2.String),
      dir: (json['dir'] as _i2.String?),
      contents: (json['contents'] as _i2.String),
      flags: (json['flags'] as _i2.List?)
          ?.map((v) => FileFlag.values.byName((v as _i2.String)))
          .toList(),
    );
  }

  /// The recommended name for the file.
  final _i2.String name;

  /// The recommended directory path for the file where appropriate.
  final _i2.String? dir;

  /// The actual source code.
  final _i2.String contents;

  final _i2.List<FileFlag>? flags;

  _i2.dynamic toJson() {
    return {
      'name': name,
      'dir': dir,
      'contents': contents,
      'flags': flags?.map((v) => v.name).toList()
    };
  }

  File copyWith({
    _i2.String? name,
    _i2.String? dir,
    _i2.String? contents,
    _i2.List<FileFlag>? flags,
  }) {
    return File(
      name: name ?? this.name,
      dir: dir ?? this.dir,
      contents: contents ?? this.contents,
      flags: flags ?? this.flags,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, dir, contents, flags];
  }
}

/// {@template generator}
/// The generator metadata.
/// {@endtemplate}
class Generator extends _i1.Equatable {
  /// {@macro generator}
  const Generator({
    required this.key,
    required this.name,
    this.language,
    this.description,
    required this.attributes,
  });

  factory Generator.fromJson(_i2.dynamic json) {
    return Generator(
      key: (json['key'] as _i2.String),
      name: (json['name'] as _i2.String),
      language: (json['language'] as _i2.String?),
      description: (json['description'] as _i2.String?),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => (v as _i2.String))
          .toList(),
    );
  }

  final _i2.String key;

  final _i2.String name;

  /// A comma separate list of the programming language(s) that this generator
  /// produces
  final _i2.String? language;

  final _i2.String? description;

  /// The list of attributes that this code generator can use. You can find the
  /// full list of available attributes and their descriptions at
  /// http://apibuilder.io/doc/attributes
  final _i2.List<_i2.String> attributes;

  _i2.dynamic toJson() {
    return {
      'key': key,
      'name': name,
      'language': language,
      'description': description,
      'attributes': attributes.map((v) => v).toList()
    };
  }

  Generator copyWith({
    _i2.String? key,
    _i2.String? name,
    _i2.String? language,
    _i2.String? description,
    _i2.List<_i2.String>? attributes,
  }) {
    return Generator(
      key: key ?? this.key,
      name: name ?? this.name,
      language: language ?? this.language,
      description: description ?? this.description,
      attributes: attributes ?? this.attributes,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [key, name, language, description, attributes];
  }
}

class Healthcheck extends _i1.Equatable {
  const Healthcheck({required this.status});

  factory Healthcheck.fromJson(_i2.dynamic json) {
    return Healthcheck(status: (json['status'] as _i2.String));
  }

  final _i2.String status;

  _i2.dynamic toJson() {
    return {'status': status};
  }

  Healthcheck copyWith({_i2.String? status}) {
    return Healthcheck(status: status ?? this.status);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [status];
  }
}

/// {@template invocation}
/// The result of invoking a generator.
/// {@endtemplate}
class Invocation extends _i1.Equatable {
  /// {@macro invocation}
  const Invocation({
    @_i2.Deprecated('Use files instead') required this.source,
    required this.files,
  });

  factory Invocation.fromJson(_i2.dynamic json) {
    return Invocation(
      source: (json['source'] as _i2.String),
      files: (json['files'] as _i2.List).map((v) => File.fromJson(v)).toList(),
    );
  }

  /// The actual source code.
  @_i2.Deprecated('Use files instead')
  final _i2.String source;

  /// A collection of source files
  final _i2.List<File> files;

  _i2.dynamic toJson() {
    return {'source': source, 'files': files.map((v) => v.toJson()).toList()};
  }

  Invocation copyWith({
    @_i2.Deprecated('Use files instead') _i2.String? source,
    _i2.List<File>? files,
  }) {
    return Invocation(
      source: source ?? this.source,
      files: files ?? this.files,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [source, files];
  }
}

/// {@template invocation_form}
/// The invocation form is the payload send to the code generators when
/// requesting generation of client code.
/// {@endtemplate}
class InvocationForm extends _i1.Equatable {
  /// {@macro invocation_form}
  const InvocationForm({
    required this.service,
    required this.attributes,
    this.userAgent,
    this.importedServices,
  });

  factory InvocationForm.fromJson(_i2.dynamic json) {
    return InvocationForm(
      service: _i3.Service.fromJson(json['service']),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
      userAgent: (json['user_agent'] as _i2.String?),
      importedServices: (json['imported_services'] as _i2.List?)
          ?.map((v) => _i3.Service.fromJson(v))
          .toList(),
    );
  }

  final _i3.Service service;

  final _i2.List<Attribute> attributes;

  final _i2.String? userAgent;

  final _i2.List<_i3.Service>? importedServices;

  _i2.dynamic toJson() {
    return {
      'service': service.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'user_agent': userAgent,
      'imported_services': importedServices?.map((v) => v.toJson()).toList()
    };
  }

  InvocationForm copyWith({
    _i3.Service? service,
    _i2.List<Attribute>? attributes,
    _i2.String? userAgent,
    _i2.List<_i3.Service>? importedServices,
  }) {
    return InvocationForm(
      service: service ?? this.service,
      attributes: attributes ?? this.attributes,
      userAgent: userAgent ?? this.userAgent,
      importedServices: importedServices ?? this.importedServices,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [service, attributes, userAgent, importedServices];
  }
}
