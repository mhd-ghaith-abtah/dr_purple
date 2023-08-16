import 'package:dr_purple/core/features/data/remote_data_source/models/responses/base_response_model.dart';
import 'package:dr_purple/features/pharmacy/domain/entities/pharmacy_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pharmacy_api_response.g.dart';

@JsonSerializable()
class PharmacyAPIResponse extends BaseResponseModel {
  @JsonKey(name: "data")
  PharmacyAPIResult result;

  PharmacyAPIResponse({required this.result});

  factory PharmacyAPIResponse.fromJson(Map<String, dynamic> json) =>
      _$PharmacyAPIResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PharmacyAPIResponseToJson(this);

  @override
  PharmacyEntity toEntity() =>
      PharmacyEntity(materials: result.pharmacies.first.materials);
}

@JsonSerializable()
class PharmacyAPIResult {
  @JsonKey(name: "results")
  final List<PharmacyModel> pharmacies;

  PharmacyAPIResult({required this.pharmacies});

  factory PharmacyAPIResult.fromJson(Map<String, dynamic> json) =>
      _$PharmacyAPIResultFromJson(json);

  Map<String, dynamic> toJson() => _$PharmacyAPIResultToJson(this);
}

@JsonSerializable()
class PharmacyModel {
  @JsonKey(name: "materials")
  final List<MaterialsModel> materials;

  PharmacyModel({required this.materials});

  factory PharmacyModel.fromJson(Map<String, dynamic> json) =>
      _$PharmacyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PharmacyModelToJson(this);
}

@JsonSerializable()
class MaterialsModel {
  @JsonKey(name: "material")
  final MaterialModel material;

  MaterialsModel({
    required this.material,
  });

  factory MaterialsModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialsModelToJson(this);
}

@JsonSerializable()
class MaterialModel {
  @JsonKey(name: "salePrice")
  final int salePrice;
  @JsonKey(name: "name")
  final String name;

  MaterialModel({
    required this.salePrice,
    required this.name,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialModelToJson(this);
}
