import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/home/data/remote/models/params/get_all_services/get_all_services_params.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';
import 'package:dr_purple/features/home/domain/entities/get_all_services_entity.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_all_services_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'services_event.dart';

part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final GetAllServicesUseCase _getAllServicesUseCase;

  final List<ServiceModel> _services = List.empty(growable: true);

  List<ServiceModel> get services => _services;

  ServicesBloc(this._getAllServicesUseCase) : super(ServicesInitial()) {
    on<GetAllServices>((event, emit) async {
      emit(ServicesLoading(loadingType: ServicesBlocStateType.services));
      String errorMessage = Constants.empty;
      GetAllServicesEntity? servicesResponse;
      var res = await _getAllServicesUseCase.call(
        GetAllServicesParams(
          body: GetAllServicesParamsBody(
            pageSize: 10,
            pageNo: 1,
            skip: 1,
            orderBy: null,
            searchBy: null,
            isAscending: false,
          ),
        ),
      );
      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        servicesResponse = r;
        return false;
      });

      ///if there is an error occurred during API Request, emit error state
      if (isError) {
        emit(ServicesError(
            errorMessage: errorMessage,
            errorType: ServicesBlocStateType.services));
      } else {
        if (servicesResponse?.services != null) {
          _services.clear();
          for (var service in servicesResponse!.services!) {
            _services.add(service);
          }
        }
        emit(ServicesLoaded(loadedType: ServicesBlocStateType.services));
      }
    });
  }
}
