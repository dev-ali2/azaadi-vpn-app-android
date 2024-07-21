import 'package:azaadi_vpn_android/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      inactiveThumbColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.7),
      inactiveTrackColor: AppColors.black.withOpacity(0.1),
      value: value,
      onChanged: onChanged,
    );
  }
}
