// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AnalyticsResultOperationEnum _$analyticsResultOperationEnum_average =
    const AnalyticsResultOperationEnum._('average');
const AnalyticsResultOperationEnum _$analyticsResultOperationEnum_count =
    const AnalyticsResultOperationEnum._('count');
const AnalyticsResultOperationEnum _$analyticsResultOperationEnum_maximum =
    const AnalyticsResultOperationEnum._('maximum');
const AnalyticsResultOperationEnum _$analyticsResultOperationEnum_minimum =
    const AnalyticsResultOperationEnum._('minimum');

AnalyticsResultOperationEnum _$analyticsResultOperationEnumValueOf(
    String name) {
  switch (name) {
    case 'average':
      return _$analyticsResultOperationEnum_average;
    case 'count':
      return _$analyticsResultOperationEnum_count;
    case 'maximum':
      return _$analyticsResultOperationEnum_maximum;
    case 'minimum':
      return _$analyticsResultOperationEnum_minimum;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AnalyticsResultOperationEnum>
    _$analyticsResultOperationEnumValues = new BuiltSet<
        AnalyticsResultOperationEnum>(const <AnalyticsResultOperationEnum>[
  _$analyticsResultOperationEnum_average,
  _$analyticsResultOperationEnum_count,
  _$analyticsResultOperationEnum_maximum,
  _$analyticsResultOperationEnum_minimum,
]);

Serializer<AnalyticsResultOperationEnum>
    _$analyticsResultOperationEnumSerializer =
    new _$AnalyticsResultOperationEnumSerializer();

class _$AnalyticsResultOperationEnumSerializer
    implements PrimitiveSerializer<AnalyticsResultOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'average': 'average',
    'count': 'count',
    'maximum': 'maximum',
    'minimum': 'minimum',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'average': 'average',
    'count': 'count',
    'maximum': 'maximum',
    'minimum': 'minimum',
  };

  @override
  final Iterable<Type> types = const <Type>[AnalyticsResultOperationEnum];
  @override
  final String wireName = 'AnalyticsResultOperationEnum';

  @override
  Object serialize(Serializers serializers, AnalyticsResultOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AnalyticsResultOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AnalyticsResultOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AnalyticsResult extends AnalyticsResult {
  @override
  final AnalyticsResultOperationEnum? operation;
  @override
  final num? value;

  factory _$AnalyticsResult([void Function(AnalyticsResultBuilder)? updates]) =>
      (new AnalyticsResultBuilder()..update(updates)).build();

  _$AnalyticsResult._({this.operation, this.value}) : super._();

  @override
  AnalyticsResult rebuild(void Function(AnalyticsResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AnalyticsResultBuilder toBuilder() =>
      new AnalyticsResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnalyticsResult &&
        operation == other.operation &&
        value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, operation.hashCode), value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AnalyticsResult')
          ..add('operation', operation)
          ..add('value', value))
        .toString();
  }
}

class AnalyticsResultBuilder
    implements Builder<AnalyticsResult, AnalyticsResultBuilder> {
  _$AnalyticsResult? _$v;

  AnalyticsResultOperationEnum? _operation;
  AnalyticsResultOperationEnum? get operation => _$this._operation;
  set operation(AnalyticsResultOperationEnum? operation) =>
      _$this._operation = operation;

  num? _value;
  num? get value => _$this._value;
  set value(num? value) => _$this._value = value;

  AnalyticsResultBuilder() {
    AnalyticsResult._defaults(this);
  }

  AnalyticsResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AnalyticsResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AnalyticsResult;
  }

  @override
  void update(void Function(AnalyticsResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AnalyticsResult build() {
    final _$result =
        _$v ?? new _$AnalyticsResult._(operation: operation, value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
