import 'package:flutter_base/src/shared/presentation/utils/extensions/datetime_extension.dart';
import 'package:json_annotation/json_annotation.dart';

class DateTransformer implements JsonConverter<DateTime, String> {
  const DateTransformer();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.format('yyyy-MM-dd');
}
