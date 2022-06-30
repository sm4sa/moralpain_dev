// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submissions.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Submissions extends Submissions {
  @override
  final BuiltList<Submission>? list;

  factory _$Submissions([void Function(SubmissionsBuilder)? updates]) =>
      (new SubmissionsBuilder()..update(updates)).build();

  _$Submissions._({this.list}) : super._();

  @override
  Submissions rebuild(void Function(SubmissionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubmissionsBuilder toBuilder() => new SubmissionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Submissions && list == other.list;
  }

  @override
  int get hashCode {
    return $jf($jc(0, list.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Submissions')..add('list', list))
        .toString();
  }
}

class SubmissionsBuilder implements Builder<Submissions, SubmissionsBuilder> {
  _$Submissions? _$v;

  ListBuilder<Submission>? _list;
  ListBuilder<Submission> get list =>
      _$this._list ??= new ListBuilder<Submission>();
  set list(ListBuilder<Submission>? list) => _$this._list = list;

  SubmissionsBuilder() {
    Submissions._defaults(this);
  }

  SubmissionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _list = $v.list?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Submissions other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Submissions;
  }

  @override
  void update(void Function(SubmissionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Submissions build() {
    _$Submissions _$result;
    try {
      _$result = _$v ?? new _$Submissions._(list: _list?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'list';
        _list?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Submissions', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
