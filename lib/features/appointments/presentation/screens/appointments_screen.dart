import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/design/dr_purple_appointment_list_item_design.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/appointments/presentation/blocs/appointments_bloc/appointments_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late final AppointmentsBloc _appointmentsBloc;

  _bind() => _appointmentsBloc = instance<AppointmentsBloc>()
    ..add(GetMyAppointments());

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _appointmentsBloc.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _appointmentsBloc,
        child: BlocListener<AppointmentsBloc, AppointmentsState>(
          listener: (context, state) async {
            if (state is AppointmentsError) {
              await Utils.showToast(state.errorMessage);
            }
          },
          child: _screenContent(),
        ),
      );

  Widget _screenContent() => SafeArea(
        child: DrPurpleScaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [..._appointmentAppBar(), _appointmentMainView()],
          ),
        ),
      );

  Widget _appointmentMainView() => Container(
        width: context.width(),
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: radiusOnly(),
          backgroundColor: instance<ThemeCubit>().isThemeDark
              ? ColorManager.black
              : ColorManager.white,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p2.w),
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
            buildWhen: (prev, state) =>
                (state is AppointmentsError &&
                    state.errorType ==
                        AppointmentsBlocStateType.getMyAppointments) ||
                (state is AppointmentsLoaded &&
                    state.loadedType ==
                        AppointmentsBlocStateType.getMyAppointments) ||
                (state is AppointmentsLoading &&
                    state.loadingType ==
                        AppointmentsBlocStateType.getMyAppointments),
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.s2.h),
                if (state is AppointmentsLoading &&
                    state.loadingType ==
                        AppointmentsBlocStateType.getMyAppointments) ...[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 75),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: SizedBox(
                          width: AppSize.s90.w,
                          height: 260.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width: AppSize.s90.w,
                                  height: 150.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: AppPadding.p8),
                                  padding: const EdgeInsets.all(AppPadding.p5),
                                  decoration: boxDecorationWithRoundedCorners(
                                    borderRadius: radius(AppSize.s32),
                                    border: Border.all(
                                      color: ColorManager.primary,
                                    ),
                                    backgroundColor: ColorManager.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).cornerRadiusWithClipRRectOnly(
                        topLeft: AppSize.s8.toInt(),
                        topRight: AppSize.s8.toInt(),
                      );
                    },
                  ),
                ] else if (state is AppointmentsLoaded &&
                    state.loadedType ==
                        AppointmentsBlocStateType.getMyAppointments) ...[
                  if (_appointmentsBloc.appointments.isNotEmpty) ...[
                    Column(
                      children: _appointmentsBloc.appointments
                          .map(
                            (e) => DrPurpleAppointmentListItemDesign(
                              appointmentData: e,
                              appointmentsBloc: _appointmentsBloc,
                            ),
                          )
                          .toList(),
                    ),
                  ] else ...[
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: AppPadding.p8),
                      padding: const EdgeInsets.all(AppPadding.p12),
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: radius(AppSize.s12),
                        border: Border.all(color: ColorManager.primary),
                        backgroundColor: context.cardColor,
                      ),
                      child: Text(
                        AppStrings.appointmentsEmpty.tr(),
                        style: getBoldTextStyle(
                          color: ColorManager.textPrimaryColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ),
                  ],
                ] else if (state is AppointmentsError &&
                    state.errorType ==
                        AppointmentsBlocStateType.getMyAppointments) ...[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                    padding: const EdgeInsets.all(AppPadding.p12),
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: radius(AppSize.s12),
                      border: Border.all(color: ColorManager.primary),
                      backgroundColor: context.cardColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.unKnown.tr(),
                          style: getBoldTextStyle(
                            color: ColorManager.textPrimaryColor,
                            fontSize: FontSize.s16,
                          ),
                        ),
                        SizedBox(height: AppSize.s2.h),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.refresh,
                            color: ColorManager.primary,
                            size: AppSize.s40,
                          ),
                          alignment: Alignment.center,
                          onPressed: () =>
                              _appointmentsBloc.add(GetMyAppointments()),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ).expand();

  List<Widget> _appointmentAppBar() => [
        Text(
          AppStrings.appointmentsNav.tr(),
          style: getBoldTextStyle(
            fontSize: FontSize.s20,
            color: ColorManager.white,
          ),
        ).paddingAll(AppPadding.p18.sp),
        SizedBox(width: AppSize.s2.w),
      ];
}
