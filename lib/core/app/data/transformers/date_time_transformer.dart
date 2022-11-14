import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_base/common/extensions/datetime.dart';

class DateTransformer implements JsonConverter<DateTime, String> {
  const DateTransformer();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.format("yyyy-MM-dd");
}