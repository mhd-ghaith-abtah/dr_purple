import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_name_text_field.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_password_text_field.dart';
import 'package:dr_purple/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginBloc _loginBloc;
  late final TextEditingController _usernameTextEditingController,
      _passwordTextEditingController;

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _loginBloc = instance<LoginBloc>();

    _usernameTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();

    _usernameTextEditingController.addListener(() => _loginBloc
      ..add(SetLoginUsername(_usernameTextEditingController.text))
      ..add(LoginValidateInputEvent()));

    _passwordTextEditingController.addListener(() => _loginBloc
      ..add(SetLoginPassword(_passwordTextEditingController.text))
      ..add(LoginValidateInputEvent()));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeControllers() {
    _usernameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  _disposeBloc() async {
    await _loginBloc.close();
  }

  @override
  void dispose() {
    _disposeBloc();
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DrPurpleScaffold(
        body: _screenContent(context),
      );

  Widget _screenContent(BuildContext context) => BlocProvider(
        create: (context) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginLoading) {
              if (state.loadingType == LoginBlocStateType.server) {
                LoadingOverlay.of(context).show();
              }
            } else if (state is LoginLoaded) {
              if (state.loadedType == LoginBlocStateType.server) {
                LoadingOverlay.of(context).hide();
                context.go(Routes.homeRoute);
              }
            } else if (state is LoginError) {
              if (state.errorType == LoginBlocStateType.server) {
                LoadingOverlay.of(context).hide();
              }
              await Utils.showToast(state.errorMessage);
            }
          },
          child: Stack(
            children: [
              _loginDataView(context),
              _loginImage(context),
            ],
          ),
        ),
      );

  Widget _loginImage(BuildContext context) => Container(
        margin: EdgeInsets.only(top: AppPadding.p10.h),
        width: context.width(),
        child: Image.asset(
          ImageAssets.authImage,
          alignment: Alignment.center,
          width: AppSize.s50.w,
          height: AppSize.s25.h,
        ),
      );

  Widget _loginDataView(BuildContext context) => Container(
        margin: EdgeInsets.only(top: AppSize.s32.h),
        height: context.height(),
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: radiusOnly(topRight: AppSize.s32),
          backgroundColor: context.cardColor,
        ),
        child: SingleChildScrollView(child: _loginMainView()),
      );

  Widget _loginMainView() => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._loginTitle(),
            _usernameTextField(),
            SizedBox(height: AppSize.s2.h),
            _passwordTextField(),
            SizedBox(height: AppSize.s1.h),
            _forgetPasswordClickable(context),
            SizedBox(height: AppSize.s3.h),
            _loginButton(),
            SizedBox(height: AppSize.s3.h),
            _noAccountClickable(context),
            SizedBox(height: AppSize.s4.h),
          ],
        ).paddingSymmetric(horizontal: AppSize.s4.w),
      );

  Widget _noAccountClickable(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.noAccountQuestion.tr(),
            style: getRegularTextStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textSecondaryColor,
            ),
          ),
          SizedBox(width: AppSize.s2.w),
          Text(
            AppStrings.register.tr(),
            style: getBoldTextStyle(
              color: ColorManager.lightPrimary,
              fontSize: FontSize.s16,
              textDecoration: TextDecoration.underline,
            ),
          ).onTap(() => context.pushReplacement("/${Routes.registerRoute}")),
        ],
      );

  Widget _loginButton() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => DrPurpleAppButton(
          onPress: _loginBloc.inputsValid
              ? () => _loginBloc.add(LogUserInEvent())
              : () async =>
                  await Utils.showToast(AppStrings.missingInfoError.tr()),
          title: AppStrings.login.tr(),
        ),
      );

  Widget _forgetPasswordClickable(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: Text(
          AppStrings.forgotPasswordQuestion.tr(),
          style: getRegularTextStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondaryColor,
            textDecoration: TextDecoration.underline,
          ),
        ).onTap(() => context.push(
            "${GoRouter.of(context).location}/${Routes.forgotPasswordRoute}")),
      );

  Widget _passwordTextField() => DrPurplePasswordTextField(
        passwordTextEditingController: _passwordTextEditingController,
        formKey: _formKey,
      );

  Widget _usernameTextField() => DrPurpleNameTextField(
        label: AppStrings.usernameTextFieldLabel.tr(),
        formKey: _formKey,
        errorMessage: AppStrings.usernameError.tr(),
        nameTextEditingController: _usernameTextEditingController,
        fontSize: FontSize.s16,
      );

  List<Widget> _loginTitle() => [
        SizedBox(height: AppSize.s3_5.h),
        Text(
          AppStrings.login.tr(),
          style: getBoldTextStyle(
            fontSize: FontSize.s28,
            color: ColorManager.textPrimaryColor,
          ),
        ),
        SizedBox(height: AppSize.s1.h),
        Text(
          AppStrings.loginTitle.tr(),
          style: getRegularTextStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondaryColor,
          ),
        ),
        SizedBox(height: AppSize.s2.h),
      ];
}
