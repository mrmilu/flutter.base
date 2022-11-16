import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_base/core/app/domain/models/photo.dart';

part 'photo_data_model.g.dart';

@JsonSerializable(createToJson: false)
class PhotoDataModel {
  final int id;
  final String image;
  @JsonKey(name: "image_type")
  final String imageType;

  PhotoDataModel({
    required this.id,
    required this.image,
    required this.imageType,
  });

  factory PhotoDataModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoDataModelFromJson(json);

  Photo toDomain() {
    return Photo(
      id: id,
      url: image,
      type: ImageType.values.byName(imageType),
    );
  }
}
