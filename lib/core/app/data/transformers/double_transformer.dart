import 'package:json_annotation/json_annotation.dart';

class DoubleTransformer implements JsonConverter<double, String> {
  const DoubleTransformer();

  @override
  double fromJson(String json) => double.parse(json);

  @override
  String toJson(double object) => object.toStringAsFixed(2);
}
