import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_back_button.dart';
import 'package:dr_purple/core/widgets/country_code_picker/src/fl_country_code_picker.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/text_fields/dr_purple_phone_number_text_field.dart';
import 'package:dr_purple/features/auth/presentation/bloc/country_code_cubit/country_code_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final FlCountryCodePicker _countryPicker;
  late final CountryCodeCubit _countryCodeCubit;
  late final TextEditingController _phoneNumberTextEditingController;

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _phoneNumberTextEditingController = TextEditingController();

    _countryCodeCubit = instance<CountryCodeCubit>();
    _countryPicker = const FlCountryCodePicker(
        filteredCountries: ["SY"], showSearchBar: false);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeControllers() {
    _phoneNumberTextEditingController.dispose();
  }

  _disposeCubit() async => await _countryCodeCubit.close();

  @override
  void dispose() {
    _disposeCubit();
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DrPurpleScaffold(
        backgroundColor: instance<ThemeCubit>().isThemeDark
            ? ColorManager.appBackgroundColorDark
            : ColorManager.white,
        body: _screenContent(context),
      );

  Widget _screenContent(BuildContext context) => BlocProvider(
        create: (context) => _countryCodeCubit,
        child: Stack(
          children: [
            _forgetPasswordDataView(context),
            _backButton(),
          ],
        ),
      );

  Widget _forgetPasswordDataView(BuildContext context) => Container(
        padding: EdgeInsets.only(top: AppPadding.p3.h),
        decoration:
            boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ..._forgetPasswordTitle(),
              _phoneNumberTextField(),
              SizedBox(height: AppSize.s4.h),
              DrPurpleAppButton(
                title: AppStrings.confirm.tr(),
                onPress: () => context.push(
                    "${GoRouter.of(context).location}/${Routes.resetPasswordRoute}"),
              ),
            ],
          ).paddingSymmetric(horizontal: AppSize.s4.w),
        ),
      );

  Widget _phoneNumberTextField() => Form(
        key: _formKey,
        child: DrPurplePhoneNumberTextField(
          phoneNumberTextEditingController: _phoneNumberTextEditingController,
          formKey: _formKey,
          countryCodeCubit: _countryCodeCubit,
          countryPicker: _countryPicker,
          textInputAction: TextInputAction.done,
        ),
      );

  List<Widget> _forgetPasswordTitle() => [
        SizedBox(height: AppSize.s10.h),
        Text(
          AppStrings.forgotPassword.tr(),
          style: getBoldTextStyle(
            fontSize: FontSize.s24,
            color: ColorManager.textPrimaryColor,
          ),
        ),
        SizedBox(height: AppSize.s1.h),
        Text(
          AppStrings.forgotPasswordDesc.tr(),
          style: getRegularTextStyle(
            color: ColorManager.textSecondaryColor,
            fontSize: FontSize.s14,
          ),
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
