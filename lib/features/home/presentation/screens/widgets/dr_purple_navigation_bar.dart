import 'package:dr_purple/app/app_management/route_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrPurpleNavigationBar extends StatefulWidget {
  const DrPurpleNavigationBar({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  State<DrPurpleNavigationBar> createState() => _DrPurpleNavigationBarState();
}

class _DrPurpleNavigationBarState extends State<DrPurpleNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _currentIndex == 0
            ? () async => true
            : () async {
                setState(() {
                  _currentIndex = 0;
                });
                context.go(Routes.homeRoute);
                return false;
              },
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (newIdx) =>
              _onDestinationTapped(newIdx, context),
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: const Icon(Icons.home_outlined, size: AppSize.s30),
              selectedIcon: const Icon(Icons.home_rounded),
              label: AppStrings.homeNav.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.calendar_today),
              selectedIcon: const Icon(Icons.calendar_month_rounded),
              label: AppStrings.appointmentsNav.tr(),
            ),
            NavigationDestination(
              icon: const Icon(CupertinoIcons.bell),
              selectedIcon: const Icon(CupertinoIcons.bell_fill),
              label: AppStrings.notificationsNav.tr(),
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings_rounded),
              label: AppStrings.settingsNav.tr(),
            ),
          ],
        ),
      );

  void _onDestinationTapped(int destinationIndex, BuildContext context) {
    if (destinationIndex == _currentIndex) return;
    setState(() {
      _currentIndex = destinationIndex;
    });
    switch (destinationIndex) {
      case 0:
        context.go(Routes.homeRoute);
        break;
      case 1:
        context.go(Routes.appointmentsRoute);
        break;
      case 2:
        context.go(Routes.notificationsRoute);
        break;
      case 3:
        context.go(Routes.settingsRoute);
        break;
    }
  }
}
// import 'package:dr_purple/app/app_management/strings_manager.dart';
// import 'package:dr_purple/app/app_management/values_manager.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class DrPurpleNavigationBar extends StatelessWidget {
//   const DrPurpleNavigationBar({Key? key, required this.navigationShell})
//       : super(key: key);
//
//   final StatefulNavigationShell navigationShell;
//
//   @override
//   Widget build(BuildContext context) {
//     return NavigationBar(
//       selectedIndex: navigationShell.currentIndex,
//       onDestinationSelected: _onDestinationTapped,
//       destinations: <NavigationDestination>[
//         NavigationDestination(
//           icon: const Icon(Icons.home_outlined, size: AppSize.s30),
//           selectedIcon: const Icon(Icons.home_rounded),
//           label: AppStrings.homeNav.tr(),
//         ),
//         NavigationDestination(
//           icon: const Icon(Icons.calendar_today),
//           selectedIcon: const Icon(Icons.calendar_month_rounded),
//           label: AppStrings.appointmentsNav.tr(),
//         ),
//         NavigationDestination(
//           icon: const Icon(CupertinoIcons.bell),
//           selectedIcon: const Icon(CupertinoIcons.bell_fill),
//           label: AppStrings.notificationsNav.tr(),
//         ),
//         NavigationDestination(
//           icon: const Icon(Icons.settings_outlined),
//           selectedIcon: const Icon(Icons.settings_rounded),
//           label: AppStrings.settingsNav.tr(),
//         ),
//       ],
//     );
//   }
//
//   void _onDestinationTapped(int destinationIndex) => navigationShell.goBranch(
//         destinationIndex,
//         initialLocation: destinationIndex == navigationShell.currentIndex,
//       );
// }
