// ignore_for_file: avoid_dynamic_calls, constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:sealed_unions/sealed_unions.dart';

enum IoApibuilderGeneratorV0EnumsFileFlag { scaffolding }

enum IoApibuilderSpecV0EnumsMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
  HEAD,
  CONNECT,
  OPTIONS,
  TRACE
}

enum IoApibuilderSpecV0EnumsParameterLocation { Path, Query, Form, Header }

enum IoApibuilderSpecV0EnumsResponseCodeOption { Default }

class IoApibuilderGeneratorV0ModelsAttribute extends Equatable {
  const IoApibuilderGeneratorV0ModelsAttribute({
    required this.name,
    required this.value,
  });

  factory IoApibuilderGeneratorV0ModelsAttribute.fromJson(dynamic json) {
    return IoApibuilderGeneratorV0ModelsAttribute(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }

  final String name;

  final String value;

  dynamic toJson() {
    return {'name': name, 'value': value};
  }

  IoApibuilderGeneratorV0ModelsAttribute copyWith({
    String? name,
    String? value,
  }) {
    return IoApibuilderGeneratorV0ModelsAttribute(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props {
    return [name, value];
  }
}

class IoApibuilderGeneratorV0ModelsError extends Equatable {
  const IoApibuilderGeneratorV0ModelsError({
    required this.code,
    required this.message,
  });

  factory IoApibuilderGeneratorV0ModelsError.fromJson(dynamic json) {
    return IoApibuilderGeneratorV0ModelsError(
      code: json['code'] as String,
      message: json['message'] as String,
    );
  }

  final String code;

  final String message;

  dynamic toJson() {
    return {'code': code, 'message': message};
  }

  IoApibuilderGeneratorV0ModelsError copyWith({String? code, String? message}) {
    return IoApibuilderGeneratorV0ModelsError(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props {
    return [code, message];
  }
}

class IoApibuilderGeneratorV0ModelsFile extends Equatable {
  const IoApibuilderGeneratorV0ModelsFile({
    required this.name,
    this.dir,
    required this.contents,
    this.flags,
  });

  factory IoApibuilderGeneratorV0ModelsFile.fromJson(dynamic json) {
    return IoApibuilderGeneratorV0ModelsFile(
      name: json['name'] as String,
      dir: json['dir'] as String?,
      contents: json['contents'] as String,
      flags: (json['flags'] as List?)
          ?.map(
            (v) =>
                IoApibuilderGeneratorV0EnumsFileFlag.values.byName(v as String),
          )
          .toList(),
    );
  }

  final String name;

  final String? dir;

  final String contents;

  final List<IoApibuilderGeneratorV0EnumsFileFlag>? flags;

  dynamic toJson() {
    return {
      'name': name,
      'dir': dir,
      'contents': contents,
      'flags': flags?.map((v) => v.name).toList()
    };
  }

  IoApibuilderGeneratorV0ModelsFile copyWith({
    String? name,
    String? dir,
    String? contents,
    List<IoApibuilderGeneratorV0EnumsFileFlag>? flags,
  }) {
    return IoApibuilderGeneratorV0ModelsFile(
      name: name ?? this.name,
      dir: dir ?? this.dir,
      contents: contents ?? this.contents,
      flags: flags ?? this.flags,
    );
  }

  @override
  List<Object?> get props {
    return [name, dir, contents, flags];
  }
}

class IoApibuilderGeneratorV0ModelsGenerator extends Equatable {
  const IoApibuilderGeneratorV0ModelsGenerator({
    required this.key,
    required this.name,
    this.language,
    this.description,
    required this.attributes,
  });

  factory IoApibuilderGeneratorV0ModelsGenerator.fromJson(dynamic json) {
    return IoApibuilderGeneratorV0ModelsGenerator(
      key: json['key'] as String,
      name: json['name'] as String,
      language: json['language'] as String?,
      description: json['description'] as String?,
      attributes: (json['attributes'] as List).map((v) => v as String).toList(),
    );
  }

  final String key;

  final String name;

  final String? language;

  final String? description;

  final List<String> attributes;

  dynamic toJson() {
    return {
      'key': key,
      'name': name,
      'language': language,
      'description': description,
      'attributes': attributes.map((v) => v).toList()
    };
  }

  IoApibuilderGeneratorV0ModelsGenerator copyWith({
    String? key,
    String? name,
    String? language,
    String? description,
    List<String>? attributes,
  }) {
    return IoApibuilderGeneratorV0ModelsGenerator(
      key: key ?? this.key,
      name: name ?? this.name,
      language: language ?? this.language,
      description: description ?? this.description,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [key, name, language, description, attributes];
  }
}

class IoApibuilderGeneratorV0ModelsHealthcheck extends Equatable {
  const IoApibuilderGeneratorV0ModelsHealthcheck({required this.status});

  factory IoApibuilderGeneratorV0ModelsHealthcheck.fromJson(dynamic json) {
    return IoApibuilderGeneratorV0ModelsHealthcheck(
      status: json['status'] as String,
    );
  }

  final String status;

  dynamic toJson() {
    return {'status': status};
  }

  IoApibuilderGeneratorV0ModelsHealthcheck copyWith({String? status}) {
    return IoApibuilderGeneratorV0ModelsHealthcheck(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [status];
  }
}

class IoApibuilderGeneratorV0ModelsInvocation extends Equatable {
  const IoApibuilderGeneratorV0ModelsInvocation({
    required this.source,
    required this.files,
  });

  factory IoApibuilderGeneratorV0ModelsInvocation.fromJson(dynamic json) {
    return IoApibuilderGeneratorV0ModelsInvocation(
      source: json['source'] as String,
      files: (json['files'] as List)
          .map((v) => IoApibuilderGeneratorV0ModelsFile.fromJson(v))
          .toList(),
    );
  }

  final String source;

  final List<IoApibuilderGeneratorV0ModelsFile> files;

  dynamic toJson() {
    return {'source': source, 'files': files.map((v) => v.toJson()).toList()};
  }

  IoApibuilderGeneratorV0ModelsInvocation copyWith({
    String? source,
    List<IoApibuilderGeneratorV0ModelsFile>? files,
  }) {
    return IoApibuilderGeneratorV0ModelsInvocation(
      source: source ?? this.source,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props {
    return [source, files];
  }
}

class IoApibuilderGeneratorV0ModelsInvocationForm extends Equatable {
  const IoApibuilderGeneratorV0ModelsInvocationForm({
    required this.service,
    required this.attributes,
    this.userAgent,
    this.importedServices,
  });

  factory IoApibuilderGeneratorV0ModelsInvocationForm.fromJson(dynamic json) {
    return IoApibuilderGeneratorV0ModelsInvocationForm(
      service: IoApibuilderSpecV0ModelsService.fromJson(json['service']),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderGeneratorV0ModelsAttribute.fromJson(v))
          .toList(),
      userAgent: json['user_agent'] as String?,
      importedServices: (json['imported_services'] as List?)
          ?.map((v) => IoApibuilderSpecV0ModelsService.fromJson(v))
          .toList(),
    );
  }

  final IoApibuilderSpecV0ModelsService service;

  final List<IoApibuilderGeneratorV0ModelsAttribute> attributes;

  final String? userAgent;

  final List<IoApibuilderSpecV0ModelsService>? importedServices;

  dynamic toJson() {
    return {
      'service': service.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'user_agent': userAgent,
      'imported_services': importedServices?.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderGeneratorV0ModelsInvocationForm copyWith({
    IoApibuilderSpecV0ModelsService? service,
    List<IoApibuilderGeneratorV0ModelsAttribute>? attributes,
    String? userAgent,
    List<IoApibuilderSpecV0ModelsService>? importedServices,
  }) {
    return IoApibuilderGeneratorV0ModelsInvocationForm(
      service: service ?? this.service,
      attributes: attributes ?? this.attributes,
      userAgent: userAgent ?? this.userAgent,
      importedServices: importedServices ?? this.importedServices,
    );
  }

  @override
  List<Object?> get props {
    return [service, attributes, userAgent, importedServices];
  }
}

class IoApibuilderCommonV0ModelsAudit extends Equatable {
  const IoApibuilderCommonV0ModelsAudit({
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory IoApibuilderCommonV0ModelsAudit.fromJson(dynamic json) {
    return IoApibuilderCommonV0ModelsAudit(
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: IoApibuilderCommonV0ModelsReferenceGuid.fromJson(
        json['created_by'],
      ),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      updatedBy: IoApibuilderCommonV0ModelsReferenceGuid.fromJson(
        json['updated_by'],
      ),
    );
  }

  final DateTime createdAt;

  final IoApibuilderCommonV0ModelsReferenceGuid createdBy;

  final DateTime updatedAt;

  final IoApibuilderCommonV0ModelsReferenceGuid updatedBy;

  dynamic toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy.toJson(),
      'updated_at': updatedAt.toIso8601String(),
      'updated_by': updatedBy.toJson()
    };
  }

  IoApibuilderCommonV0ModelsAudit copyWith({
    DateTime? createdAt,
    IoApibuilderCommonV0ModelsReferenceGuid? createdBy,
    DateTime? updatedAt,
    IoApibuilderCommonV0ModelsReferenceGuid? updatedBy,
  }) {
    return IoApibuilderCommonV0ModelsAudit(
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  @override
  List<Object?> get props {
    return [createdAt, createdBy, updatedAt, updatedBy];
  }
}

class IoApibuilderCommonV0ModelsHealthcheck extends Equatable {
  const IoApibuilderCommonV0ModelsHealthcheck({required this.status});

  factory IoApibuilderCommonV0ModelsHealthcheck.fromJson(dynamic json) {
    return IoApibuilderCommonV0ModelsHealthcheck(
      status: json['status'] as String,
    );
  }

  final String status;

  dynamic toJson() {
    return {'status': status};
  }

  IoApibuilderCommonV0ModelsHealthcheck copyWith({String? status}) {
    return IoApibuilderCommonV0ModelsHealthcheck(status: status ?? this.status);
  }

  @override
  List<Object?> get props {
    return [status];
  }
}

class IoApibuilderCommonV0ModelsReference extends Equatable {
  const IoApibuilderCommonV0ModelsReference({
    required this.guid,
    required this.key,
  });

  factory IoApibuilderCommonV0ModelsReference.fromJson(dynamic json) {
    return IoApibuilderCommonV0ModelsReference(
      guid: json['guid'] as String,
      key: json['key'] as String,
    );
  }

  final String guid;

  final String key;

  dynamic toJson() {
    return {'guid': guid, 'key': key};
  }

  IoApibuilderCommonV0ModelsReference copyWith({String? guid, String? key}) {
    return IoApibuilderCommonV0ModelsReference(
      guid: guid ?? this.guid,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props {
    return [guid, key];
  }
}

class IoApibuilderCommonV0ModelsReferenceGuid extends Equatable {
  const IoApibuilderCommonV0ModelsReferenceGuid({required this.guid});

  factory IoApibuilderCommonV0ModelsReferenceGuid.fromJson(dynamic json) {
    return IoApibuilderCommonV0ModelsReferenceGuid(
      guid: json['guid'] as String,
    );
  }

  final String guid;

  dynamic toJson() {
    return {'guid': guid};
  }

  IoApibuilderCommonV0ModelsReferenceGuid copyWith({String? guid}) {
    return IoApibuilderCommonV0ModelsReferenceGuid(guid: guid ?? this.guid);
  }

  @override
  List<Object?> get props {
    return [guid];
  }
}

class IoApibuilderSpecV0ModelsAnnotation extends Equatable {
  const IoApibuilderSpecV0ModelsAnnotation({
    required this.name,
    this.description,
    this.deprecation,
  });

  factory IoApibuilderSpecV0ModelsAnnotation.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsAnnotation(
      name: json['name'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(
              json['deprecation'],
            ),
    );
  }

  final String name;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  dynamic toJson() {
    return {
      'name': name,
      'description': description,
      'deprecation': deprecation?.toJson()
    };
  }

  IoApibuilderSpecV0ModelsAnnotation copyWith({
    String? name,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
  }) {
    return IoApibuilderSpecV0ModelsAnnotation(
      name: name ?? this.name,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
    );
  }

  @override
  List<Object?> get props {
    return [name, description, deprecation];
  }
}

class IoApibuilderSpecV0ModelsApidoc extends Equatable {
  const IoApibuilderSpecV0ModelsApidoc({required this.version});

  factory IoApibuilderSpecV0ModelsApidoc.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsApidoc(version: json['version'] as String);
  }

  final String version;

  dynamic toJson() {
    return {'version': version};
  }

  IoApibuilderSpecV0ModelsApidoc copyWith({String? version}) {
    return IoApibuilderSpecV0ModelsApidoc(version: version ?? this.version);
  }

  @override
  List<Object?> get props {
    return [version];
  }
}

class IoApibuilderSpecV0ModelsApplication extends Equatable {
  const IoApibuilderSpecV0ModelsApplication({required this.key});

  factory IoApibuilderSpecV0ModelsApplication.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsApplication(key: json['key'] as String);
  }

  final String key;

  dynamic toJson() {
    return {'key': key};
  }

  IoApibuilderSpecV0ModelsApplication copyWith({String? key}) {
    return IoApibuilderSpecV0ModelsApplication(key: key ?? this.key);
  }

  @override
  List<Object?> get props {
    return [key];
  }
}

class IoApibuilderSpecV0ModelsAttribute extends Equatable {
  const IoApibuilderSpecV0ModelsAttribute({
    required this.name,
    required this.value,
    this.description,
    this.deprecation,
  });

  factory IoApibuilderSpecV0ModelsAttribute.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsAttribute(
      name: json['name'] as String,
      value: json['value'] as Map<String, dynamic>,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(
              json['deprecation'],
            ),
    );
  }

  final String name;

  final Map<String, dynamic> value;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  dynamic toJson() {
    return {
      'name': name,
      'value': value,
      'description': description,
      'deprecation': deprecation?.toJson()
    };
  }

  IoApibuilderSpecV0ModelsAttribute copyWith({
    String? name,
    Map<String, dynamic>? value,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
  }) {
    return IoApibuilderSpecV0ModelsAttribute(
      name: name ?? this.name,
      value: value ?? this.value,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
    );
  }

  @override
  List<Object?> get props {
    return [name, value, description, deprecation];
  }
}

class IoApibuilderSpecV0ModelsBody extends Equatable {
  const IoApibuilderSpecV0ModelsBody({
    required this.type,
    this.description,
    this.deprecation,
    required this.attributes,
  });

  factory IoApibuilderSpecV0ModelsBody.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsBody(
      type: json['type'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final String type;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  dynamic toJson() {
    return {
      'type': type,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsBody copyWith({
    String? type,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsBody(
      type: type ?? this.type,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [type, description, deprecation, attributes];
  }
}

class IoApibuilderSpecV0ModelsContact extends Equatable {
  const IoApibuilderSpecV0ModelsContact({this.name, this.url, this.email});

  factory IoApibuilderSpecV0ModelsContact.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsContact(
      name: json['name'] as String?,
      url: json['url'] as String?,
      email: json['email'] as String?,
    );
  }

  final String? name;

  final String? url;

  final String? email;

  dynamic toJson() {
    return {'name': name, 'url': url, 'email': email};
  }

  IoApibuilderSpecV0ModelsContact copyWith({
    String? name,
    String? url,
    String? email,
  }) {
    return IoApibuilderSpecV0ModelsContact(
      name: name ?? this.name,
      url: url ?? this.url,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props {
    return [name, url, email];
  }
}

class IoApibuilderSpecV0ModelsDeprecation extends Equatable {
  const IoApibuilderSpecV0ModelsDeprecation({this.description});

  factory IoApibuilderSpecV0ModelsDeprecation.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsDeprecation(
      description: json['description'] as String?,
    );
  }

  final String? description;

  dynamic toJson() {
    return {'description': description};
  }

  IoApibuilderSpecV0ModelsDeprecation copyWith({String? description}) {
    return IoApibuilderSpecV0ModelsDeprecation(
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props {
    return [description];
  }
}

class IoApibuilderSpecV0ModelsEnum extends Equatable {
  const IoApibuilderSpecV0ModelsEnum({
    required this.name,
    required this.plural,
    this.description,
    this.deprecation,
    required this.values,
    required this.attributes,
  });

  factory IoApibuilderSpecV0ModelsEnum.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsEnum(
      name: json['name'] as String,
      plural: json['plural'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      values: (json['values'] as List)
          .map((v) => IoApibuilderSpecV0ModelsEnumValue.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final String name;

  final String plural;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsEnumValue> values;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  dynamic toJson() {
    return {
      'name': name,
      'plural': plural,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'values': values.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsEnum copyWith({
    String? name,
    String? plural,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsEnumValue>? values,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsEnum(
      name: name ?? this.name,
      plural: plural ?? this.plural,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      values: values ?? this.values,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [name, plural, description, deprecation, values, attributes];
  }
}

class IoApibuilderSpecV0ModelsEnumValue extends Equatable {
  const IoApibuilderSpecV0ModelsEnumValue({
    required this.name,
    this.description,
    this.deprecation,
    required this.attributes,
    this.value,
  });

  factory IoApibuilderSpecV0ModelsEnumValue.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsEnumValue(
      name: json['name'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
      value: json['value'] as String?,
    );
  }

  final String name;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  final String? value;

  dynamic toJson() {
    return {
      'name': name,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'value': value
    };
  }

  IoApibuilderSpecV0ModelsEnumValue copyWith({
    String? name,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
    String? value,
  }) {
    return IoApibuilderSpecV0ModelsEnumValue(
      name: name ?? this.name,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props {
    return [name, description, deprecation, attributes, value];
  }
}

class IoApibuilderSpecV0ModelsField extends Equatable {
  const IoApibuilderSpecV0ModelsField({
    required this.name,
    required this.type,
    this.description,
    this.deprecation,
    this.default_,
    required this.required,
    this.minimum,
    this.maximum,
    this.example,
    required this.attributes,
    required this.annotations,
  });

  factory IoApibuilderSpecV0ModelsField.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsField(
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      default_: json['default'] as String?,
      required: json['required'] as bool,
      minimum: json['minimum'] as num?,
      maximum: json['maximum'] as num?,
      example: json['example'] as String?,
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
      annotations:
          (json['annotations'] as List).map((v) => v as String).toList(),
    );
  }

  final String name;

  final String type;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final String? default_;

  final bool required;

  final num? minimum;

  final num? maximum;

  final String? example;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  final List<String> annotations;

  dynamic toJson() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'default': default_,
      'required': required,
      'minimum': minimum,
      'maximum': maximum,
      'example': example,
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'annotations': annotations.map((v) => v).toList()
    };
  }

  IoApibuilderSpecV0ModelsField copyWith({
    String? name,
    String? type,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    String? default_,
    bool? required,
    num? minimum,
    num? maximum,
    String? example,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
    List<String>? annotations,
  }) {
    return IoApibuilderSpecV0ModelsField(
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      default_: default_ ?? this.default_,
      required: required ?? this.required,
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum,
      example: example ?? this.example,
      attributes: attributes ?? this.attributes,
      annotations: annotations ?? this.annotations,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      type,
      description,
      deprecation,
      default_,
      required,
      minimum,
      maximum,
      example,
      attributes,
      annotations
    ];
  }
}

class IoApibuilderSpecV0ModelsHeader extends Equatable {
  const IoApibuilderSpecV0ModelsHeader({
    required this.name,
    required this.type,
    this.description,
    this.deprecation,
    required this.required,
    this.default_,
    required this.attributes,
  });

  factory IoApibuilderSpecV0ModelsHeader.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsHeader(
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      required: json['required'] as bool,
      default_: json['default'] as String?,
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final String name;

  final String type;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final bool required;

  final String? default_;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  dynamic toJson() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'required': required,
      'default': default_,
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsHeader copyWith({
    String? name,
    String? type,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    bool? required,
    String? default_,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsHeader(
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      required: required ?? this.required,
      default_: default_ ?? this.default_,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      type,
      description,
      deprecation,
      required,
      default_,
      attributes
    ];
  }
}

class IoApibuilderSpecV0ModelsImport extends Equatable {
  const IoApibuilderSpecV0ModelsImport({
    required this.uri,
    required this.namespace,
    required this.organization,
    required this.application,
    required this.version,
    required this.enums,
    required this.interfaces,
    required this.unions,
    required this.models,
    required this.annotations,
  });

  factory IoApibuilderSpecV0ModelsImport.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsImport(
      uri: json['uri'] as String,
      namespace: json['namespace'] as String,
      organization:
          IoApibuilderSpecV0ModelsOrganization.fromJson(json['organization']),
      application:
          IoApibuilderSpecV0ModelsApplication.fromJson(json['application']),
      version: json['version'] as String,
      enums: (json['enums'] as List).map((v) => v as String).toList(),
      interfaces: (json['interfaces'] as List).map((v) => v as String).toList(),
      unions: (json['unions'] as List).map((v) => v as String).toList(),
      models: (json['models'] as List).map((v) => v as String).toList(),
      annotations: (json['annotations'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAnnotation.fromJson(v))
          .toList(),
    );
  }

  final String uri;

  final String namespace;

  final IoApibuilderSpecV0ModelsOrganization organization;

  final IoApibuilderSpecV0ModelsApplication application;

  final String version;

  final List<String> enums;

  final List<String> interfaces;

  final List<String> unions;

  final List<String> models;

  final List<IoApibuilderSpecV0ModelsAnnotation> annotations;

  dynamic toJson() {
    return {
      'uri': uri,
      'namespace': namespace,
      'organization': organization.toJson(),
      'application': application.toJson(),
      'version': version,
      'enums': enums.map((v) => v).toList(),
      'interfaces': interfaces.map((v) => v).toList(),
      'unions': unions.map((v) => v).toList(),
      'models': models.map((v) => v).toList(),
      'annotations': annotations.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsImport copyWith({
    String? uri,
    String? namespace,
    IoApibuilderSpecV0ModelsOrganization? organization,
    IoApibuilderSpecV0ModelsApplication? application,
    String? version,
    List<String>? enums,
    List<String>? interfaces,
    List<String>? unions,
    List<String>? models,
    List<IoApibuilderSpecV0ModelsAnnotation>? annotations,
  }) {
    return IoApibuilderSpecV0ModelsImport(
      uri: uri ?? this.uri,
      namespace: namespace ?? this.namespace,
      organization: organization ?? this.organization,
      application: application ?? this.application,
      version: version ?? this.version,
      enums: enums ?? this.enums,
      interfaces: interfaces ?? this.interfaces,
      unions: unions ?? this.unions,
      models: models ?? this.models,
      annotations: annotations ?? this.annotations,
    );
  }

  @override
  List<Object?> get props {
    return [
      uri,
      namespace,
      organization,
      application,
      version,
      enums,
      interfaces,
      unions,
      models,
      annotations
    ];
  }
}

class IoApibuilderSpecV0ModelsInfo extends Equatable {
  const IoApibuilderSpecV0ModelsInfo({this.license, this.contact});

  factory IoApibuilderSpecV0ModelsInfo.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsInfo(
      license: json['license'] == null
          ? null
          : IoApibuilderSpecV0ModelsLicense.fromJson(json['license']),
      contact: json['contact'] == null
          ? null
          : IoApibuilderSpecV0ModelsContact.fromJson(json['contact']),
    );
  }

  final IoApibuilderSpecV0ModelsLicense? license;

  final IoApibuilderSpecV0ModelsContact? contact;

  dynamic toJson() {
    return {'license': license?.toJson(), 'contact': contact?.toJson()};
  }

  IoApibuilderSpecV0ModelsInfo copyWith({
    IoApibuilderSpecV0ModelsLicense? license,
    IoApibuilderSpecV0ModelsContact? contact,
  }) {
    return IoApibuilderSpecV0ModelsInfo(
      license: license ?? this.license,
      contact: contact ?? this.contact,
    );
  }

  @override
  List<Object?> get props {
    return [license, contact];
  }
}

class IoApibuilderSpecV0ModelsInterface extends Equatable {
  const IoApibuilderSpecV0ModelsInterface({
    required this.name,
    required this.plural,
    this.description,
    this.deprecation,
    required this.fields,
    required this.attributes,
  });

  factory IoApibuilderSpecV0ModelsInterface.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsInterface(
      name: json['name'] as String,
      plural: json['plural'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      fields: (json['fields'] as List)
          .map((v) => IoApibuilderSpecV0ModelsField.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final String name;

  final String plural;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsField> fields;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  dynamic toJson() {
    return {
      'name': name,
      'plural': plural,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'fields': fields.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsInterface copyWith({
    String? name,
    String? plural,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsField>? fields,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsInterface(
      name: name ?? this.name,
      plural: plural ?? this.plural,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      fields: fields ?? this.fields,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [name, plural, description, deprecation, fields, attributes];
  }
}

class IoApibuilderSpecV0ModelsLicense extends Equatable {
  const IoApibuilderSpecV0ModelsLicense({required this.name, this.url});

  factory IoApibuilderSpecV0ModelsLicense.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsLicense(
      name: json['name'] as String,
      url: json['url'] as String?,
    );
  }

  final String name;

  final String? url;

  dynamic toJson() {
    return {'name': name, 'url': url};
  }

  IoApibuilderSpecV0ModelsLicense copyWith({String? name, String? url}) {
    return IoApibuilderSpecV0ModelsLicense(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props {
    return [name, url];
  }
}

class IoApibuilderSpecV0ModelsModel extends Equatable {
  const IoApibuilderSpecV0ModelsModel({
    required this.name,
    required this.plural,
    this.description,
    this.deprecation,
    required this.fields,
    required this.attributes,
    required this.interfaces,
  });

  factory IoApibuilderSpecV0ModelsModel.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsModel(
      name: json['name'] as String,
      plural: json['plural'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      fields: (json['fields'] as List)
          .map((v) => IoApibuilderSpecV0ModelsField.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
      interfaces: (json['interfaces'] as List).map((v) => v as String).toList(),
    );
  }

  final String name;

  final String plural;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsField> fields;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  final List<String> interfaces;

  dynamic toJson() {
    return {
      'name': name,
      'plural': plural,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'fields': fields.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'interfaces': interfaces.map((v) => v).toList()
    };
  }

  IoApibuilderSpecV0ModelsModel copyWith({
    String? name,
    String? plural,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsField>? fields,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
    List<String>? interfaces,
  }) {
    return IoApibuilderSpecV0ModelsModel(
      name: name ?? this.name,
      plural: plural ?? this.plural,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      fields: fields ?? this.fields,
      attributes: attributes ?? this.attributes,
      interfaces: interfaces ?? this.interfaces,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      plural,
      description,
      deprecation,
      fields,
      attributes,
      interfaces
    ];
  }
}

class IoApibuilderSpecV0ModelsOperation extends Equatable {
  const IoApibuilderSpecV0ModelsOperation({
    required this.method,
    required this.path,
    this.description,
    this.deprecation,
    this.body,
    required this.parameters,
    required this.responses,
    required this.attributes,
  });

  factory IoApibuilderSpecV0ModelsOperation.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsOperation(
      method: IoApibuilderSpecV0EnumsMethod.values.byName(
        json['method'] as String,
      ),
      path: json['path'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      body: json['body'] == null
          ? null
          : IoApibuilderSpecV0ModelsBody.fromJson(json['body']),
      parameters: (json['parameters'] as List)
          .map((v) => IoApibuilderSpecV0ModelsParameter.fromJson(v))
          .toList(),
      responses: (json['responses'] as List)
          .map((v) => IoApibuilderSpecV0ModelsResponse.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final IoApibuilderSpecV0EnumsMethod method;

  final String path;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final IoApibuilderSpecV0ModelsBody? body;

  final List<IoApibuilderSpecV0ModelsParameter> parameters;

  final List<IoApibuilderSpecV0ModelsResponse> responses;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  dynamic toJson() {
    return {
      'method': method.name,
      'path': path,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'body': body?.toJson(),
      'parameters': parameters.map((v) => v.toJson()).toList(),
      'responses': responses.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsOperation copyWith({
    IoApibuilderSpecV0EnumsMethod? method,
    String? path,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    IoApibuilderSpecV0ModelsBody? body,
    List<IoApibuilderSpecV0ModelsParameter>? parameters,
    List<IoApibuilderSpecV0ModelsResponse>? responses,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsOperation(
      method: method ?? this.method,
      path: path ?? this.path,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      body: body ?? this.body,
      parameters: parameters ?? this.parameters,
      responses: responses ?? this.responses,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [
      method,
      path,
      description,
      deprecation,
      body,
      parameters,
      responses,
      attributes
    ];
  }
}

class IoApibuilderSpecV0ModelsOrganization extends Equatable {
  const IoApibuilderSpecV0ModelsOrganization({required this.key});

  factory IoApibuilderSpecV0ModelsOrganization.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsOrganization(key: json['key'] as String);
  }

  final String key;

  dynamic toJson() {
    return {'key': key};
  }

  IoApibuilderSpecV0ModelsOrganization copyWith({String? key}) {
    return IoApibuilderSpecV0ModelsOrganization(key: key ?? this.key);
  }

  @override
  List<Object?> get props {
    return [key];
  }
}

class IoApibuilderSpecV0ModelsParameter extends Equatable {
  const IoApibuilderSpecV0ModelsParameter({
    required this.name,
    required this.type,
    required this.location,
    this.description,
    this.deprecation,
    required this.required,
    this.default_,
    this.minimum,
    this.maximum,
    this.example,
    this.attributes,
  });

  factory IoApibuilderSpecV0ModelsParameter.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsParameter(
      name: json['name'] as String,
      type: json['type'] as String,
      location: IoApibuilderSpecV0EnumsParameterLocation.values
          .byName(json['location'] as String),
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      required: json['required'] as bool,
      default_: json['default'] as String?,
      minimum: json['minimum'] as num?,
      maximum: json['maximum'] as num?,
      example: json['example'] as String?,
      attributes: (json['attributes'] as List?)
          ?.map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final String name;

  final String type;

  final IoApibuilderSpecV0EnumsParameterLocation location;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final bool required;

  final String? default_;

  final num? minimum;

  final num? maximum;

  final String? example;

  final List<IoApibuilderSpecV0ModelsAttribute>? attributes;

  dynamic toJson() {
    return {
      'name': name,
      'type': type,
      'location': location.name,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'required': required,
      'default': default_,
      'minimum': minimum,
      'maximum': maximum,
      'example': example,
      'attributes': attributes?.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsParameter copyWith({
    String? name,
    String? type,
    IoApibuilderSpecV0EnumsParameterLocation? location,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    bool? required,
    String? default_,
    num? minimum,
    num? maximum,
    String? example,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsParameter(
      name: name ?? this.name,
      type: type ?? this.type,
      location: location ?? this.location,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      required: required ?? this.required,
      default_: default_ ?? this.default_,
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum,
      example: example ?? this.example,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      type,
      location,
      description,
      deprecation,
      required,
      default_,
      minimum,
      maximum,
      example,
      attributes
    ];
  }
}

class IoApibuilderSpecV0ModelsResource extends Equatable {
  const IoApibuilderSpecV0ModelsResource({
    required this.type,
    required this.plural,
    this.path,
    this.description,
    this.deprecation,
    required this.operations,
    required this.attributes,
  });

  factory IoApibuilderSpecV0ModelsResource.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsResource(
      type: json['type'] as String,
      plural: json['plural'] as String,
      path: json['path'] as String?,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      operations: (json['operations'] as List)
          .map((v) => IoApibuilderSpecV0ModelsOperation.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final String type;

  final String plural;

  final String? path;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsOperation> operations;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  dynamic toJson() {
    return {
      'type': type,
      'plural': plural,
      'path': path,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'operations': operations.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsResource copyWith({
    String? type,
    String? plural,
    String? path,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsOperation>? operations,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsResource(
      type: type ?? this.type,
      plural: plural ?? this.plural,
      path: path ?? this.path,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      operations: operations ?? this.operations,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [
      type,
      plural,
      path,
      description,
      deprecation,
      operations,
      attributes
    ];
  }
}

class IoApibuilderSpecV0ModelsResponse extends Equatable {
  const IoApibuilderSpecV0ModelsResponse({
    required this.code,
    required this.type,
    this.headers,
    this.description,
    this.deprecation,
    this.attributes,
  });

  factory IoApibuilderSpecV0ModelsResponse.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsResponse(
      code: IoApibuilderSpecV0UnionsResponseCode.fromJson(json['code']),
      type: json['type'] as String,
      headers: (json['headers'] as List?)
          ?.map((v) => IoApibuilderSpecV0ModelsHeader.fromJson(v))
          .toList(),
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      attributes: (json['attributes'] as List?)
          ?.map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
    );
  }

  final IoApibuilderSpecV0UnionsResponseCode code;

  final String type;

  final List<IoApibuilderSpecV0ModelsHeader>? headers;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsAttribute>? attributes;

  dynamic toJson() {
    return {
      'code': code.toJson(),
      'type': type,
      'headers': headers?.map((v) => v.toJson()).toList(),
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes?.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsResponse copyWith({
    IoApibuilderSpecV0UnionsResponseCode? code,
    String? type,
    List<IoApibuilderSpecV0ModelsHeader>? headers,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
  }) {
    return IoApibuilderSpecV0ModelsResponse(
      code: code ?? this.code,
      type: type ?? this.type,
      headers: headers ?? this.headers,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
    );
  }

  @override
  List<Object?> get props {
    return [code, type, headers, description, deprecation, attributes];
  }
}

class IoApibuilderSpecV0ModelsService extends Equatable {
  const IoApibuilderSpecV0ModelsService({
    required this.apidoc,
    required this.name,
    required this.organization,
    required this.application,
    required this.namespace,
    required this.version,
    this.baseUrl,
    this.description,
    required this.info,
    required this.headers,
    required this.imports,
    required this.enums,
    required this.interfaces,
    required this.unions,
    required this.models,
    required this.resources,
    required this.attributes,
    required this.annotations,
  });

  factory IoApibuilderSpecV0ModelsService.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsService(
      apidoc: IoApibuilderSpecV0ModelsApidoc.fromJson(json['apidoc']),
      name: json['name'] as String,
      organization:
          IoApibuilderSpecV0ModelsOrganization.fromJson(json['organization']),
      application:
          IoApibuilderSpecV0ModelsApplication.fromJson(json['application']),
      namespace: json['namespace'] as String,
      version: json['version'] as String,
      baseUrl: json['base_url'] as String?,
      description: json['description'] as String?,
      info: IoApibuilderSpecV0ModelsInfo.fromJson(json['info']),
      headers: (json['headers'] as List)
          .map((v) => IoApibuilderSpecV0ModelsHeader.fromJson(v))
          .toList(),
      imports: (json['imports'] as List)
          .map((v) => IoApibuilderSpecV0ModelsImport.fromJson(v))
          .toList(),
      enums: (json['enums'] as List)
          .map((v) => IoApibuilderSpecV0ModelsEnum.fromJson(v))
          .toList(),
      interfaces: (json['interfaces'] as List)
          .map((v) => IoApibuilderSpecV0ModelsInterface.fromJson(v))
          .toList(),
      unions: (json['unions'] as List)
          .map((v) => IoApibuilderSpecV0ModelsUnion.fromJson(v))
          .toList(),
      models: (json['models'] as List)
          .map((v) => IoApibuilderSpecV0ModelsModel.fromJson(v))
          .toList(),
      resources: (json['resources'] as List)
          .map((v) => IoApibuilderSpecV0ModelsResource.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
      annotations: (json['annotations'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAnnotation.fromJson(v))
          .toList(),
    );
  }

  final IoApibuilderSpecV0ModelsApidoc apidoc;

  final String name;

  final IoApibuilderSpecV0ModelsOrganization organization;

  final IoApibuilderSpecV0ModelsApplication application;

  final String namespace;

  final String version;

  final String? baseUrl;

  final String? description;

  final IoApibuilderSpecV0ModelsInfo info;

  final List<IoApibuilderSpecV0ModelsHeader> headers;

  final List<IoApibuilderSpecV0ModelsImport> imports;

  final List<IoApibuilderSpecV0ModelsEnum> enums;

  final List<IoApibuilderSpecV0ModelsInterface> interfaces;

  final List<IoApibuilderSpecV0ModelsUnion> unions;

  final List<IoApibuilderSpecV0ModelsModel> models;

  final List<IoApibuilderSpecV0ModelsResource> resources;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  final List<IoApibuilderSpecV0ModelsAnnotation> annotations;

  dynamic toJson() {
    return {
      'apidoc': apidoc.toJson(),
      'name': name,
      'organization': organization.toJson(),
      'application': application.toJson(),
      'namespace': namespace,
      'version': version,
      'base_url': baseUrl,
      'description': description,
      'info': info.toJson(),
      'headers': headers.map((v) => v.toJson()).toList(),
      'imports': imports.map((v) => v.toJson()).toList(),
      'enums': enums.map((v) => v.toJson()).toList(),
      'interfaces': interfaces.map((v) => v.toJson()).toList(),
      'unions': unions.map((v) => v.toJson()).toList(),
      'models': models.map((v) => v.toJson()).toList(),
      'resources': resources.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'annotations': annotations.map((v) => v.toJson()).toList()
    };
  }

  IoApibuilderSpecV0ModelsService copyWith({
    IoApibuilderSpecV0ModelsApidoc? apidoc,
    String? name,
    IoApibuilderSpecV0ModelsOrganization? organization,
    IoApibuilderSpecV0ModelsApplication? application,
    String? namespace,
    String? version,
    String? baseUrl,
    String? description,
    IoApibuilderSpecV0ModelsInfo? info,
    List<IoApibuilderSpecV0ModelsHeader>? headers,
    List<IoApibuilderSpecV0ModelsImport>? imports,
    List<IoApibuilderSpecV0ModelsEnum>? enums,
    List<IoApibuilderSpecV0ModelsInterface>? interfaces,
    List<IoApibuilderSpecV0ModelsUnion>? unions,
    List<IoApibuilderSpecV0ModelsModel>? models,
    List<IoApibuilderSpecV0ModelsResource>? resources,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
    List<IoApibuilderSpecV0ModelsAnnotation>? annotations,
  }) {
    return IoApibuilderSpecV0ModelsService(
      apidoc: apidoc ?? this.apidoc,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      application: application ?? this.application,
      namespace: namespace ?? this.namespace,
      version: version ?? this.version,
      baseUrl: baseUrl ?? this.baseUrl,
      description: description ?? this.description,
      info: info ?? this.info,
      headers: headers ?? this.headers,
      imports: imports ?? this.imports,
      enums: enums ?? this.enums,
      interfaces: interfaces ?? this.interfaces,
      unions: unions ?? this.unions,
      models: models ?? this.models,
      resources: resources ?? this.resources,
      attributes: attributes ?? this.attributes,
      annotations: annotations ?? this.annotations,
    );
  }

  @override
  List<Object?> get props {
    return [
      apidoc,
      name,
      organization,
      application,
      namespace,
      version,
      baseUrl,
      description,
      info,
      headers,
      imports,
      enums,
      interfaces,
      unions,
      models,
      resources,
      attributes,
      annotations
    ];
  }
}

class IoApibuilderSpecV0ModelsUnion extends Equatable {
  const IoApibuilderSpecV0ModelsUnion({
    required this.name,
    required this.plural,
    this.discriminator,
    this.description,
    this.deprecation,
    required this.types,
    required this.attributes,
    required this.interfaces,
  });

  factory IoApibuilderSpecV0ModelsUnion.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsUnion(
      name: json['name'] as String,
      plural: json['plural'] as String,
      discriminator: json['discriminator'] as String?,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      types: (json['types'] as List)
          .map((v) => IoApibuilderSpecV0ModelsUnionType.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
      interfaces: (json['interfaces'] as List).map((v) => v as String).toList(),
    );
  }

  final String name;

  final String plural;

  final String? discriminator;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsUnionType> types;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  final List<String> interfaces;

  dynamic toJson() {
    return {
      'name': name,
      'plural': plural,
      'discriminator': discriminator,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'types': types.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'interfaces': interfaces.map((v) => v).toList()
    };
  }

  IoApibuilderSpecV0ModelsUnion copyWith({
    String? name,
    String? plural,
    String? discriminator,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsUnionType>? types,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
    List<String>? interfaces,
  }) {
    return IoApibuilderSpecV0ModelsUnion(
      name: name ?? this.name,
      plural: plural ?? this.plural,
      discriminator: discriminator ?? this.discriminator,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      types: types ?? this.types,
      attributes: attributes ?? this.attributes,
      interfaces: interfaces ?? this.interfaces,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      plural,
      discriminator,
      description,
      deprecation,
      types,
      attributes,
      interfaces
    ];
  }
}

class IoApibuilderSpecV0ModelsUnionType extends Equatable {
  const IoApibuilderSpecV0ModelsUnionType({
    required this.type,
    this.description,
    this.deprecation,
    required this.attributes,
    this.default_,
    this.discriminatorValue,
  });

  factory IoApibuilderSpecV0ModelsUnionType.fromJson(dynamic json) {
    return IoApibuilderSpecV0ModelsUnionType(
      type: json['type'] as String,
      description: json['description'] as String?,
      deprecation: json['deprecation'] == null
          ? null
          : IoApibuilderSpecV0ModelsDeprecation.fromJson(json['deprecation']),
      attributes: (json['attributes'] as List)
          .map((v) => IoApibuilderSpecV0ModelsAttribute.fromJson(v))
          .toList(),
      default_: json['default'] as bool?,
      discriminatorValue: json['discriminator_value'] as String?,
    );
  }

  final String type;

  final String? description;

  final IoApibuilderSpecV0ModelsDeprecation? deprecation;

  final List<IoApibuilderSpecV0ModelsAttribute> attributes;

  final bool? default_;

  final String? discriminatorValue;

  dynamic toJson() {
    return {
      'type': type,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'default': default_,
      'discriminator_value': discriminatorValue
    };
  }

  IoApibuilderSpecV0ModelsUnionType copyWith({
    String? type,
    String? description,
    IoApibuilderSpecV0ModelsDeprecation? deprecation,
    List<IoApibuilderSpecV0ModelsAttribute>? attributes,
    bool? default_,
    String? discriminatorValue,
  }) {
    return IoApibuilderSpecV0ModelsUnionType(
      type: type ?? this.type,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
      default_: default_ ?? this.default_,
      discriminatorValue: discriminatorValue ?? this.discriminatorValue,
    );
  }

  @override
  List<Object?> get props {
    return [
      type,
      description,
      deprecation,
      attributes,
      default_,
      discriminatorValue
    ];
  }
}

class IoApibuilderSpecV0UnionsResponseCode
    extends Union2Impl<num, IoApibuilderSpecV0EnumsResponseCodeOption> {
  IoApibuilderSpecV0UnionsResponseCode._(
    super.union,
  );

  factory IoApibuilderSpecV0UnionsResponseCode.fromJson(dynamic json) {
    final discriminator = (json as Map).keys.first;
    switch (discriminator) {
      case 'integer':
        return IoApibuilderSpecV0UnionsResponseCode._(
          factory.first(json['integer']['value'] as num),
        );
      case 'response_code_option':
        return IoApibuilderSpecV0UnionsResponseCode._(
          factory.second(
            IoApibuilderSpecV0EnumsResponseCodeOption.values.byName(
              json['response_code_option'] as String,
            ),
          ),
        );
      default:
        throw Exception([
          discriminator,
          'Unsupported union type: $discriminator, expected: integer, response_code_option.'
        ]);
    }
  }

  static const factory =
      Doublet<num, IoApibuilderSpecV0EnumsResponseCodeOption>();

  dynamic toJson() {
    return join(
      (first) => {
        'integer': {'value': first},
      },
      (second) => {
        'response_code_option': second,
      },
    );
  }
}
