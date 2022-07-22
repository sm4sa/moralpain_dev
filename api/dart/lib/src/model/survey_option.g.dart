// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_option.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SurveyOption extends SurveyOption {
  @override
  final String? id;
  @override
  final String? description;

  factory _$SurveyOption([void Function(SurveyOptionBuilder)? updates]) =>
      (new SurveyOptionBuilder()..update(updates))._build();

  _$SurveyOption._({this.id, this.description}) : super._();

  @override
  SurveyOption rebuild(void Function(SurveyOptionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SurveyOptionBuilder toBuilder() => new SurveyOptionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SurveyOption &&
        id == other.id &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SurveyOption')
          ..add('id', id)
          ..add('description', description))
        .toString();
  }
}

class SurveyOptionBuilder
    implements Builder<SurveyOption, SurveyOptionBuilder> {
  _$SurveyOption? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  SurveyOptionBuilder() {
    SurveyOption._defaults(this);
  }

  SurveyOptionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SurveyOption other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SurveyOption;
  }

  @override
  void update(void Function(SurveyOptionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SurveyOption build() => _build();

  _$SurveyOption _build() {
    final _$result =
        _$v ?? new _$SurveyOption._(id: id, description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
