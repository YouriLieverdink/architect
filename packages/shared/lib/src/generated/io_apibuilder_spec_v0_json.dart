library io_apibuilder_spec_v0_json;

import 'dart:core' as _i2;

import 'package:equatable/equatable.dart' as _i1;
import 'package:sealed_unions/sealed_unions.dart' as _i3;

enum Method { get_, post, put, patch, delete, head, connect, options, trace }

enum ParameterLocation { path, query, form, header }

enum ResponseCodeOption { default_ }

class Annotation extends _i1.Equatable {
  const Annotation({
    required this.name,
    this.description,
    this.deprecation,
  });

  factory Annotation.fromJson(_i2.dynamic json) {
    return Annotation(
      name: (json['name'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
    );
  }

  final _i2.String name;

  final _i2.String? description;

  final Deprecation? deprecation;

  _i2.dynamic toJson() {
    return {
      'name': name,
      'description': description,
      'deprecation': deprecation?.toJson()
    };
  }

  Annotation copyWith({
    _i2.String? name,
    _i2.String? description,
    Deprecation? deprecation,
  }) {
    return Annotation(
      name: name ?? this.name,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, description, deprecation];
  }
}

class Apidoc extends _i1.Equatable {
  const Apidoc({required this.version});

  factory Apidoc.fromJson(_i2.dynamic json) {
    return Apidoc(version: (json['version'] as _i2.String));
  }

  final _i2.String version;

  _i2.dynamic toJson() {
    return {'version': version};
  }

  Apidoc copyWith({_i2.String? version}) {
    return Apidoc(version: version ?? this.version);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [version];
  }
}

class Application extends _i1.Equatable {
  const Application({required this.key});

  factory Application.fromJson(_i2.dynamic json) {
    return Application(key: (json['key'] as _i2.String));
  }

  final _i2.String key;

  _i2.dynamic toJson() {
    return {'key': key};
  }

  Application copyWith({_i2.String? key}) {
    return Application(key: key ?? this.key);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [key];
  }
}

class Attribute extends _i1.Equatable {
  const Attribute({
    required this.name,
    required this.value,
    this.description,
    this.deprecation,
  });

  factory Attribute.fromJson(_i2.dynamic json) {
    return Attribute(
      name: (json['name'] as _i2.String),
      value: (json['value'] as _i2.dynamic),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
    );
  }

  final _i2.String name;

  final _i2.dynamic value;

  final _i2.String? description;

  final Deprecation? deprecation;

  _i2.dynamic toJson() {
    return {
      'name': name,
      'value': value,
      'description': description,
      'deprecation': deprecation?.toJson()
    };
  }

  Attribute copyWith({
    _i2.String? name,
    _i2.dynamic? value,
    _i2.String? description,
    Deprecation? deprecation,
  }) {
    return Attribute(
      name: name ?? this.name,
      value: value ?? this.value,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, value, description, deprecation];
  }
}

class Body extends _i1.Equatable {
  const Body({
    required this.type,
    this.description,
    this.deprecation,
    required this.attributes,
  });

  factory Body.fromJson(_i2.dynamic json) {
    return Body(
      type: (json['type'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final _i2.String type;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<Attribute> attributes;

  _i2.dynamic toJson() {
    return {
      'type': type,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  Body copyWith({
    _i2.String? type,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<Attribute>? attributes,
  }) {
    return Body(
      type: type ?? this.type,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [type, description, deprecation, attributes];
  }
}

class Contact extends _i1.Equatable {
  const Contact({
    this.name,
    this.url,
    this.email,
  });

  factory Contact.fromJson(_i2.dynamic json) {
    return Contact(
      name: (json['name'] as _i2.String?),
      url: (json['url'] as _i2.String?),
      email: (json['email'] as _i2.String?),
    );
  }

  final _i2.String? name;

  final _i2.String? url;

  final _i2.String? email;

  _i2.dynamic toJson() {
    return {'name': name, 'url': url, 'email': email};
  }

  Contact copyWith({
    _i2.String? name,
    _i2.String? url,
    _i2.String? email,
  }) {
    return Contact(
      name: name ?? this.name,
      url: url ?? this.url,
      email: email ?? this.email,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, url, email];
  }
}

class Deprecation extends _i1.Equatable {
  const Deprecation({this.description});

  factory Deprecation.fromJson(_i2.dynamic json) {
    return Deprecation(description: (json['description'] as _i2.String?));
  }

  final _i2.String? description;

  _i2.dynamic toJson() {
    return {'description': description};
  }

  Deprecation copyWith({_i2.String? description}) {
    return Deprecation(description: description ?? this.description);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [description];
  }
}

class Enum extends _i1.Equatable {
  const Enum({
    required this.name,
    required this.plural,
    this.description,
    this.deprecation,
    required this.values,
    required this.attributes,
  });

  factory Enum.fromJson(_i2.dynamic json) {
    return Enum(
      name: (json['name'] as _i2.String),
      plural: (json['plural'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      values: (json['values'] as _i2.List)
          .map((v) => EnumValue.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final _i2.String name;

  final _i2.String plural;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<EnumValue> values;

  final _i2.List<Attribute> attributes;

  _i2.dynamic toJson() {
    return {
      'name': name,
      'plural': plural,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'values': values.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  Enum copyWith({
    _i2.String? name,
    _i2.String? plural,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<EnumValue>? values,
    _i2.List<Attribute>? attributes,
  }) {
    return Enum(
      name: name ?? this.name,
      plural: plural ?? this.plural,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      values: values ?? this.values,
      attributes: attributes ?? this.attributes,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, plural, description, deprecation, values, attributes];
  }
}

class EnumValue extends _i1.Equatable {
  const EnumValue({
    required this.name,
    this.description,
    this.deprecation,
    required this.attributes,
    this.value,
  });

  factory EnumValue.fromJson(_i2.dynamic json) {
    return EnumValue(
      name: (json['name'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
      value: (json['value'] as _i2.String?),
    );
  }

  final _i2.String name;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<Attribute> attributes;

  final _i2.String? value;

  _i2.dynamic toJson() {
    return {
      'name': name,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'value': value
    };
  }

  EnumValue copyWith({
    _i2.String? name,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<Attribute>? attributes,
    _i2.String? value,
  }) {
    return EnumValue(
      name: name ?? this.name,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
      value: value ?? this.value,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, description, deprecation, attributes, value];
  }
}

class Field extends _i1.Equatable {
  const Field({
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

  factory Field.fromJson(_i2.dynamic json) {
    return Field(
      name: (json['name'] as _i2.String),
      type: (json['type'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      default_: (json['default'] as _i2.String?),
      required: (json['required'] as _i2.bool),
      minimum: (json['minimum'] as _i2.int?),
      maximum: (json['maximum'] as _i2.int?),
      example: (json['example'] as _i2.String?),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
      annotations: (json['annotations'] as _i2.List)
          .map((v) => (v as _i2.String))
          .toList(),
    );
  }

  final _i2.String name;

  final _i2.String type;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.String? default_;

  final _i2.bool required;

  final _i2.int? minimum;

  final _i2.int? maximum;

  final _i2.String? example;

  final _i2.List<Attribute> attributes;

  final _i2.List<_i2.String> annotations;

  _i2.dynamic toJson() {
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

  Field copyWith({
    _i2.String? name,
    _i2.String? type,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.String? default_,
    _i2.bool? required,
    _i2.int? minimum,
    _i2.int? maximum,
    _i2.String? example,
    _i2.List<Attribute>? attributes,
    _i2.List<_i2.String>? annotations,
  }) {
    return Field(
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

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Header extends _i1.Equatable {
  const Header({
    required this.name,
    required this.type,
    this.description,
    this.deprecation,
    required this.required,
    this.default_,
    required this.attributes,
  });

  factory Header.fromJson(_i2.dynamic json) {
    return Header(
      name: (json['name'] as _i2.String),
      type: (json['type'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      required: (json['required'] as _i2.bool),
      default_: (json['default'] as _i2.String?),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final _i2.String name;

  final _i2.String type;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.bool required;

  final _i2.String? default_;

  final _i2.List<Attribute> attributes;

  _i2.dynamic toJson() {
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

  Header copyWith({
    _i2.String? name,
    _i2.String? type,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.bool? required,
    _i2.String? default_,
    _i2.List<Attribute>? attributes,
  }) {
    return Header(
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      required: required ?? this.required,
      default_: default_ ?? this.default_,
      attributes: attributes ?? this.attributes,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Import extends _i1.Equatable {
  const Import({
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

  factory Import.fromJson(_i2.dynamic json) {
    return Import(
      uri: (json['uri'] as _i2.String),
      namespace: (json['namespace'] as _i2.String),
      organization: Organization.fromJson(json['organization']),
      application: Application.fromJson(json['application']),
      version: (json['version'] as _i2.String),
      enums: (json['enums'] as _i2.List).map((v) => (v as _i2.String)).toList(),
      interfaces: (json['interfaces'] as _i2.List)
          .map((v) => (v as _i2.String))
          .toList(),
      unions:
          (json['unions'] as _i2.List).map((v) => (v as _i2.String)).toList(),
      models:
          (json['models'] as _i2.List).map((v) => (v as _i2.String)).toList(),
      annotations: (json['annotations'] as _i2.List)
          .map((v) => Annotation.fromJson(v))
          .toList(),
    );
  }

  final _i2.String uri;

  final _i2.String namespace;

  final Organization organization;

  final Application application;

  final _i2.String version;

  final _i2.List<_i2.String> enums;

  final _i2.List<_i2.String> interfaces;

  final _i2.List<_i2.String> unions;

  final _i2.List<_i2.String> models;

  final _i2.List<Annotation> annotations;

  _i2.dynamic toJson() {
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

  Import copyWith({
    _i2.String? uri,
    _i2.String? namespace,
    Organization? organization,
    Application? application,
    _i2.String? version,
    _i2.List<_i2.String>? enums,
    _i2.List<_i2.String>? interfaces,
    _i2.List<_i2.String>? unions,
    _i2.List<_i2.String>? models,
    _i2.List<Annotation>? annotations,
  }) {
    return Import(
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

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Info extends _i1.Equatable {
  const Info({
    this.license,
    this.contact,
  });

  factory Info.fromJson(_i2.dynamic json) {
    return Info(
      license:
          json['license'] == null ? null : License?.fromJson(json['license']),
      contact:
          json['contact'] == null ? null : Contact?.fromJson(json['contact']),
    );
  }

  final License? license;

  final Contact? contact;

  _i2.dynamic toJson() {
    return {'license': license?.toJson(), 'contact': contact?.toJson()};
  }

  Info copyWith({
    License? license,
    Contact? contact,
  }) {
    return Info(
      license: license ?? this.license,
      contact: contact ?? this.contact,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [license, contact];
  }
}

class Interface extends _i1.Equatable {
  const Interface({
    required this.name,
    required this.plural,
    this.description,
    this.deprecation,
    required this.fields,
    required this.attributes,
  });

  factory Interface.fromJson(_i2.dynamic json) {
    return Interface(
      name: (json['name'] as _i2.String),
      plural: (json['plural'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      fields:
          (json['fields'] as _i2.List).map((v) => Field.fromJson(v)).toList(),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final _i2.String name;

  final _i2.String plural;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<Field> fields;

  final _i2.List<Attribute> attributes;

  _i2.dynamic toJson() {
    return {
      'name': name,
      'plural': plural,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'fields': fields.map((v) => v.toJson()).toList(),
      'attributes': attributes.map((v) => v.toJson()).toList()
    };
  }

  Interface copyWith({
    _i2.String? name,
    _i2.String? plural,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<Field>? fields,
    _i2.List<Attribute>? attributes,
  }) {
    return Interface(
      name: name ?? this.name,
      plural: plural ?? this.plural,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      fields: fields ?? this.fields,
      attributes: attributes ?? this.attributes,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, plural, description, deprecation, fields, attributes];
  }
}

class License extends _i1.Equatable {
  const License({
    required this.name,
    this.url,
  });

  factory License.fromJson(_i2.dynamic json) {
    return License(
      name: (json['name'] as _i2.String),
      url: (json['url'] as _i2.String?),
    );
  }

  final _i2.String name;

  final _i2.String? url;

  _i2.dynamic toJson() {
    return {'name': name, 'url': url};
  }

  License copyWith({
    _i2.String? name,
    _i2.String? url,
  }) {
    return License(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [name, url];
  }
}

class Model extends _i1.Equatable {
  const Model({
    required this.name,
    required this.plural,
    this.description,
    this.deprecation,
    required this.fields,
    required this.attributes,
    required this.interfaces,
  });

  factory Model.fromJson(_i2.dynamic json) {
    return Model(
      name: (json['name'] as _i2.String),
      plural: (json['plural'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      fields:
          (json['fields'] as _i2.List).map((v) => Field.fromJson(v)).toList(),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
      interfaces: (json['interfaces'] as _i2.List)
          .map((v) => (v as _i2.String))
          .toList(),
    );
  }

  final _i2.String name;

  final _i2.String plural;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<Field> fields;

  final _i2.List<Attribute> attributes;

  final _i2.List<_i2.String> interfaces;

  _i2.dynamic toJson() {
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

  Model copyWith({
    _i2.String? name,
    _i2.String? plural,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<Field>? fields,
    _i2.List<Attribute>? attributes,
    _i2.List<_i2.String>? interfaces,
  }) {
    return Model(
      name: name ?? this.name,
      plural: plural ?? this.plural,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      fields: fields ?? this.fields,
      attributes: attributes ?? this.attributes,
      interfaces: interfaces ?? this.interfaces,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Operation extends _i1.Equatable {
  const Operation({
    required this.method,
    required this.path,
    this.description,
    this.deprecation,
    this.body,
    required this.parameters,
    required this.responses,
    required this.attributes,
  });

  factory Operation.fromJson(_i2.dynamic json) {
    return Operation(
      method: Method.values.byName((json['method'] as _i2.String)),
      path: (json['path'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      body: json['body'] == null ? null : Body?.fromJson(json['body']),
      parameters: (json['parameters'] as _i2.List)
          .map((v) => Parameter.fromJson(v))
          .toList(),
      responses: (json['responses'] as _i2.List)
          .map((v) => Response.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final Method method;

  final _i2.String path;

  final _i2.String? description;

  final Deprecation? deprecation;

  final Body? body;

  final _i2.List<Parameter> parameters;

  final _i2.List<Response> responses;

  final _i2.List<Attribute> attributes;

  _i2.dynamic toJson() {
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

  Operation copyWith({
    Method? method,
    _i2.String? path,
    _i2.String? description,
    Deprecation? deprecation,
    Body? body,
    _i2.List<Parameter>? parameters,
    _i2.List<Response>? responses,
    _i2.List<Attribute>? attributes,
  }) {
    return Operation(
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

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Organization extends _i1.Equatable {
  const Organization({required this.key});

  factory Organization.fromJson(_i2.dynamic json) {
    return Organization(key: (json['key'] as _i2.String));
  }

  final _i2.String key;

  _i2.dynamic toJson() {
    return {'key': key};
  }

  Organization copyWith({_i2.String? key}) {
    return Organization(key: key ?? this.key);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [key];
  }
}

class Parameter extends _i1.Equatable {
  const Parameter({
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

  factory Parameter.fromJson(_i2.dynamic json) {
    return Parameter(
      name: (json['name'] as _i2.String),
      type: (json['type'] as _i2.String),
      location:
          ParameterLocation.values.byName((json['location'] as _i2.String)),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      required: (json['required'] as _i2.bool),
      default_: (json['default'] as _i2.String?),
      minimum: (json['minimum'] as _i2.int?),
      maximum: (json['maximum'] as _i2.int?),
      example: (json['example'] as _i2.String?),
      attributes: (json['attributes'] as _i2.List?)
          ?.map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final _i2.String name;

  final _i2.String type;

  final ParameterLocation location;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.bool required;

  final _i2.String? default_;

  final _i2.int? minimum;

  final _i2.int? maximum;

  final _i2.String? example;

  final _i2.List<Attribute>? attributes;

  _i2.dynamic toJson() {
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

  Parameter copyWith({
    _i2.String? name,
    _i2.String? type,
    ParameterLocation? location,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.bool? required,
    _i2.String? default_,
    _i2.int? minimum,
    _i2.int? maximum,
    _i2.String? example,
    _i2.List<Attribute>? attributes,
  }) {
    return Parameter(
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

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Resource extends _i1.Equatable {
  const Resource({
    required this.type,
    required this.plural,
    this.path,
    this.description,
    this.deprecation,
    required this.operations,
    required this.attributes,
  });

  factory Resource.fromJson(_i2.dynamic json) {
    return Resource(
      type: (json['type'] as _i2.String),
      plural: (json['plural'] as _i2.String),
      path: (json['path'] as _i2.String?),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      operations: (json['operations'] as _i2.List)
          .map((v) => Operation.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final _i2.String type;

  final _i2.String plural;

  final _i2.String? path;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<Operation> operations;

  final _i2.List<Attribute> attributes;

  _i2.dynamic toJson() {
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

  Resource copyWith({
    _i2.String? type,
    _i2.String? plural,
    _i2.String? path,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<Operation>? operations,
    _i2.List<Attribute>? attributes,
  }) {
    return Resource(
      type: type ?? this.type,
      plural: plural ?? this.plural,
      path: path ?? this.path,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      operations: operations ?? this.operations,
      attributes: attributes ?? this.attributes,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Response extends _i1.Equatable {
  const Response({
    required this.code,
    required this.type,
    this.headers,
    this.description,
    this.deprecation,
    this.attributes,
  });

  factory Response.fromJson(_i2.dynamic json) {
    return Response(
      code: ResponseCode.fromJson(json['code']),
      type: (json['type'] as _i2.String),
      headers: (json['headers'] as _i2.List?)
          ?.map((v) => Header.fromJson(v))
          .toList(),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      attributes: (json['attributes'] as _i2.List?)
          ?.map((v) => Attribute.fromJson(v))
          .toList(),
    );
  }

  final ResponseCode code;

  final _i2.String type;

  final _i2.List<Header>? headers;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<Attribute>? attributes;

  _i2.dynamic toJson() {
    return {
      'code': code.toJson(),
      'type': type,
      'headers': headers?.map((v) => v.toJson()).toList(),
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes?.map((v) => v.toJson()).toList()
    };
  }

  Response copyWith({
    ResponseCode? code,
    _i2.String? type,
    _i2.List<Header>? headers,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<Attribute>? attributes,
  }) {
    return Response(
      code: code ?? this.code,
      type: type ?? this.type,
      headers: headers ?? this.headers,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [code, type, headers, description, deprecation, attributes];
  }
}

class Service extends _i1.Equatable {
  const Service({
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

  factory Service.fromJson(_i2.dynamic json) {
    return Service(
      apidoc: Apidoc.fromJson(json['apidoc']),
      name: (json['name'] as _i2.String),
      organization: Organization.fromJson(json['organization']),
      application: Application.fromJson(json['application']),
      namespace: (json['namespace'] as _i2.String),
      version: (json['version'] as _i2.String),
      baseUrl: (json['base_url'] as _i2.String?),
      description: (json['description'] as _i2.String?),
      info: Info.fromJson(json['info']),
      headers:
          (json['headers'] as _i2.List).map((v) => Header.fromJson(v)).toList(),
      imports:
          (json['imports'] as _i2.List).map((v) => Import.fromJson(v)).toList(),
      enums: (json['enums'] as _i2.List).map((v) => Enum.fromJson(v)).toList(),
      interfaces: (json['interfaces'] as _i2.List)
          .map((v) => Interface.fromJson(v))
          .toList(),
      unions:
          (json['unions'] as _i2.List).map((v) => Union.fromJson(v)).toList(),
      models:
          (json['models'] as _i2.List).map((v) => Model.fromJson(v)).toList(),
      resources: (json['resources'] as _i2.List)
          .map((v) => Resource.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
      annotations: (json['annotations'] as _i2.List)
          .map((v) => Annotation.fromJson(v))
          .toList(),
    );
  }

  final Apidoc apidoc;

  final _i2.String name;

  final Organization organization;

  final Application application;

  final _i2.String namespace;

  final _i2.String version;

  final _i2.String? baseUrl;

  final _i2.String? description;

  final Info info;

  final _i2.List<Header> headers;

  final _i2.List<Import> imports;

  final _i2.List<Enum> enums;

  final _i2.List<Interface> interfaces;

  final _i2.List<Union> unions;

  final _i2.List<Model> models;

  final _i2.List<Resource> resources;

  final _i2.List<Attribute> attributes;

  final _i2.List<Annotation> annotations;

  _i2.dynamic toJson() {
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

  Service copyWith({
    Apidoc? apidoc,
    _i2.String? name,
    Organization? organization,
    Application? application,
    _i2.String? namespace,
    _i2.String? version,
    _i2.String? baseUrl,
    _i2.String? description,
    Info? info,
    _i2.List<Header>? headers,
    _i2.List<Import>? imports,
    _i2.List<Enum>? enums,
    _i2.List<Interface>? interfaces,
    _i2.List<Union>? unions,
    _i2.List<Model>? models,
    _i2.List<Resource>? resources,
    _i2.List<Attribute>? attributes,
    _i2.List<Annotation>? annotations,
  }) {
    return Service(
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

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class Union extends _i1.Equatable {
  const Union({
    required this.name,
    required this.plural,
    this.discriminator,
    this.description,
    this.deprecation,
    required this.types,
    required this.attributes,
    required this.interfaces,
  });

  factory Union.fromJson(_i2.dynamic json) {
    return Union(
      name: (json['name'] as _i2.String),
      plural: (json['plural'] as _i2.String),
      discriminator: (json['discriminator'] as _i2.String?),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      types: (json['types'] as _i2.List)
          .map((v) => UnionType.fromJson(v))
          .toList(),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
      interfaces: (json['interfaces'] as _i2.List)
          .map((v) => (v as _i2.String))
          .toList(),
    );
  }

  final _i2.String name;

  final _i2.String plural;

  final _i2.String? discriminator;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<UnionType> types;

  final _i2.List<Attribute> attributes;

  final _i2.List<_i2.String> interfaces;

  _i2.dynamic toJson() {
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

  Union copyWith({
    _i2.String? name,
    _i2.String? plural,
    _i2.String? discriminator,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<UnionType>? types,
    _i2.List<Attribute>? attributes,
    _i2.List<_i2.String>? interfaces,
  }) {
    return Union(
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

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class UnionType extends _i1.Equatable {
  const UnionType({
    required this.type,
    this.description,
    this.deprecation,
    required this.attributes,
    this.default_,
    this.discriminatorValue,
  });

  factory UnionType.fromJson(_i2.dynamic json) {
    return UnionType(
      type: (json['type'] as _i2.String),
      description: (json['description'] as _i2.String?),
      deprecation: json['deprecation'] == null
          ? null
          : Deprecation?.fromJson(json['deprecation']),
      attributes: (json['attributes'] as _i2.List)
          .map((v) => Attribute.fromJson(v))
          .toList(),
      default_: (json['default'] as _i2.bool?),
      discriminatorValue: (json['discriminator_value'] as _i2.String?),
    );
  }

  final _i2.String type;

  final _i2.String? description;

  final Deprecation? deprecation;

  final _i2.List<Attribute> attributes;

  final _i2.bool? default_;

  final _i2.String? discriminatorValue;

  _i2.dynamic toJson() {
    return {
      'type': type,
      'description': description,
      'deprecation': deprecation?.toJson(),
      'attributes': attributes.map((v) => v.toJson()).toList(),
      'default': default_,
      'discriminator_value': discriminatorValue
    };
  }

  UnionType copyWith({
    _i2.String? type,
    _i2.String? description,
    Deprecation? deprecation,
    _i2.List<Attribute>? attributes,
    _i2.bool? default_,
    _i2.String? discriminatorValue,
  }) {
    return UnionType(
      type: type ?? this.type,
      description: description ?? this.description,
      deprecation: deprecation ?? this.deprecation,
      attributes: attributes ?? this.attributes,
      default_: default_ ?? this.default_,
      discriminatorValue: discriminatorValue ?? this.discriminatorValue,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
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

class ResponseCode extends _i3.Union2Impl<_i2.int, ResponseCodeOption> {
  ResponseCode._(super.union);

  factory ResponseCode.fromJson(_i2.dynamic json) {
    final type = (json as _i2.Map).keys.first;

    switch (type) {
      case 'integer':
        return ResponseCode._(
            factory.first((json['integer']['value'] as _i2.int)));

      case 'response_code_option':
        return ResponseCode._(factory.second(ResponseCodeOption.values
            .byName((json['response_code_option']['value'] as _i2.String))));

      default:
        throw _i2.Exception();
    }
  }

  static const factory = _i3.Doublet<_i2.int, ResponseCodeOption>();

  _i2.dynamic toJson() {
    return join(
      (v) {
        return {
          'integer': {'value': v}
        };
      },
      (v) {
        return {
          'response_code_option': {'value': v.name}
        };
      },
    );
  }
}
