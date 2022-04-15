import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

///Custom class to circumvent the problem faces by _FieldValue_ not working with
///_json_serializable_ package after null-safety migration
class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  /*
    For the usage of this converter we require it be used as an _annotation_
    And _annotation_ in dart have to be constant, so the constructor should be constant

    We can annotate and use this in classes as follows to generate a json-serializable
    declare the variable as such in the class constructor
      ```
        @ServerTimestampConverter() required FieldValue serverTimeStamp,
      ``` 
  */
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}
