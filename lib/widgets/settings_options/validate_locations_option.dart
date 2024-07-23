import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/widgets/listView_subtitle.dart';
import 'package:azaadi_vpn_android/widgets/listView_title.dart';
import 'package:azaadi_vpn_android/widgets/settings_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ValidateLocationsOption extends StatelessWidget {
  const ValidateLocationsOption({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final connectionController = Get.find<ConnectionController>();
    return Obx(() => SettingsOptionTile(
          leading: Icon(
            LucideIcons.server,
            color: Theme.of(context).colorScheme.primary,
            size: 19,
          ),
          trailing: connectionController.isValidatingServers.value
              ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).colorScheme.primary, size: 25)
              : TextButton(
                  onPressed: () {
                    connectionController.validateServers().then((value) {
                      Get.closeAllSnackbars();
                      Get.snackbar(
                          margin: EdgeInsets.symmetric(
                              vertical: size.height * 0.02,
                              horizontal: size.width * 0.01),
                          icon: Icon(
                            LucideIcons.server,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          'Validation successful',
                          'Please try to connet now');
                    });
                  },
                  child: Text('Validate'),
                ),
          listViewSubtitle: ListViewSubtitle(
              text:
                  'No need to validate unless you have some connection problems'),
          listViewTitle: ListViewTitle(text: 'Validate Locations'),
        ));
  }
}
