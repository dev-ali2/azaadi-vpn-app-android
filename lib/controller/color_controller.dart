import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorController extends GetxController {
  Rx<int> theme = HiveController.getTheme.obs;

  Color dividerColor(BuildContext context) {
    theme.value = HiveController.getTheme;
    switch (theme.value) {
      case 0:
        return Theme.of(context).colorScheme.primary.withOpacity(0.5);
      case 1:
        return Colors.green.withOpacity(0.7);
      default:
        return Colors.white;
    }
  }

  LinearGradient appFootergradient(BuildContext context) {
    theme.value = HiveController.getTheme;
    switch (theme.value) {
      case 0:
        return LinearGradient(begin: Alignment.centerLeft, colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.1),
          Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
          Theme.of(context).colorScheme.secondary.withOpacity(0.1)
        ]);
      case 1:
        return LinearGradient(colors: [
          Colors.green.withOpacity(0.2),
          Colors.red.withOpacity(0.2)
        ], stops: [
          0.3,
          0.8
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
      case 2:
        return LinearGradient(colors: [
          Colors.white.withOpacity(0.2),
          Colors.green.withOpacity(0.2),
        ], stops: [
          0.1,
          0.8
        ], begin: Alignment.centerLeft, end: Alignment.centerRight);
      default:
        return LinearGradient(begin: Alignment.centerLeft, colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.1),
          Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
          Theme.of(context).colorScheme.secondary.withOpacity(0.1)
        ]);
    }
  }

  LinearGradient? pageGradient() {
    theme.value = HiveController.getTheme;
    switch (theme.value) {
      case 0:
        return null;
      case 1:
        return LinearGradient(colors: [
          Colors.green.withAlpha(60),
          Colors.red.withAlpha(70),
        ], stops: [
          0.3,
          0.8
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
      case 2:
        return LinearGradient(colors: [
          Colors.white.withAlpha(60),
          Colors.green.withAlpha(70),
        ], stops: [
          0.1,
          0.8
        ], begin: Alignment.centerLeft, end: Alignment.centerRight);
    }
    return null;
  }
}
