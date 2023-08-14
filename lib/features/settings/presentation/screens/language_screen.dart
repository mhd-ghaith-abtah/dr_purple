import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/language_manager/language_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/buttons/dr_purple_app_button.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/features/settings/presentation/blocs/manage_language_cubit/manage_language_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late final ManageLanguageCubit _manageLanguageCubit;

  _bind() => _manageLanguageCubit = instance<ManageLanguageCubit>()..init();

  @override
  initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _manageLanguageCubit.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _screenContent();

  Widget _screenContent() => BlocProvider(
        create: (context) => _manageLanguageCubit,
        child: _languageScreenContent(),
      );

  Widget _languageScreenContent() =>
      BlocConsumer<ManageLanguageCubit, ManageLanguageState>(
        listener: (context, state) async {
          if (state is ErrorChangingAppLanguage) {
            LoadingOverlay.of(context).hide();
            await Utils.showToast(state.errorMessage);
          } else if (state is ChangingAppLanguage) {
            LoadingOverlay.of(context).show();
          } else if (state is AppLanguageChanged) {
            LoadingOverlay.of(context).hide();
          }
        },
        builder: (context, state) {
          return DrPurpleScaffold(
            backgroundColor: instance<ThemeCubit>().isThemeDark
                ? ColorManager.black
                : ColorManager.white,
            appBar: AppBar(
              title: Text(AppStrings.languageScreenTitle.tr()),
            ),
            body: Column(
              children: [
                SizedBox(height: AppSize.s10.h),
                Container(
                  padding: EdgeInsets.all(AppPadding.p10.sp),
                  decoration: boxDecorationRoundedWithShadow(
                    AppSize.s10.toInt(),
                    backgroundColor: context.cardColor,
                  ),
                  child: Column(
                    children: [
                      RadioListTile<Language>(
                        title: Text(
                          AppStrings.englishLanguage,
                          style: getRegularTextStyle(
                            color: ColorManager.textPrimaryColor,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        value: Language.en,
                        groupValue: _manageLanguageCubit.selectedLanguage,
                        onChanged: (Language? newLanguage) =>
                            _manageLanguageCubit
                                .manageScreen(newLanguage ?? Language.en),
                        activeColor: ColorManager.primary,
                      ),
                      RadioListTile<Language>(
                        title: Text(
                          AppStrings.arabicLanguage,
                          style: getRegularTextStyle(
                            color: ColorManager.textPrimaryColor,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        value: Language.ar,
                        groupValue: _manageLanguageCubit.selectedLanguage,
                        onChanged: (Language? newLanguage) =>
                            _manageLanguageCubit
                                .manageScreen(newLanguage ?? Language.ar),
                        activeColor: ColorManager.primary,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSize.s2.h),
                DrPurpleAppButton(
                  onPress: () async =>
                      await _manageLanguageCubit.changeAppLanguage(context),
                  title: AppStrings.confirm.tr(),
                ),
              ],
            ).paddingSymmetric(horizontal: AppSize.s4.w),
          );
        },
      );
}
