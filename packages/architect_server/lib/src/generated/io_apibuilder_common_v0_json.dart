/// {@template io_apibuilder_common_v0_json}
/// Models in common across various APIs in apibuilder
/// {@endtemplate}
library io_apibuilder_common_v0_json;

import 'dart:core' as _i2;

import 'package:equatable/equatable.dart' as _i1;

class Audit extends _i1.Equatable {
  const Audit({
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory Audit.fromJson(_i2.dynamic json) {
    return Audit(
      createdAt: _i2.DateTime.parse((json['created_at'] as _i2.String)),
      createdBy: ReferenceGuid.fromJson(json['created_by']),
      updatedAt: _i2.DateTime.parse((json['updated_at'] as _i2.String)),
      updatedBy: ReferenceGuid.fromJson(json['updated_by']),
    );
  }

  final _i2.DateTime createdAt;

  final ReferenceGuid createdBy;

  final _i2.DateTime updatedAt;

  final ReferenceGuid updatedBy;

  _i2.dynamic toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy.toJson(),
      'updated_at': updatedAt.toIso8601String(),
      'updated_by': updatedBy.toJson()
    };
  }

  Audit copyWith({
    _i2.DateTime? createdAt,
    ReferenceGuid? createdBy,
    _i2.DateTime? updatedAt,
    ReferenceGuid? updatedBy,
  }) {
    return Audit(
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [createdAt, createdBy, updatedAt, updatedBy];
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

/// {@template reference}
/// Represents a reference to another model.
/// {@endtemplate}
class Reference extends _i1.Equatable {
  /// {@macro reference}
  const Reference({
    required this.guid,
    required this.key,
  });

  factory Reference.fromJson(_i2.dynamic json) {
    return Reference(
      guid: (json['guid'] as _i2.String),
      key: (json['key'] as _i2.String),
    );
  }

  final _i2.String guid;

  final _i2.String key;

  _i2.dynamic toJson() {
    return {'guid': guid, 'key': key};
  }

  Reference copyWith({
    _i2.String? guid,
    _i2.String? key,
  }) {
    return Reference(
      guid: guid ?? this.guid,
      key: key ?? this.key,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [guid, key];
  }
}

class ReferenceGuid extends _i1.Equatable {
  const ReferenceGuid({required this.guid});

  factory ReferenceGuid.fromJson(_i2.dynamic json) {
    return ReferenceGuid(guid: (json['guid'] as _i2.String));
  }

  final _i2.String guid;

  _i2.dynamic toJson() {
    return {'guid': guid};
  }

  ReferenceGuid copyWith({_i2.String? guid}) {
    return ReferenceGuid(guid: guid ?? this.guid);
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [guid];
  }
}
