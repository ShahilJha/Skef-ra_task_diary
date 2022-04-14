import 'package:dartz/dartz.dart';

import '../../core/value_failures/value_failures.dart';
import '../../core/value_objects/value_object.dart';
import '../notes_value_validators.dart';

class NoteBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const maxLength = 1000;

  const NoteBody._(this.value);

  /*
    if the value of the first validator is a _Failure_ then the _flatMap_ functions are skipped entirely
    ```
      NoteBody._(
        validateMaxStringLength(input, maxLength)
          .flatMap((inputValue) => validateStringNotEmpty(inputValue))
      );
    ```

    Or to simplify we can also write the above code as
    ```
      NoteBody._(validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty));
    ```
    Here, _validateStringNotEmpty()_ has same signature so we can reduce the written code 

    ##This is calle the _Right Bias of Either_

    _Option_ is also right biased
      as if the option is ```some()``` it is gonna continue _flatMapping_ and 
      if the _option_ in ```none()```  then it will not continue _flatMapping_

  */

  factory NoteBody(String input) => NoteBody._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty),
      );
}
