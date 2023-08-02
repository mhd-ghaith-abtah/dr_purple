import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/theme_cubit/theme_cubit.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/app/dependency_injection/dependency_injection.dart';
import 'package:dr_purple/core/utils/utils.dart';
import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/home/presentation/blocs/services_bloc/services_bloc.dart';
import 'package:dr_purple/features/home/presentation/screens/widgets/home_bottom_component.dart';
import 'package:dr_purple/features/home/presentation/screens/widgets/home_top_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ServicesBloc _servicesBloc;

  _bind() => _servicesBloc = instance<ServicesBloc>()..add(GetAllServices());

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _disposeBloc() async => await _servicesBloc.close();

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => _servicesBloc,
        child: BlocListener<ServicesBloc, ServicesState>(
          listener: (context, state) async {
            if (state is ServicesError) {
              await Utils.showToast(state.errorMessage);
            }
          },
          child: _homeContent(),
        ),
      );

  Widget _homeContent() => SafeArea(
        child: DrPurpleScaffold(
          backgroundColor: instance<ThemeCubit>().isThemeDark
              ? ColorManager.black
              : ColorManager.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                HomeTopComponent(servicesBloc: _servicesBloc),
                SizedBox(height: AppSize.s2.h),
                HomeBottomComponent(servicesBloc: _servicesBloc),
                SizedBox(height: AppSize.s4.h),
              ],
            ),
          ),
        ),
      );
}
