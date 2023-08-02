import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
import 'package:dr_purple/features/home/presentation/screens/widgets/dr_purple_navigation_bar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) => DrPurpleScaffold(
        body: widget.child,
        bottomNavBar: DrPurpleNavigationBar(
          child: widget.child,
        ),
      );
}
// import 'package:dr_purple/core/widgets/dr_purple_scaffold.dart';
// import 'package:dr_purple/features/home/presentation/screens/widgets/dr_purple_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key, required this.navigationShell}) : super(key: key);
//
//   final StatefulNavigationShell navigationShell;
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) => DrPurpleScaffold(
//         body: widget.navigationShell,
//         bottomNavBar: DrPurpleNavigationBar(
//           navigationShell: widget.navigationShell,
//         ),
//       );
// }
