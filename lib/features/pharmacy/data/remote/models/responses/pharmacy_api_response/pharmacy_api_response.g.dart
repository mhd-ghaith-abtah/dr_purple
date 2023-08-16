// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PharmacyAPIResponse _$PharmacyAPIResponseFromJson(Map<String, dynamic> json) =>
    PharmacyAPIResponse(
      result: PharmacyAPIResult.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..succsess = json['succsess'] as bool?
      ..messageId = json['messageId'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PharmacyAPIResponseToJson(
        PharmacyAPIResponse instance) =>
    <String, dynamic>{
      'succsess': instance.succsess,
      'messageId': instance.messageId,
      'message': instance.message,
      'data': instance.result,
    };

PharmacyAPIResult _$PharmacyAPIResultFromJson(Map<String, dynamic> json) =>
    PharmacyAPIResult(
      pharmacies: (json['results'] as List<dynamic>)
          .map((e) => PharmacyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PharmacyAPIResultToJson(PharmacyAPIResult instance) =>
    <String, dynamic>{
      'results': instance.pharmacies,
    };

PharmacyModel _$PharmacyModelFromJson(Map<String, dynamic> json) =>
    PharmacyModel(
      materials: (json['materials'] as List<dynamic>)
          .map((e) => MaterialsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PharmacyModelToJson(PharmacyModel instance) =>
    <String, dynamic>{
      'materials': instance.materials,
    };

MaterialsModel _$MaterialsModelFromJson(Map<String, dynamic> json) =>
    MaterialsModel(
      material:
          MaterialModel.fromJson(json['material'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MaterialsModelToJson(MaterialsModel instance) =>
    <String, dynamic>{
      'material': instance.material,
    };

MaterialModel _$MaterialModelFromJson(Map<String, dynamic> json) =>
    MaterialModel(
      salePrice: json['salePrice'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$MaterialModelToJson(MaterialModel instance) =>
    <String, dynamic>{
      'salePrice': instance.salePrice,
      'name': instance.name,
    };
