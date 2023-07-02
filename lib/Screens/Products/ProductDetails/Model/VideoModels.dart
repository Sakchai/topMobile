import 'package:nopsuite/Models/CustomProperties.dart';

class VideoModel {
  String videoUrl;
  String allow;
  int width;
  int height;
  CustomProperties customProperties;

  VideoModel({
    required this.videoUrl,
    required this.allow,
    required this.width,
    required this.height,
    required this.customProperties,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    videoUrl: json["VideoUrl"],
    allow: json["Allow"],
    width: json["Width"],
    height: json["Height"],
    customProperties: CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "VideoUrl": videoUrl,
    "Allow": allow,
    "Width": width,
    "Height": height,
    "CustomProperties": customProperties.toJson(),
  };
}