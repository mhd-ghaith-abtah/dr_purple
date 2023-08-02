import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/splash/presentation/blocs/splash_bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashBloc _splashBloc;

  _bind() => _splashBloc = instance<SplashBloc>()..add(ManageAppInitState());

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _disposeBloc() async => await _splashBloc.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _splashBloc,
        child: DrPurpleScaffold(
          backgroundColor: !instance<ThemeCubit>().isThemeDark
              ? ColorManager.white
              : ColorManager.primary,
          body: Center(
            child: Container(
              alignment: Alignment.center,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: instance<ThemeCubit>().isThemeDark
                    ? ColorManager.white
                    : null,
              ),
              child: WidgetAnimator(
                atRestEffect: WidgetRestingEffects.size(),
                child: Image.asset(
                  ImageAssets.appLogo,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ),
        ),
      );
}
