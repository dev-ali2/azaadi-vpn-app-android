import 'package:flutter/material.dart';

class SettingsOptionTile extends StatelessWidget {
  SettingsOptionTile(
      {super.key,
      this.leading = const SizedBox.shrink(),
      this.listViewSubtitle = const SizedBox.shrink(),
      this.listViewTitle = const SizedBox.shrink(),
      this.trailing = const SizedBox.shrink()});
  Widget leading;
  Widget listViewTitle;
  Widget listViewSubtitle;
  Widget trailing;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: size.height * 0.007, horizontal: 10),
      child: ListTile(
        leading: leading,
        subtitle: listViewSubtitle,
        title: listViewTitle,
        trailing: trailing,
      ),
    );
  }
}
