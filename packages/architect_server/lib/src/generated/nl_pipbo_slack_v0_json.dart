library nl_pipbo_slack_v0_json;

import 'dart:core' as _i2;

import 'package:equatable/equatable.dart' as _i1;

class Attachment extends _i1.Equatable {
  const Attachment({
    required this.fallback,
    this.text,
    this.pretext,
    required this.color,
    required this.fields,
  });

  factory Attachment.fromJson(_i2.dynamic json) {
    return Attachment(
      fallback: (json['fallback'] as _i2.String),
      text: (json['text'] as _i2.String?),
      pretext: (json['pretext'] as _i2.String?),
      color: (json['color'] as _i2.String),
      fields:
          (json['fields'] as _i2.List).map((v) => Field.fromJson(v)).toList(),
    );
  }

  final _i2.String fallback;

  final _i2.String? text;

  final _i2.String? pretext;

  final _i2.String color;

  final _i2.List<Field> fields;

  _i2.dynamic toJson() {
    return {
      'fallback': fallback,
      'text': text,
      'pretext': pretext,
      'color': color,
      'fields': fields.map((v) => v.toJson()).toList()
    };
  }

  Attachment copyWith({
    _i2.String? fallback,
    _i2.String? text,
    _i2.String? pretext,
    _i2.String? color,
    _i2.List<Field>? fields,
  }) {
    return Attachment(
      fallback: fallback ?? this.fallback,
      text: text ?? this.text,
      pretext: pretext ?? this.pretext,
      color: color ?? this.color,
      fields: fields ?? this.fields,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [fallback, text, pretext, color, fields];
  }
}

class Field extends _i1.Equatable {
  const Field({
    required this.title,
    required this.value,
    required this.short,
  });

  factory Field.fromJson(_i2.dynamic json) {
    return Field(
      title: (json['title'] as _i2.String),
      value: (json['value'] as _i2.String),
      short: (json['short'] as _i2.bool),
    );
  }

  final _i2.String title;

  final _i2.String value;

  final _i2.bool short;

  _i2.dynamic toJson() {
    return {'title': title, 'value': value, 'short': short};
  }

  Field copyWith({
    _i2.String? title,
    _i2.String? value,
    _i2.bool? short,
  }) {
    return Field(
      title: title ?? this.title,
      value: value ?? this.value,
      short: short ?? this.short,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [title, value, short];
  }
}

class Message extends _i1.Equatable {
  const Message({
    this.text,
    this.username,
    this.iconUrl,
    this.channel,
    this.attachments,
  });

  factory Message.fromJson(_i2.dynamic json) {
    return Message(
      text: (json['text'] as _i2.String?),
      username: (json['username'] as _i2.String?),
      iconUrl: (json['icon_url'] as _i2.String?),
      channel: (json['channel'] as _i2.String?),
      attachments: (json['attachments'] as _i2.List?)
          ?.map((v) => Attachment.fromJson(v))
          .toList(),
    );
  }

  final _i2.String? text;

  final _i2.String? username;

  final _i2.String? iconUrl;

  final _i2.String? channel;

  final _i2.List<Attachment>? attachments;

  _i2.dynamic toJson() {
    return {
      'text': text,
      'username': username,
      'icon_url': iconUrl,
      'channel': channel,
      'attachments': attachments?.map((v) => v.toJson()).toList()
    };
  }

  Message copyWith({
    _i2.String? text,
    _i2.String? username,
    _i2.String? iconUrl,
    _i2.String? channel,
    _i2.List<Attachment>? attachments,
  }) {
    return Message(
      text: text ?? this.text,
      username: username ?? this.username,
      iconUrl: iconUrl ?? this.iconUrl,
      channel: channel ?? this.channel,
      attachments: attachments ?? this.attachments,
    );
  }

  @_i2.override
  _i2.List<_i2.Object?> get props {
    return [text, username, iconUrl, channel, attachments];
  }
}
