import 'package:flutter/material.dart';

class StretchScrollBehavior extends ScrollBehavior {
  @override
  AndroidOverscrollIndicator get androidOverscrollIndicator =>
      AndroidOverscrollIndicator.stretch;
}
