import 'package:dr_purple/app/app_management/app_lifecycle_management/app_lifecycle_management.dart';
import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/media/data/remote/data_sources/background_uploader_remote_data_source.dart';
import 'package:dr_purple/app/app_management/media/data/repositories/background_uploader_repository.dart';
import 'package:dr_purple/app/app_management/media/domain/use_cases/background_uploader_use_case.dart';
import 'package:dr_purple/app/app_management/media/presentation/blocs/media_upload_bloc/media_upload_bloc.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/storage/app_preferences.dart';
import 'package:dr_purple/core/network/dio_factory.dart';
import 'package:dr_purple/core/network/network_info.dart';
import 'package:dr_purple/core/services/notification_service/notification_service.dart';
import 'package:dr_purple/features/appointments/data/remote/data_sources/book_appointment_remote_data_source.dart';
import 'package:dr_purple/features/appointments/data/remote/data_sources/get_all_appointments_remote_data_source.dart';
import 'package:dr_purple/features/appointments/data/remote/data_sources/get_appointment_remote_data_source.dart';
import 'package:dr_purple/features/appointments/data/repositories/book_appointment_repository.dart';
import 'package:dr_purple/features/appointments/data/repositories/get_all_appointments_repository.dart';
import 'package:dr_purple/features/appointments/data/repositories/get_appointment_repository.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/book_appointment_use_case.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/get_all_appointments_use_case.dart';
import 'package:dr_purple/features/appointments/domain/use_cases/get_appointment_use_case.dart';
import 'package:dr_purple/features/appointments/presentation/blocs/appointments_bloc/appointments_bloc.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/forget_password_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/login_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/logout_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/refresh_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/register_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/verify_account_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/remote/data_sources/verify_forget_password_remote_data_source.dart';
import 'package:dr_purple/features/auth/data/repositories/forget_password_repository.dart';
import 'package:dr_purple/features/auth/data/repositories/login_repository.dart';
import 'package:dr_purple/features/auth/data/repositories/logout_repository.dart';
import 'package:dr_purple/features/auth/data/repositories/refresh_repository.dart';
import 'package:dr_purple/features/auth/data/repositories/register_repository.dart';
import 'package:dr_purple/features/auth/data/repositories/verify_account_repository.dart';
import 'package:dr_purple/features/auth/data/repositories/verify_forget_password_repository.dart';
import 'package:dr_purple/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:dr_purple/features/auth/domain/use_cases/login_use_case.dart';
import 'package:dr_purple/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:dr_purple/features/auth/domain/use_cases/refresh_use_case.dart';
import 'package:dr_purple/features/auth/domain/use_cases/register_use_case.dart';
import 'package:dr_purple/features/auth/domain/use_cases/verify_account_use_case.dart';
import 'package:dr_purple/features/auth/domain/use_cases/verify_forget_password_use_case.dart';
import 'package:dr_purple/features/auth/presentation/bloc/country_code_cubit/country_code_cubit.dart';
import 'package:dr_purple/features/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:dr_purple/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:dr_purple/features/auth/presentation/bloc/logout_cubit/logout_cubit.dart';
import 'package:dr_purple/features/auth/presentation/bloc/refresh/refresh_access_token.dart';
import 'package:dr_purple/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:dr_purple/features/auth/presentation/bloc/verify_account_bloc/verify_account_bloc.dart';
import 'package:dr_purple/features/auth/presentation/bloc/verify_forget_password_bloc/verify_forget_password_bloc.dart';
import 'package:dr_purple/features/home/data/remote/data_sources/get_all_service_time_remote_data_source.dart';
import 'package:dr_purple/features/home/data/remote/data_sources/get_all_services_remote_data_source.dart';
import 'package:dr_purple/features/home/data/remote/data_sources/get_doctor_remote_data_source.dart';
import 'package:dr_purple/features/home/data/remote/data_sources/get_service_time_remote_data_source.dart';
import 'package:dr_purple/features/home/data/repositories/get_all_service_time_repository.dart';
import 'package:dr_purple/features/home/data/repositories/get_all_services_repository.dart';
import 'package:dr_purple/features/home/data/repositories/get_doctor_repository.dart';
import 'package:dr_purple/features/home/data/repositories/get_service_time_repository.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_all_service_time_use_case.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_all_services_use_case.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_doctor_use_case.dart';
import 'package:dr_purple/features/home/domain/use_cases/get_service_time_use_case.dart';
import 'package:dr_purple/features/home/presentation/blocs/book_appointment_bloc/book_appointment_bloc.dart';
import 'package:dr_purple/features/home/presentation/blocs/services_bloc/services_bloc.dart';
import 'package:dr_purple/features/notifications/data/remote/data_sources/update_fcm_token_remote_data_source.dart';
import 'package:dr_purple/features/notifications/data/repositories/update_fcm_token_repository.dart';
import 'package:dr_purple/features/notifications/domain/use_cases/update_fcm_token_use_case.dart';
import 'package:dr_purple/features/settings/data/data_sources/change_language_remote_data_source.dart';
import 'package:dr_purple/features/settings/data/data_sources/change_password_remote_data_source.dart';
import 'package:dr_purple/features/settings/data/data_sources/get_profile_remote_data_source.dart';
import 'package:dr_purple/features/settings/data/repositories/change_language_repository.dart';
import 'package:dr_purple/features/settings/data/repositories/change_password_repository.dart';
import 'package:dr_purple/features/settings/data/repositories/get_profile_repository.dart';
import 'package:dr_purple/features/settings/domain/use_cases/change_language_use_case.dart';
import 'package:dr_purple/features/settings/domain/use_cases/change_password_use_case.dart';
import 'package:dr_purple/features/settings/domain/use_cases/get_profile_use_case.dart';
import 'package:dr_purple/features/settings/presentation/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:dr_purple/features/settings/presentation/blocs/manage_language_cubit/manage_language_cubit.dart';
import 'package:dr_purple/features/settings/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:dr_purple/features/splash/presentation/blocs/splash_bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  ///register shared preferences as lazy singleton
  if (!GetIt.I.isRegistered<SharedPreferences>()) {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  ///register app preference as lazy singleton
  if (!GetIt.I.isRegistered<AppPreferences>()) {
    instance.registerLazySingleton<AppPreferences>(
        () => AppPreferences(instance<SharedPreferences>()));
  }

  ///register network info as lazy singleton
  if (!GetIt.I.isRegistered<NetworkInfoImpl>() &&
      !GetIt.I.isRegistered<NetworkInfo>()) {
    instance.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));
  }

  ///register dio factory as lazy singleton
  if (!GetIt.I.isRegistered<DioFactory>()) {
    instance.registerLazySingleton<DioFactory>(
        () => DioFactory(instance<AppPreferences>()));
  }

  ///register language manager as lazy singleton
  if (!GetIt.I.isRegistered<LanguageManager>()) {
    instance.registerLazySingleton<LanguageManager>(
        () => LanguageManager(instance<AppPreferences>()));
  }

  ///register notification service as lazy singleton
  if (!GetIt.I.isRegistered<NotificationService>()) {
    instance.registerLazySingleton<NotificationService>(
        () => NotificationService());
  }

  if (!GetIt.I.isRegistered<RefreshRemoteDataSource>()) {
    ///register refresh remote data source as factory
    instance
        .registerFactory<RefreshRemoteDataSource>(() => RefreshRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              null,
            ));
  }
  if (!GetIt.I.isRegistered<RefreshRepository>()) {
    ///register refresh repository as factory
    instance.registerFactory<RefreshRepository>(() => RefreshRepository(
        instance<RefreshRemoteDataSource>(), instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<RefreshUseCase>()) {
    ///register refresh use case as factory
    instance.registerFactory<RefreshUseCase>(
        () => RefreshUseCase(instance<RefreshRepository>()));
  }

  ///register refresh access token as lazy singleton
  if (!GetIt.I.isRegistered<RefreshAccessToken>()) {
    instance.registerLazySingleton<RefreshAccessToken>(() => RefreshAccessToken(
          instance<AppPreferences>(),
          instance<RefreshUseCase>(),
        ));
  }

  ///register Background Uploader Remote Data Source as lazy singleton
  if (!GetIt.I.isRegistered<BackgroundUploaderRemoteDataSource>()) {
    instance.registerLazySingleton<BackgroundUploaderRemoteDataSource>(
        () => BackgroundUploaderRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              null,
            ));
  }

  ///register Background Uploader Repository as lazy singleton
  if (!GetIt.I.isRegistered<BackgroundUploaderRepository>()) {
    instance.registerLazySingleton<BackgroundUploaderRepository>(
        () => BackgroundUploaderRepository(
              instance<BackgroundUploaderRemoteDataSource>(),
              instance<NetworkInfo>(),
            ));
  }

  ///register Background Uploader use case as lazy singleton
  if (!GetIt.I.isRegistered<BackgroundUploaderUseCase>()) {
    instance.registerLazySingleton<BackgroundUploaderUseCase>(() =>
        BackgroundUploaderUseCase(instance<BackgroundUploaderRepository>()));
  }

  ///register media upload bloc as lazy singleton
  if (!GetIt.I.isRegistered<MediaUploadBloc>()) {
    instance.registerLazySingleton<MediaUploadBloc>(
        () => MediaUploadBloc(instance<BackgroundUploaderUseCase>()));
  }

  ///register App Brought Foreground Management as lazy singleton
  if (!GetIt.I.isRegistered<AppLifecycleActions>()) {
    instance.registerLazySingleton<AppLifecycleActions>(
        () => AppLifecycleActions());
  }

  ///register Theme cubit as lazy singleton
  if (!GetIt.I.isRegistered<ThemeCubit>()) {
    instance.registerLazySingleton<ThemeCubit>(
        () => ThemeCubit(instance<AppPreferences>()));
  }

  if (!GetIt.I.isRegistered<GetProfileRemoteDataSource>()) {
    ///register Get Profile remote data source as factory
    instance.registerFactory<GetProfileRemoteDataSource>(
        () => GetProfileRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetProfileRepository>()) {
    ///register Get Profile repository as factory
    instance.registerFactory<GetProfileRepository>(() => GetProfileRepository(
        instance<GetProfileRemoteDataSource>(), instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    ///register Get Profile use case as factory
    instance.registerFactory<GetProfileUseCase>(
        () => GetProfileUseCase(instance<GetProfileRepository>()));
  }

  if (!GetIt.I.isRegistered<UpdateFCMTokenRemoteDataSource>()) {
    ///register Update FCM Token remote data source as factory
    instance.registerFactory<UpdateFCMTokenRemoteDataSource>(
        () => UpdateFCMTokenRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<UpdateFCMTokenRepository>()) {
    ///register Update FCM Token repository as factory
    instance.registerFactory<UpdateFCMTokenRepository>(() =>
        UpdateFCMTokenRepository(instance<UpdateFCMTokenRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<UpdateFCMTokenUseCase>()) {
    ///register Update FCM Token use case as factory
    instance.registerFactory<UpdateFCMTokenUseCase>(
        () => UpdateFCMTokenUseCase(instance<UpdateFCMTokenRepository>()));
  }

  ///register profile bloc as lazy singleton
  if (!GetIt.I.isRegistered<ProfileBloc>()) {
    instance.registerLazySingleton<ProfileBloc>(
        () => ProfileBloc(instance<GetProfileUseCase>()));
  }
}

void neededInBackgroundUploaderModule() {
  if (!GetIt.I.isRegistered<NotificationService>()) {
    ///register notification service as lazy singleton
    instance.registerLazySingleton<NotificationService>(
        () => NotificationService());
  }

  ///register media upload bloc as lazy singleton
  if (!GetIt.I.isRegistered<MediaUploadBloc>()) {
    instance.registerLazySingleton<MediaUploadBloc>(
        () => MediaUploadBloc(instance<BackgroundUploaderUseCase>()));
  }
}

void initSplashModule() {
  if (!GetIt.I.isRegistered<SplashBloc>()) {
    ///register Splash Bloc as factory
    instance.registerFactory<SplashBloc>(
        () => SplashBloc(instance<AppPreferences>()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterRemoteDataSource>()) {
    ///register register remote data source as factory
    instance.registerFactory<RegisterRemoteDataSource>(
        () => RegisterRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<RegisterRepository>()) {
    ///register register repository as factory
    instance.registerFactory<RegisterRepository>(() => RegisterRepository(
        instance<RegisterRemoteDataSource>(), instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    ///register register use case as factory
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(instance<RegisterRepository>()));
  }
  if (!GetIt.I.isRegistered<RegisterBloc>()) {
    ///register register bloc as factory
    instance.registerFactory<RegisterBloc>(() =>
        RegisterBloc(instance<RegisterUseCase>(), instance<AppPreferences>()));
  }
  if (!GetIt.I.isRegistered<CountryCodeCubit>()) {
    ///register Country Code Cubit as factory
    instance.registerFactory<CountryCodeCubit>(() => CountryCodeCubit());
  }
}

void initVerifyAccountModule() {
  if (!GetIt.I.isRegistered<VerifyAccountRemoteDataSource>()) {
    ///register Verify Account remote data source as factory
    instance.registerFactory<VerifyAccountRemoteDataSource>(
        () => VerifyAccountRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<VerifyAccountRepository>()) {
    ///register Verify Account repository as factory
    instance.registerFactory<VerifyAccountRepository>(() =>
        VerifyAccountRepository(instance<VerifyAccountRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<VerifyAccountUseCase>()) {
    ///register Verify Account use case as factory
    instance.registerFactory<VerifyAccountUseCase>(
        () => VerifyAccountUseCase(instance<VerifyAccountRepository>()));
  }
  if (!GetIt.I.isRegistered<VerifyAccountBloc>()) {
    ///register Verify Account bloc as factory
    instance.registerFactory<VerifyAccountBloc>(() => VerifyAccountBloc(
          instance<VerifyAccountUseCase>(),
          instance<AppPreferences>(),
          instance<UpdateFCMTokenUseCase>(),
        ));
  }
  if (!GetIt.I.isRegistered<CountryCodeCubit>()) {
    ///register Country Code Cubit as factory
    instance.registerFactory<CountryCodeCubit>(() => CountryCodeCubit());
  }
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginRemoteDataSource>()) {
    ///register Login remote data source as factory
    instance.registerFactory<LoginRemoteDataSource>(() => LoginRemoteDataSource(
          instance<DioFactory>().getDio(),
          instance<AppPreferences>(),
          instance<RefreshAccessToken>(),
        ));
  }
  if (!GetIt.I.isRegistered<LoginRepository>()) {
    ///register Login repository as factory
    instance.registerFactory<LoginRepository>(() => LoginRepository(
        instance<LoginRemoteDataSource>(), instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    ///register Login use case as factory
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<LoginRepository>()));
  }
  if (!GetIt.I.isRegistered<LoginBloc>()) {
    ///register Login bloc as factory
    instance.registerFactory<LoginBloc>(() => LoginBloc(
          instance<LoginUseCase>(),
          instance<AppPreferences>(),
          instance<UpdateFCMTokenUseCase>(),
        ));
  }
  if (!GetIt.I.isRegistered<CountryCodeCubit>()) {
    ///register Country Code Cubit as factory
    instance.registerFactory<CountryCodeCubit>(() => CountryCodeCubit());
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<GetAllServicesRemoteDataSource>()) {
    ///register Get All Services remote data source as factory
    instance.registerFactory<GetAllServicesRemoteDataSource>(
        () => GetAllServicesRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetAllServicesRepository>()) {
    ///register Get All Services repository as factory
    instance.registerFactory<GetAllServicesRepository>(() =>
        GetAllServicesRepository(instance<GetAllServicesRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<GetAllServicesUseCase>()) {
    ///register Get All Services use case as factory
    instance.registerFactory<GetAllServicesUseCase>(
        () => GetAllServicesUseCase(instance<GetAllServicesRepository>()));
  }
  if (!GetIt.I.isRegistered<ServicesBloc>()) {
    ///register Services bloc as factory
    instance.registerFactory<ServicesBloc>(
        () => ServicesBloc(instance<GetAllServicesUseCase>()));
  }
}

void initBookAppointmentModule() {
  if (!GetIt.I.isRegistered<GetServiceTimeRemoteDataSource>()) {
    ///register Get Service Time remote data source as factory
    instance.registerFactory<GetServiceTimeRemoteDataSource>(
        () => GetServiceTimeRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetServiceTimeRepository>()) {
    ///register Get Service Time repository as factory
    instance.registerFactory<GetServiceTimeRepository>(() =>
        GetServiceTimeRepository(instance<GetServiceTimeRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<GetServiceTimeUseCase>()) {
    ///register Get Service Time use case as factory
    instance.registerFactory<GetServiceTimeUseCase>(
        () => GetServiceTimeUseCase(instance<GetServiceTimeRepository>()));
  }
  if (!GetIt.I.isRegistered<GetDoctorRemoteDataSource>()) {
    ///register Get Doctor remote data source as factory
    instance.registerFactory<GetDoctorRemoteDataSource>(
        () => GetDoctorRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetDoctorRepository>()) {
    ///register Get Doctor repository as factory
    instance.registerFactory<GetDoctorRepository>(() => GetDoctorRepository(
        instance<GetDoctorRemoteDataSource>(), instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<GetDoctorUseCase>()) {
    ///register Get Doctor use case as factory
    instance.registerFactory<GetDoctorUseCase>(
        () => GetDoctorUseCase(instance<GetDoctorRepository>()));
  }
  if (!GetIt.I.isRegistered<BookAppointmentRemoteDataSource>()) {
    ///register Book Appointment remote data source as factory
    instance.registerFactory<BookAppointmentRemoteDataSource>(
        () => BookAppointmentRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<BookAppointmentRepository>()) {
    ///register Book Appointment repository as factory
    instance.registerFactory<BookAppointmentRepository>(() =>
        BookAppointmentRepository(instance<BookAppointmentRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<BookAppointmentUseCase>()) {
    ///register Book Appointment use case as factory
    instance.registerFactory<BookAppointmentUseCase>(
        () => BookAppointmentUseCase(instance<BookAppointmentRepository>()));
  }
  if (!GetIt.I.isRegistered<BookAppointmentBloc>()) {
    ///register Book Appointment Bloc as factory
    instance.registerFactory<BookAppointmentBloc>(() => BookAppointmentBloc(
          instance<GetServiceTimeUseCase>(),
          instance<GetDoctorUseCase>(),
          instance<BookAppointmentUseCase>(),
        ));
  }
}

void initAppointmentsModule() {
  if (!GetIt.I.isRegistered<GetAllAppointmentsRemoteDataSource>()) {
    ///register Get All Appointments remote data source as factory
    instance.registerFactory<GetAllAppointmentsRemoteDataSource>(
        () => GetAllAppointmentsRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetAllAppointmentsRepository>()) {
    ///register Get All Appointments repository as factory
    instance.registerFactory<GetAllAppointmentsRepository>(() =>
        GetAllAppointmentsRepository(
            instance<GetAllAppointmentsRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<GetAllAppointmentsUseCase>()) {
    ///register Get All Appointments use case as factory
    instance.registerFactory<GetAllAppointmentsUseCase>(() =>
        GetAllAppointmentsUseCase(instance<GetAllAppointmentsRepository>()));
  }
  if (!GetIt.I.isRegistered<GetAppointmentRemoteDataSource>()) {
    ///register Get Appointment remote data source as factory
    instance.registerFactory<GetAppointmentRemoteDataSource>(
        () => GetAppointmentRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetAppointmentRepository>()) {
    ///register Get Appointment repository as factory
    instance.registerFactory<GetAppointmentRepository>(() =>
        GetAppointmentRepository(instance<GetAppointmentRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<GetAppointmentUseCase>()) {
    ///register Get Appointment use case as factory
    instance.registerFactory<GetAppointmentUseCase>(
        () => GetAppointmentUseCase(instance<GetAppointmentRepository>()));
  }
  if (!GetIt.I.isRegistered<GetServiceTimeRemoteDataSource>()) {
    ///register Get Service Time remote data source as factory
    instance.registerFactory<GetServiceTimeRemoteDataSource>(
        () => GetServiceTimeRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetServiceTimeRepository>()) {
    ///register Get Service Time repository as factory
    instance.registerFactory<GetServiceTimeRepository>(() =>
        GetServiceTimeRepository(instance<GetServiceTimeRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<GetServiceTimeUseCase>()) {
    ///register Get Service Time use case as factory
    instance.registerFactory<GetServiceTimeUseCase>(
        () => GetServiceTimeUseCase(instance<GetServiceTimeRepository>()));
  }
  if (!GetIt.I.isRegistered<GetAllServiceTimeRemoteDataSource>()) {
    ///register Get Service All Time remote data source as factory
    instance.registerFactory<GetAllServiceTimeRemoteDataSource>(
        () => GetAllServiceTimeRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<GetAllServiceTimeRepository>()) {
    ///register Get All Service Time repository as factory
    instance.registerFactory<GetAllServiceTimeRepository>(() =>
        GetAllServiceTimeRepository(
            instance<GetAllServiceTimeRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<GetAllServiceTimeUseCase>()) {
    ///register Get All Service Time use case as factory
    instance.registerFactory<GetAllServiceTimeUseCase>(() =>
        GetAllServiceTimeUseCase(instance<GetAllServiceTimeRepository>()));
  }
  if (!GetIt.I.isRegistered<AppointmentsBloc>()) {
    ///register Appointments Bloc as factory
    instance.registerFactory<AppointmentsBloc>(() => AppointmentsBloc(
          instance<GetAllAppointmentsUseCase>(),
          instance<GetAppointmentUseCase>(),
          instance<GetServiceTimeUseCase>(),
          instance<GetAllServiceTimeUseCase>(),
        ));
  }
}

void initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordRemoteDataSource>()) {
    ///register Forget Password Remote Data Source as factory
    instance.registerFactory<ForgetPasswordRemoteDataSource>(
        () => ForgetPasswordRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<ForgetPasswordRepository>()) {
    ///register Forget Password repository as factory
    instance.registerFactory<ForgetPasswordRepository>(() =>
        ForgetPasswordRepository(instance<ForgetPasswordRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    ///register Forget Password use case as factory
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance<ForgetPasswordRepository>()));
  }
  if (!GetIt.I.isRegistered<VerifyForgetPasswordRemoteDataSource>()) {
    ///register Verify Forget Password Remote Data Source as factory
    instance.registerFactory<VerifyForgetPasswordRemoteDataSource>(
        () => VerifyForgetPasswordRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<VerifyForgetPasswordRepository>()) {
    ///register Verify Forget Password repository as factory
    instance.registerFactory<VerifyForgetPasswordRepository>(() =>
        VerifyForgetPasswordRepository(
            instance<VerifyForgetPasswordRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<VerifyForgetPasswordUseCase>()) {
    ///register Verify Forget Password use case as factory
    instance.registerFactory<VerifyForgetPasswordUseCase>(() =>
        VerifyForgetPasswordUseCase(
            instance<VerifyForgetPasswordRepository>()));
  }
  if (!GetIt.I.isRegistered<ForgetPasswordBloc>()) {
    ///register Forget Password Bloc as factory
    instance.registerFactory<ForgetPasswordBloc>(() => ForgetPasswordBloc(
          instance<ForgetPasswordUseCase>(),
        ));
  }
  if (!GetIt.I.isRegistered<VerifyForgetPasswordBloc>()) {
    ///register Verify Forget Password Bloc as factory
    instance.registerFactory<VerifyForgetPasswordBloc>(
        () => VerifyForgetPasswordBloc(
              instance<VerifyForgetPasswordUseCase>(),
            ));
  }
  if (!GetIt.I.isRegistered<CountryCodeCubit>()) {
    ///register Country Code Cubit as factory
    instance.registerFactory<CountryCodeCubit>(() => CountryCodeCubit());
  }
}

void initSettingsModule() {
  if (!GetIt.I.isRegistered<LogoutRemoteDataSource>()) {
    ///register Logout remote data source as factory
    instance
        .registerFactory<LogoutRemoteDataSource>(() => LogoutRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<LogoutRepository>()) {
    ///register Logout repository as factory
    instance.registerFactory<LogoutRepository>(() => LogoutRepository(
        instance<LogoutRemoteDataSource>(), instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<LogoutUseCase>()) {
    ///register Logout use case as factory
    instance.registerFactory<LogoutUseCase>(
        () => LogoutUseCase(instance<LogoutRepository>()));
  }
  if (!GetIt.I.isRegistered<LogoutCubit>()) {
    ///register logout cubit as factory
    instance.registerFactory<LogoutCubit>(() => LogoutCubit(
          instance<LogoutUseCase>(),
          instance<AppPreferences>(),
        ));
  }
}

void initLanguageModule() {
  if (!GetIt.I.isRegistered<ChangeLanguageRemoteDataSource>()) {
    ///register Change Language remote data source as factory
    instance.registerFactory<ChangeLanguageRemoteDataSource>(
        () => ChangeLanguageRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<ChangeLanguageRepository>()) {
    ///register Change Language repository as factory
    instance.registerFactory<ChangeLanguageRepository>(() =>
        ChangeLanguageRepository(instance<ChangeLanguageRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<ChangeLanguageUseCase>()) {
    ///register Change Language use case as factory
    instance.registerFactory<ChangeLanguageUseCase>(
        () => ChangeLanguageUseCase(instance<ChangeLanguageRepository>()));
  }
  if (!GetIt.I.isRegistered<ManageLanguageCubit>()) {
    ///register manage language cubit as factory
    instance.registerFactory<ManageLanguageCubit>(() => ManageLanguageCubit(
        instance<LanguageManager>(), instance<ChangeLanguageUseCase>()));
  }
}

void initChangePasswordModule() {
  if (!GetIt.I.isRegistered<ChangePasswordRemoteDataSource>()) {
    ///register Change Password remote data source as factory
    instance.registerFactory<ChangePasswordRemoteDataSource>(
        () => ChangePasswordRemoteDataSource(
              instance<DioFactory>().getDio(),
              instance<AppPreferences>(),
              instance<RefreshAccessToken>(),
            ));
  }
  if (!GetIt.I.isRegistered<ChangePasswordRepository>()) {
    ///register Change Password repository as factory
    instance.registerFactory<ChangePasswordRepository>(() =>
        ChangePasswordRepository(instance<ChangePasswordRemoteDataSource>(),
            instance<NetworkInfo>()));
  }
  if (!GetIt.I.isRegistered<ChangePasswordUseCase>()) {
    ///register Change Password use case as factory
    instance.registerFactory<ChangePasswordUseCase>(
        () => ChangePasswordUseCase(instance<ChangePasswordRepository>()));
  }
  if (!GetIt.I.isRegistered<ChangePasswordBloc>()) {
    ///register manage language cubit as factory
    instance.registerFactory<ChangePasswordBloc>(
        () => ChangePasswordBloc(instance<ChangePasswordUseCase>()));
  }
}
