import 'package:freezed_annotation/freezed_annotation.dart';

part 'core_value_failures.freezed.dart';

@freezed
class CoreValueFaliue<T> with _$CoreValueFaliue<T> {
  const factory CoreValueFaliue.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;
  const factory CoreValueFaliue.empty({
    required T failedValue,
  }) = Empty<T>;
  const factory CoreValueFaliue.multiLine({
    required T failedValue,
  }) = MultiLine<T>;
}
