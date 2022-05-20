// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_section.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SurveySection extends SurveySection {
  @override
  final String? sectionId;
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final BuiltList<SurveyOption>? options;

  factory _$SurveySection([void Function(SurveySectionBuilder)? updates]) =>
      (new SurveySectionBuilder()..update(updates)).build();

  _$SurveySection._({this.sectionId, this.title, this.subtitle, this.options})
      : super._();

  @override
  SurveySection rebuild(void Function(SurveySectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SurveySectionBuilder toBuilder() => new SurveySectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SurveySection &&
        sectionId == other.sectionId &&
        title == other.title &&
        subtitle == other.subtitle &&
        options == other.options;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, sectionId.hashCode), title.hashCode), subtitle.hashCode),
        options.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SurveySection')
          ..add('sectionId', sectionId)
          ..add('title', title)
          ..add('subtitle', subtitle)
          ..add('options', options))
        .toString();
  }
}

class SurveySectionBuilder
    implements Builder<SurveySection, SurveySectionBuilder> {
  _$SurveySection? _$v;

  String? _sectionId;
  String? get sectionId => _$this._sectionId;
  set sectionId(String? sectionId) => _$this._sectionId = sectionId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  ListBuilder<SurveyOption>? _options;
  ListBuilder<SurveyOption> get options =>
      _$this._options ??= new ListBuilder<SurveyOption>();
  set options(ListBuilder<SurveyOption>? options) => _$this._options = options;

  SurveySectionBuilder() {
    SurveySection._defaults(this);
  }

  SurveySectionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sectionId = $v.sectionId;
      _title = $v.title;
      _subtitle = $v.subtitle;
      _options = $v.options?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SurveySection other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SurveySection;
  }

  @override
  void update(void Function(SurveySectionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SurveySection build() {
    _$SurveySection _$result;
    try {
      _$result = _$v ??
          new _$SurveySection._(
              sectionId: sectionId,
              title: title,
              subtitle: subtitle,
              options: _options?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'options';
        _options?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SurveySection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
