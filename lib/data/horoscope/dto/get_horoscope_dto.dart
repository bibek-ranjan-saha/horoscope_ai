// To parse this JSON data, do
//
//     final getHoroScopeDto = getHoroScopeDtoFromJson(jsonString);

import 'dart:convert';

import 'package:horoscope_ai/domain/horoscope/model/horoscope_model.dart';

GetHoroScopeDto getHoroScopeDtoFromJson(String str) =>
    GetHoroScopeDto.fromJson(json.decode(str));

String getHoroScopeDtoToJson(GetHoroScopeDto data) =>
    json.encode(data.toJson());

class GetHoroScopeDto {
  final String sign;
  final String period;
  final String language;
  final List<String> general;

  GetHoroScopeDto({
    required this.sign,
    required this.period,
    required this.language,
    required this.general,
  });

  factory GetHoroScopeDto.fromJson(Map<String, dynamic> json) =>
      GetHoroScopeDto(
        sign: json["sign"],
        period: json["period"],
        language: json["language"],
        general: List<String>.from(json["general"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sign": sign,
        "period": period,
        "language": language,
        "general": List<dynamic>.from(general.map((x) => x)),
      };

  static HoroScopeModel toModel(GetHoroScopeDto dto) {
    return HoroScopeModel(dto.sign, dto.period, dto.language, dto.general);
  }
}
