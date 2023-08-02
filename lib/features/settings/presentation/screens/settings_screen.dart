import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/design/dr_purple_list_item_design.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/features/auth/presentation/bloc/logout_cubit/logout_cubit.dart';
import 'package:dr_purple/features/settings/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final LogoutCubit _logoutCubit;

  _bind() => _logoutCubit = instance<LogoutCubit>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _logoutCubit.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DrPurpleScaffold(
        body: _screenContent(),
      );

  Widget _screenContent() => BlocProvider(
        create: (context) => _logoutCubit,
        child: BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) async {
            if (state is LoggingOut) {
              LoadingOverlay.of(context).show();
            } else if (state is LoggedOut) {
              LoadingOverlay.of(context).hide();
              SchedulerBinding.instance.addPostFrameCallback((_) =>
                  GoRouter.of(context)
                    ..pushReplacement("/${Routes.loginRoute}"));
            } else if (state is LogoutError) {
              LoadingOverlay.of(context).hide();
              await Utils.showToast(state.errorMessage);
            }
          },
          child: CustomScrollView(
            slivers: <Widget>[_settingsAppBar(), _settingMainContent()],
          ),
        ),
      );

  Widget _settingMainContent() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              return _mainContent(context);
            }
            return null;
          },
        ),
      );

  Widget _mainContent(BuildContext context) => Container(
        height: AppSize.s70.h,
        padding: EdgeInsets.all(AppPadding.p18.sp),
        color: instance<ThemeCubit>().isThemeDark
            ? ColorManager.black
            : ColorManager.white,
        child: Column(
          children: [
            _toggleThemeSwitch(context),
            SizedBox(height: AppSize.s2.h),
            _settingsItems(context),
          ],
        ),
      );

  Widget _settingsItems(BuildContext context) => Column(
        children: [
          DrPurpleListItemDesign(
            icon: CupertinoIcons.globe,
            title: AppStrings.language.tr(),
            onTap: () => context.push(
                "${GoRouter.of(context).location}/${Routes.languageRoute}"),
          ),
          DrPurpleListItemDesign(
            icon: Icons.account_circle_outlined,
            title: AppStrings.profile.tr(),
            onTap: () {},
          ),
          DrPurpleListItemDesign(
            icon: Icons.logout_outlined,
            iconColor: ColorManager.red,
            showAnotherPageIcon: false,
            title: AppStrings.logout.tr(),
            onTap: () async => await Utils.dialog(
              context: context,
              dialogType: DialogType.warning,
              okButtonTitle: AppStrings.logout.tr(),
              dialogTitle: AppStrings.logout.tr(),
              dialogDesc: AppStrings.logoutDesc.tr(),
              onPressCancel: () {},
              onPressOk: () async => await _logoutCubit.logout(),
              swapColors: true,
            ).show(),
          ),
          DrPurpleListItemDesign(
            icon: CupertinoIcons.delete_simple,
            iconColor: ColorManager.red,
            textColor: ColorManager.red,
            showAnotherPageIcon: false,
            title: AppStrings.deleteAccount.tr(),
            onTap: () async => await Utils.dialog(
              context: context,
              dialogType: DialogType.warning,
              okButtonTitle: AppStrings.delete.tr(),
              dialogTitle: AppStrings.deleteAccount.tr(),
              dialogDesc: AppStrings.deleteAccountDesc.tr(),
              onPressCancel: () {},
              onPressOk: () {},
              swapColors: true,
            ).show(),
          ),
        ],
      );

  Widget _toggleThemeSwitch(BuildContext context) => Container(
        padding: EdgeInsets.all(AppPadding.p10.sp),
        decoration: nb.boxDecorationRoundedWithShadow(
          AppSize.s10.toInt(),
          backgroundColor: context.cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  ImageAssets.themeImage,
                  height: AppSize.s24,
                  width: AppSize.s24,
                  color: instance<ThemeCubit>().isThemeDark
                      ? ColorManager.black
                      : Colors.blue,
                ).paddingOnly(left: AppPadding.p1.w),
                SizedBox(width: AppSize.s2.w),
                Text(
                  AppStrings.darkTheme.tr(),
                  style: getRegularTextStyle(
                    color: ColorManager.textPrimaryColor,
                    fontSize: FontSize.s16,
                  ),
                ),
              ],
            ),
            Switch.adaptive(
              value: instance<ThemeCubit>().isThemeDark,
              activeColor: ColorManager.black,
              onChanged: (s) {
                instance<ThemeCubit>().toggleTheme();
              },
            )
          ],
        ),
      ).onTap(
        () => instance<ThemeCubit>().toggleTheme(),
      );

  Widget _settingsAppBar() => SliverAppBar(
        automaticallyImplyLeading: false,
        expandedHeight: AppSize.s30.h,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: ColorManager.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: AppSize.s40,
                  backgroundColor: ColorManager.cyan,
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    bloc: instance<ProfileBloc>(),
                    builder: (context, state) {
                      if (instance<ProfileBloc>().getProfileEntity?.gender ==
                          1) {
                        return Image.asset(ImageAssets.maleProfileImage);
                      } else if (instance<ProfileBloc>()
                              .getProfileEntity
                              ?.gender ==
                          2) {
                        return Image.asset(ImageAssets.femaleProfileImage);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                SizedBox(height: AppSize.s1.h),
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: instance<ProfileBloc>(),
                  builder: (context, state) {
                    if (instance<ProfileBloc>().getProfileEntity != null) {
                      return Text(
                        "${instance<ProfileBloc>().getProfileEntity?.firstName} ${instance<ProfileBloc>().getProfileEntity?.lastName}",
                        style: getBoldTextStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s24,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: AppSize.s1.h),
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: instance<ProfileBloc>(),
                  builder: (context, state) {
                    if (instance<ProfileBloc>().getProfileEntity != null) {
                      return Text(
                        instance<ProfileBloc>().getProfileEntity?.email ?? "",
                        style: getRegularTextStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s16,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
