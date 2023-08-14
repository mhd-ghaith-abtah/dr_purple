import 'dart:async';
import 'package:dr_purple/app/app_management/font_manager.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/app/app_management/theme/color_manager.dart';
import 'package:dr_purple/app/app_management/theme/styles_manager.dart';
import 'package:dr_purple/app/app_management/values_manager.dart';
import 'package:dr_purple/core/widgets/loading_overlay.dart';
import 'package:dr_purple/features/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TimerCountdown extends StatefulWidget {
  /// resets the timer
  final Function() onTapResend;

  /// `TextStyle` for the time numbers.
  final TextStyle? timeTextStyle;

  /// `TextStyle` for the colons betwenn the time numbers.
  final TextStyle? colonsTextStyle;

  final bool isVerifyAccount;

  const TimerCountdown({
    super.key,
    this.timeTextStyle,
    this.colonsTextStyle,
    required this.onTapResend,
    required this.isVerifyAccount,
  });

  @override
  TimerCountdownState createState() => TimerCountdownState();
}

class TimerCountdownState extends State<TimerCountdown> {
  Timer? timer;
  late String countdownDays;
  late String countdownHours;
  late String countdownMinutes;
  late String countdownSeconds;
  late Duration difference;
  bool enableResend = false;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  /// Calculate the time difference between now end the given [endTime] and initialize all UI timer values.
  ///
  /// Then create a periodic `Timer` which updates all fields every second depending on the time difference which is getting smaller.
  /// When this difference reached `Duration.zero` the `Timer` is stopped and the [onEnd] callback is invoked.
  void _startTimer() {
    final endTime = DateTime.now().add(const Duration(minutes: 2));
    if (endTime.isBefore(DateTime.now())) {
      difference = Duration.zero;
    } else {
      difference = endTime.difference(DateTime.now());
    }
    countdownMinutes = _durationToStringMinutes(difference);
    countdownSeconds = _durationToStringSeconds(difference);

    if (difference == Duration.zero) {
      setState(() {
        enableResend = true;
      });
    } else {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        difference = endTime.difference(DateTime.now());
        setState(() {
          countdownMinutes = _durationToStringMinutes(difference);
          countdownSeconds = _durationToStringSeconds(difference);
        });
        if (difference <= Duration.zero) {
          timer.cancel();
          setState(() {
            enableResend = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.isVerifyAccount
      ? _countDownTimerFormat()
      : BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, state) async {
            if (state is ForgetPasswordLoaded) {
              if (state.loadedType == ForgetPasswordBlocStateType.server) {
                setState(() {
                  enableResend = false;
                });
                timer?.cancel();
                _startTimer();
              }
            }
          },
          child: _countDownTimerFormat(),
        );

  /// Builds the UI colons between the time units.
  Widget _colon() => Text(":", style: widget.colonsTextStyle);

  /// Builds the timer minutes with its description.
  Widget _minutes(BuildContext context) =>
      Text(countdownMinutes, style: widget.timeTextStyle);

  /// Builds the timer seconds with its description.
  Widget _seconds(BuildContext context) =>
      Text(countdownSeconds, style: widget.timeTextStyle);

  /// When the selected [CountDownTimerFormat] is leaving out the last unit, this function puts the UI value of the unit before up by one.
  ///
  /// This is done to show the currently running time unit.
  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  /// Convert [Duration] in minutes to String for UI.
  String _durationToStringMinutes(Duration duration) =>
      _twoDigits(duration.inMinutes);

  /// Convert [Duration] in seconds to String for UI.
  String _durationToStringSeconds(Duration duration) =>
      _twoDigits(duration.inSeconds.remainder(60));

  /// Switches the UI to be displayed based on [CountDownTimerFormat].
  Widget _countDownTimerFormat() => Row(
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
              color: enableResend ? ColorManager.primary : Colors.grey,
              textDecoration: TextDecoration.underline,
            ),
          ).onTap(enableResend
              ? widget.isVerifyAccount
                  ? () async {
                      LoadingOverlay.of(context).show();
                      await Future.delayed(AppDurations.superSlow, () {
                        LoadingOverlay.of(context).hide();
                        setState(() {
                          enableResend = false;
                        });
                        timer?.cancel();
                        _startTimer();
                      });
                    }
                  : widget.onTapResend
              : null),
          const Spacer(),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _minutes(context),
                _colon(),
                _seconds(context),
              ],
            ),
          ),
        ],
      );
}
