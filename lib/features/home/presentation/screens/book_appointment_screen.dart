import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/app/dummy_test_data/dummy_test_data.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/features/home/presentation/blocs/book_appointment_bloc/book_appointment_bloc.dart';
import 'package:dr_purple/features/home/presentation/blocs/services_bloc/services_bloc.dart';
import 'package:dr_purple/features/home/presentation/screens/widgets/booked_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  late final ServicesBloc _servicesBloc;
  late final BookAppointmentBloc _bookAppointmentBloc;

  int _currentWidget = 0;
  late final List<BookAppointmentData> _data;

  _bind() {
    _servicesBloc = BlocProvider.of<ServicesBloc>(context);
    _bookAppointmentBloc = instance<BookAppointmentBloc>();
    _data =
        bookAppointmentDataList(_servicesBloc.services, _bookAppointmentBloc);
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _disposeBloc() async => await _bookAppointmentBloc.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String titleNumber = _data[_currentWidget].id;
    String titleText = _data[_currentWidget].title.tr();
    double progress = _data[_currentWidget].progress;
    return WillPopScope(
      onWillPop: () async {
        if (_currentWidget != 0) {
          setState(() {
            _currentWidget--;
          });
          return false;
        }
        return true;
      },
      child: BlocProvider(
        create: (context) => _bookAppointmentBloc,
        child: BlocListener<BookAppointmentBloc, BookAppointmentState>(
          listener: (context, state) async {
            if (state is BookAppointmentLoading &&
                state.loadingType == BookAppointmentBlocStateType.book) {
              LoadingOverlay.of(context).show();
            } else if (state is BookAppointmentLoaded &&
                state.loadedType == BookAppointmentBlocStateType.book) {
              LoadingOverlay.of(context).hide();
              GoRouter.of(context).pop();
              _showDialog(context);
            } else if (state is BookAppointmentError &&
                state.errorType == BookAppointmentBlocStateType.book) {
              LoadingOverlay.of(context).hide();
              await Utils.showToast(state.errorMessage);
            }
          },
          child: _screenContent(context, titleNumber, titleText, progress),
        ),
      ),
    );
  }

  Widget _screenContent(BuildContext context, String titleNumber,
          String titleText, double progress) =>
      Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: AppSize.s32),
                  backgroundColor: instance<ThemeCubit>().isThemeDark
                      ? ColorManager.black
                      : ColorManager.white,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: AppSize.s1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: instance<ThemeCubit>().isThemeDark
                              ? ColorManager.white
                              : ColorManager.black,
                          size: AppSize.s22,
                        ).onTap(
                          () {
                            _currentWidget == 0
                                ? GoRouter.of(context).pop()
                                : setState(() {
                                    _currentWidget--;
                                  });
                          },
                        ).expand(flex: AppSize.s1.toInt()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.bookStep.tr(args: [titleNumber]),
                              textAlign: TextAlign.center,
                              style: getBoldTextStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s16,
                              ),
                            ),
                            Text(
                              titleText,
                              textAlign: TextAlign.center,
                              style: getBoldTextStyle(
                                color: Colors.grey,
                                fontSize: FontSize.s16,
                              ),
                            ),
                          ],
                        ).expand(flex: AppSize.s8.toInt()),
                        SizedBox(
                          width: AppSize.s2.w,
                        ).expand(flex: AppSize.s1.toInt()),
                      ],
                    ).paddingAll(AppPadding.p18.sp),
                    SizedBox(height: AppSize.s1.h),
                    LinearProgressIndicator(
                      minHeight: 2.0,
                      backgroundColor: ColorManager.lightGrey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(ColorManager.primary),
                      value: progress,
                    ),
                    SizedBox(height: AppSize.s1.h),
                    _data[_currentWidget].widget.expand(),
                  ],
                ),
              ),
              BlocBuilder<BookAppointmentBloc, BookAppointmentState>(
                builder: (context, state) => AppButton(
                  height: AppSize.s50,
                  width: context.width(),
                  color: ColorManager.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          _currentWidget == 2
                              ? AppStrings.book.tr()
                              : AppStrings.continueAction.tr(),
                          style: boldTextStyle(color: white)),
                      if (_currentWidget != 2) ...[
                        SizedBox(width: AppSize.s2.w),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: whiteColor,
                          size: AppSize.s12,
                        ),
                      ]
                    ],
                  ),
                  onTap: () async {
                    if (_currentWidget == 0) {
                      if (_bookAppointmentBloc.selectedServiceId != -1) {
                        _bookAppointmentBloc.add(GetServiceTimes());
                        setState(() {
                          _currentWidget++;
                        });
                      } else {
                        await Utils.showToast(
                            AppStrings.selectServiceError.tr());
                      }
                    } else if (_currentWidget == 1) {
                      if (_bookAppointmentBloc.selectedServiceTimeId != -1) {
                        setState(() {
                          _currentWidget++;
                        });
                      } else {
                        await Utils.showToast(
                            AppStrings.appointmentTimeError.tr());
                      }
                    } else {
                      _bookAppointmentBloc.add(BookAppointment());
                    }
                  },
                ),
              ).paddingOnly(
                right: AppPadding.p4.w,
                left: AppPadding.p4.w,
                bottom: AppPadding.p2.h,
              ),
            ],
          ),
        ),
      );

  Future<void> _showDialog(BuildContext context) async => showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final service = _servicesBloc.services.firstWhere(
            (element) => element.id == _bookAppointmentBloc.selectedServiceId,
          );
          final serviceTimeIndex =
              _bookAppointmentBloc.serviceTimeResponseFiltered.indexWhere(
            (element) =>
                element.id == _bookAppointmentBloc.selectedServiceTimeId,
          );
          final serviceTime = _bookAppointmentBloc
              .serviceTimeResponseFiltered[serviceTimeIndex];
          return BookedDialog(
            title: "${service.name} ${AppStrings.appointment.tr()}",
            date: serviceTime.date!,
            time: serviceTime.startTime!,
          );
        },
      );
}
