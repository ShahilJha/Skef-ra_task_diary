import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skefra_task_diary/domain/auth/auth_value_failures.dart';

part 'value_failures.freezed.dart';

// @freezed
// class ValueFailure<T> with _$ValueFailure<T> {
//   const factory ValueFailure.invalidEmail({required String failedValue}) =
//       InvalidEmail<T>;

//   const factory ValueFailure.shortPassword({required String failedValue}) =
//       ShortPassword<T>;
// }

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.auth(AuthValueFailure<T> authFailure) = _Auth<T>;
}
