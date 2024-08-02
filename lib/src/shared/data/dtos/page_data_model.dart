import 'package:json_annotation/json_annotation.dart';

part 'page_data_model.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class PageDataModel<T> {
  final int count;
  final String? next;
  final String? previous;
  @JsonKey(defaultValue: [])
  final List<T> results;

  const PageDataModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PageDataModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PageDataModelFromJson<T>(json, fromJsonT);
}
