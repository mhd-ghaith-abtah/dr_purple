import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_configurations/scroll_behavior.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_back_button.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_verification_code_text_field.dart';
import 'package:dr_purple/features/auth/presentation/bloc/verify_account_bloc/verify_account_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:responsive_sizer/responsive_sizer.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({Key? key}) : super(key: key);

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  late final VerifyAccountBloc _verifyAccountBloc;

  _bind() => _verifyAccountBloc = instance<VerifyAccountBloc>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _verifyAccountBloc.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _verifyAccountBloc,
        child: BlocListener<VerifyAccountBloc, VerifyAccountState>(
          listener: (context, state) async {
            if (state is VerifyAccountLoading) {
              if (state.loadingType == VerifyAccountBlocStateType.server) {
                LoadingOverlay.of(context).show();
              }
            } else if (state is VerifyAccountLoaded) {
              if (state.loadedType == VerifyAccountBlocStateType.server) {
                LoadingOverlay.of(context).hide();
                GoRouter.of(context)
                  ..pop()
                  ..go(Routes.homeRoute);
              }
            } else if (state is VerifyAccountError) {
              if (state.errorType == VerifyAccountBlocStateType.server) {
                LoadingOverlay.of(context).hide();
              }
              await Utils.showToast(state.errorMessage);
            }
          },
          child: DrPurpleScaffold(
            backgroundColor: instance<ThemeCubit>().isThemeDark
                ? ColorManager.appBackgroundColorDark
                : ColorManager.white,
            body: _screenContent(context),
          ),
        ),
      );

  Widget _screenContent(BuildContext context) => Stack(
        children: [
          _verifyAccountDataView(context),
          _backButton(),
        ],
      );

  Widget _verifyAccountDataView(BuildContext context) => Container(
        padding: EdgeInsets.only(top: AppPadding.p3.h),
        height: context.height(),
        decoration: nb.boxDecorationWithRoundedCorners(
            backgroundColor: context.cardColor),
        child: ScrollConfiguration(
          behavior: StretchScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: AppSize.s7.h),
                _verifyAccountImage(),
                ..._verifyAccountTitle(),
                DrPurpleVerificationCodeTextField(
                  onChange: (code) =>
                      _verifyAccountBloc.add(SetVerificationCode(code: code)),
                  itemSize: AppSize.s30.sp,
                  length: 6,
                ),
                SizedBox(height: AppSize.s3.h),
                _confirmVerifyAccountCode(),
              ],
            ).paddingAll(AppPadding.p18.sp),
          ),
        ),
      );

  Widget _verifyAccountImage() => Container(
        margin: EdgeInsets.only(top: AppPadding.p2.h),
        padding: EdgeInsets.all(AppPadding.p18.sp),
        child: Image.asset(
          ImageAssets.verifyAccountImage,
          alignment: Alignment.centerLeft,
          width: 200,
          height: 200,
        ),
      );

  Widget _confirmVerifyAccountCode() => Column(
        children: [
          _resendCode(),
          SizedBox(height: AppSize.s3.h),
          BlocBuilder<VerifyAccountBloc, VerifyAccountState>(
            buildWhen: (prev, state) =>
                state is VerifyAccountLoaded &&
                state.loadedType == VerifyAccountBlocStateType.setCode,
            builder: (context, state) => DrPurpleAppButton(
                title: AppStrings.confirm.tr(),
                onPress: _verifyAccountBloc.inputValid
                    ? () => _verifyAccountBloc.add(VerifyUserAccount())
                    : () async => await Utils.showToast(
                        AppStrings.verifyAccountError.tr())),
          ),
        ],
      );

  Widget _resendCode() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                AppStrings.noCodeQuestion.tr(),
                style: getRegularTextStyle(
                  color: ColorManager.textPrimaryColor,
                  fontSize: FontSize.s16,
                ),
              ),
              SizedBox(width: AppSize.s2.w),
              Text(
                AppStrings.resend.tr(),
                style: getBoldTextStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.primary,
                  textDecoration: TextDecoration.underline,
                ),
              ).onTap(() {}),
            ],
          ),
          const Text("01:58", textAlign: TextAlign.right)
        ],
      );

  List<Widget> _verifyAccountTitle() => [
        SizedBox(height: AppSize.s4.h),
        Text(
          AppStrings.verifyAccount.tr(),
          style: getBoldTextStyle(
            fontSize: FontSize.s24,
            color: ColorManager.textPrimaryColor,
          ),
        ),
        SizedBox(height: AppSize.s1.h),
        Text(
          AppStrings.codeDesc.tr(),
          style: getRegularTextStyle(
            color: ColorManager.textSecondaryColor,
            fontSize: FontSize.s14,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSize.s2.h),
      ];

  Widget _backButton() => Positioned(
        top: 30,
        child: DrPurpleBackButton(
          color: instance<ThemeCubit>().isThemeDark
              ? ColorManager.white
              : ColorManager.black,
        ),
      );
}
