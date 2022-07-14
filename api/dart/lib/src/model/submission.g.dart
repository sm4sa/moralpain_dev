// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Submission extends Submission {
  @override
  final int? score;
  @override
  final BuiltList<String>? selections;
  @override
  final int? timestamp;
  @override
  final String? id;

  factory _$Submission([void Function(SubmissionBuilder)? updates]) =>
      (new SubmissionBuilder()..update(updates))._build();

  _$Submission._({this.score, this.selections, this.timestamp, this.id})
      : super._();

  @override
  Submission rebuild(void Function(SubmissionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmissionBuilder toBuilder() => new SubmissionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Submission &&
        score == other.score &&
        selections == other.selections &&
        timestamp == other.timestamp &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, score.hashCode), selections.hashCode),
            timestamp.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Submission')
          ..add('score', score)
          ..add('selections', selections)
          ..add('timestamp', timestamp)
          ..add('id', id))
        .toString();
  }
}

class SubmissionBuilder implements Builder<Submission, SubmissionBuilder> {
  _$Submission? _$v;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  ListBuilder<String>? _selections;
  ListBuilder<String> get selections =>
      _$this._selections ??= new ListBuilder<String>();
  set selections(ListBuilder<String>? selections) =>
      _$this._selections = selections;

  int? _timestamp;
  int? get timestamp => _$this._timestamp;
  set timestamp(int? timestamp) => _$this._timestamp = timestamp;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  SubmissionBuilder() {
    Submission._defaults(this);
  }

  SubmissionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score = $v.score;
      _selections = $v.selections?.toBuilder();
      _timestamp = $v.timestamp;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Submission other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Submission;
  }

  @override
  void update(void Function(SubmissionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Submission build() => _build();

  _$Submission _build() {
    _$Submission _$result;
    try {
      _$result = _$v ??
          new _$Submission._(
              score: score,
              selections: _selections?.build(),
              timestamp: timestamp,
              id: id);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'selections';
        _selections?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Submission', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
