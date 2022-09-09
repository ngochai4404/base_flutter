import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';
@JsonSerializable()
class ErrorResponse{
  String message;
  ErrorResponse({required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  /// Connect the generated [_$ErrorResponseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}