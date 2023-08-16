import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/params/pharmacy/pharmacy_params.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/responses/pharmacy_api_response/pharmacy_api_response.dart';
import 'package:dr_purple/features/pharmacy/domain/entities/pharmacy_entity.dart';
import 'package:dr_purple/features/pharmacy/domain/use_cases/pharmacy_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pharmacy_event.dart';

part 'pharmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  final PharmacyUseCase _pharmacyUseCase;

  final List<MaterialsModel> _materials = List.empty(growable: true);

  List<MaterialsModel> get materials => _materials;

  PharmacyBloc(this._pharmacyUseCase) : super(PharmacyInitial()) {
    on<GetPharmacyEvent>((event, emit) async {
      emit(PharmacyLoading(loadingType: PharmacyBlocStateType.getPharmacy));
      String errorMessage = Constants.empty;
      PharmacyEntity? getPharmacyResponse;
      var res = await _pharmacyUseCase.call(PharmacyParams(
          body: PharmacyParamsBody(
        pageSize: 20,
        pageNo: 1,
        skip: 1,
        orderBy: null,
        searchBy: null,
        isAscending: false,
      )));
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        getPharmacyResponse = r;
        return false;
      });
      if (isError) {
        emit(PharmacyError(
          errorType: PharmacyBlocStateType.getPharmacy,
          errorMessage: errorMessage,
        ));
      } else {
        if (getPharmacyResponse?.materials != null &&
            getPharmacyResponse?.materials.isNotEmpty == true) {
          for (var material in getPharmacyResponse!.materials) {
            _materials.add(material);
          }
        }
        emit(PharmacyLoaded(loadedType: PharmacyBlocStateType.getPharmacy));
      }
    });
  }
}
