import 'package:dr_purple/core/features/data/remote_data_source/remote_data_source.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/params/pharmacy/pharmacy_params.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/responses/pharmacy_api_response/pharmacy_api_response.dart';

abstract class IPharmacyRemoteDataSource extends RemoteDataSource {
  IPharmacyRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  Future<PharmacyAPIResponse> getPharmacy(PharmacyParams pharmacyParams);
}

class PharmacyRemoteDataSource extends IPharmacyRemoteDataSource {
  PharmacyRemoteDataSource(
    super.dio,
    super._appPreferences,
    super._refreshAccessToken,
  );

  @override
  Future<PharmacyAPIResponse> getPharmacy(PharmacyParams pharmacyParams) async {
    var res = await pharmacyParams.requestType
        .getHTTPRequestType(this, pharmacyParams);
    return Future.value(PharmacyAPIResponse.fromJson(res));
  }
}
