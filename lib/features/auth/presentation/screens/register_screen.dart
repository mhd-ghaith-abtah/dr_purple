import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/core/utils/enums.dart';
import 'package:dr_purple/core/utils/extensions.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:dr_purple/core/widgets/country_code_picker/src/fl_country_code_picker.dart';
import 'package:dr_purple/core/widgets/dr_purple_drop_down_menu.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_email_text_field.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_first_last_name_text_fields.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_name_text_field.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_password_text_field.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_phone_number_text_field.dart';
import 'package:dr_purple/features/auth/presentation/bloc/country_code_cubit/country_code_cubit.dart';
import 'package:dr_purple/features/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final CountryCodeCubit _countryCodeCubit;
  late final RegisterBloc _registerBloc;
  late final FlCountryCodePicker _countryPicker;
  late final TextEditingController _emailTextEditingController,
      _passwordTextEditingController,
      _phoneNumberTextEditingController,
      _usernameTextEditingController,
      _firstNameTextEditingController,
      _lastNameTextEditingController;

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _registerBloc = instance<RegisterBloc>();
    _countryCodeCubit = instance<CountryCodeCubit>();

    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _phoneNumberTextEditingController = TextEditingController();
    _firstNameTextEditingController = TextEditingController();
    _lastNameTextEditingController = TextEditingController();
    _usernameTextEditingController = TextEditingController();

    _countryPicker = const FlCountryCodePicker(
        filteredCountries: ["SY"], showSearchBar: false);

    _emailTextEditingController.addListener(() => _registerBloc
      ..add(SetRegisterEmail(_emailTextEditingController.text))
      ..add(RegisterValidateInputEvent()));

    _passwordTextEditingController.addListener(() => _registerBloc
      ..add(SetRegisterPassword(_passwordTextEditingController.text))
      ..add(RegisterValidateInputEvent()));

    _phoneNumberTextEditingController.addListener(() => _registerBloc
      ..add(SetRegisterPhoneNumber(_phoneNumberTextEditingController.text))
      ..add(RegisterValidateInputEvent()));

    _firstNameTextEditingController.addListener(() {
      _registerBloc
        ..add(SetRegisterFirstName(_firstNameTextEditingController.text))
        ..add(RegisterValidateInputEvent());
      _usernameTextEditingController.text =
          "${_firstNameTextEditingController.text}_${_lastNameTextEditingController.text}";
    });

    _lastNameTextEditingController.addListener(() {
      _registerBloc
        ..add(SetRegisterLastName(_lastNameTextEditingController.text))
        ..add(RegisterValidateInputEvent());
      _usernameTextEditingController.text =
          "${_firstNameTextEditingController.text}_${_lastNameTextEditingController.text}";
    });

    _usernameTextEditingController.addListener(() => _registerBloc
      ..add(SetRegisterUsername(_usernameTextEditingController.text))
      ..add(RegisterValidateInputEvent()));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeControllers() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _phoneNumberTextEditingController.dispose();
    _firstNameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
  }

  _disposeCubit() async {
    await _countryCodeCubit.close();
    await _registerBloc.close();
  }

  @override
  void dispose() {
    _disposeCubit();
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DrPurpleScaffold(
        body: _screenContent(context),
      );

  Widget _screenContent(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _countryCodeCubit),
          BlocProvider(create: (context) => _registerBloc),
        ],
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) async {
            if (state is RegisterLoading) {
              if (state.loadingType == RegisterBlocStateType.server) {
                LoadingOverlay.of(context).show();
              }
            } else if (state is RegisterLoaded) {
              if (state.loadedType == RegisterBlocStateType.server) {
                LoadingOverlay.of(context).hide();
                context.push(
                    "${GoRouter.of(context).location}/${Routes.verifyAccountRoute}");
              }
            } else if (state is RegisterError) {
              if (state.errorType == RegisterBlocStateType.server) {
                LoadingOverlay.of(context).hide();
              }
              await Utils.showToast(state.errorMessage);
            }
          },
          child: Stack(
            children: [
              _registerDataView(context),
              _registerImage(context),
            ],
          ),
        ),
      );

  Widget _registerImage(BuildContext context) => Container(
        margin: EdgeInsets.only(top: AppPadding.p10.h),
        width: context.width(),
        child: Image.asset(
          ImageAssets.authImage,
          alignment: Alignment.center,
          width: AppSize.s50.w,
          height: AppSize.s25.h,
        ),
      );

  Widget _registerDataView(BuildContext context) => Container(
        margin: EdgeInsets.only(top: AppSize.s32.h),
        height: context.height(),
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: radiusOnly(topRight: AppSize.s32),
          backgroundColor: context.cardColor,
        ),
        child: SingleChildScrollView(child: _registerMainView()),
      );

  Widget _registerMainView() => Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._registerTitle(),
            _emailTextField(),
            SizedBox(height: AppSize.s2.h),
            _phoneNumberTextField(),
            SizedBox(height: AppSize.s2.h),
            _passwordTextField(),
            SizedBox(height: AppSize.s2.h),
            _nameTextFields(),
            SizedBox(height: AppSize.s2.h),
            _usernameTextField(),
            SizedBox(height: AppSize.s2.h),
            _genderSelection(),
            SizedBox(height: AppSize.s3.h),
            _registerButton(),
            SizedBox(height: AppSize.s3.h),
            _alreadyHaveAccountClickable(context),
            SizedBox(height: AppSize.s4.h),
          ],
        ).paddingSymmetric(horizontal: AppSize.s4.w),
      );

  Widget _alreadyHaveAccountClickable(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.alreadyHasAccountQuestion.tr(),
            style: getRegularTextStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textSecondaryColor,
            ),
          ),
          SizedBox(width: AppSize.s2.w),
          Text(
            AppStrings.login.tr(),
            style: getBoldTextStyle(
              color: ColorManager.lightPrimary,
              fontSize: FontSize.s16,
              textDecoration: TextDecoration.underline,
            ),
          ).onTap(() => context.pushReplacement("/${Routes.loginRoute}")),
        ],
      );

  Widget _registerButton() => BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) => DrPurpleAppButton(
          title: AppStrings.register.tr(),
          onPress: _registerBloc.inputsValid
              ? () => _registerBloc.add(RegisterUserEvent())
              : () async =>
                  await Utils.showToast(AppStrings.missingInfoError.tr()),
        ),
      );

  Widget _passwordTextField() => DrPurplePasswordTextField(
        passwordTextEditingController: _passwordTextEditingController,
        formKey: _formKey,
      );

  Widget _emailTextField() => DrPurpleEmailTextField(
        emailTextEditingController: _emailTextEditingController,
        formKey: _formKey,
      );

  Widget _phoneNumberTextField() => DrPurplePhoneNumberTextField(
        phoneNumberTextEditingController: _phoneNumberTextEditingController,
        formKey: _formKey,
        countryCodeCubit: _countryCodeCubit,
        countryPicker: _countryPicker,
      );

  Widget _nameTextFields() => DrPurpleFirstLastNameTextFields(
        firstNameTextEditingController: _firstNameTextEditingController,
        lastNameTextEditingController: _lastNameTextEditingController,
        formKey: _formKey,
      );

  Widget _usernameTextField() => DrPurpleNameTextField(
        label: AppStrings.usernameTextFieldLabel.tr(),
        formKey: _formKey,
        errorMessage: AppStrings.usernameError.tr(),
        nameTextEditingController: _usernameTextEditingController,
        readOnly: true,
        fontSize: FontSize.s16,
      );

  Widget _genderSelection() => BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (prev, state) =>
            state is RegisterLoaded &&
            state.loadedType == RegisterBlocStateType.genderSelected,
        builder: (context, state) => DrPurpleDropDownMenu<Gender>(
          title: AppStrings.gender.tr(),
          items: Constants.genders
              .map(
                (item) => DropdownMenuItem<Gender>(
                  value: item,
                  child: Text(
                    item.getLocalizedString(),
                    style: getRegularTextStyle(
                      fontSize: FontSize.s16,
                      color: instance<ThemeCubit>().isThemeDark
                          ? ColorManager.white
                          : ColorManager.primary,
                    ),
                  ),
                ),
              )
              .toList(),
          value: _registerBloc.selectedGender,
          onChanged: (selectedGender) =>
              _registerBloc.add(SetRegisterGender(selectedGender!)),
        ),
      );

  List<Widget> _registerTitle() => [
        SizedBox(height: AppSize.s3_5.h),
        Text(
          AppStrings.register.tr(),
          style: getBoldTextStyle(
            fontSize: FontSize.s28,
            color: ColorManager.textPrimaryColor,
          ),
        ),
        SizedBox(height: AppSize.s1.h),
        Text(
          AppStrings.registerTitle.tr(),
          style: getRegularTextStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textSecondaryColor,
          ),
        ),
        SizedBox(height: AppSize.s2.h),
      ];
}
