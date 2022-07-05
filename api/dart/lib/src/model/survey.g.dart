// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Survey extends Survey {
  @override
  final String? version;
  @override
  final BuiltList<SurveySection>? sections;

  factory _$Survey([void Function(SurveyBuilder)? updates]) =>
      (new SurveyBuilder()..update(updates)).build();

  _$Survey._({this.version, this.sections}) : super._();

  @override
  Survey rebuild(void Function(SurveyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SurveyBuilder toBuilder() => new SurveyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Survey &&
        version == other.version &&
        sections == other.sections;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, version.hashCode), sections.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Survey')
          ..add('version', version)
          ..add('sections', sections))
        .toString();
  }
}

class SurveyBuilder implements Builder<Survey, SurveyBuilder> {
  _$Survey? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  ListBuilder<SurveySection>? _sections;
  ListBuilder<SurveySection> get sections =>
      _$this._sections ??= new ListBuilder<SurveySection>();
  set sections(ListBuilder<SurveySection>? sections) =>
      _$this._sections = sections;

  SurveyBuilder() {
    Survey._defaults(this);
  }

  SurveyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _sections = $v.sections?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Survey other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Survey;
  }

  @override
  void update(void Function(SurveyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Survey build() {
    _$Survey _$result;
    try {
      _$result =
          _$v ?? new _$Survey._(version: version, sections: _sections?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sections';
        _sections?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Survey', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
