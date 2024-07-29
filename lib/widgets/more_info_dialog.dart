import 'dart:ui';

import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:azaadi_vpn_android/core/models/services/vpn_engine.dart';
import 'package:azaadi_vpn_android/core/models/vpn_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:azaadi_vpn_android/pages/locations_page.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MoreInfoDialog extends StatelessWidget {
  const MoreInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ConnectionController connectionController = Get.put(ConnectionController());
    final colors = Get.find<ColorController>();
    Rx<Vpn> connectedVpn = Rx(HiveController.lastConnected);
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Center(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  gradient: colors.appFootergradient(context),
                  borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        top: size.height * 0.035,
                        bottom: size.height * 0.025,
                      ),
                      child: Center(
                        child: Text(
                          'Connection Details',
                          style: GoogleFonts.ptSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                      ),
                    ),
                    //first row
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.015),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vpn Status  ',
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              softWrap: true,
                              connectionController.vpnState.value,
                              style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //second row
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.015),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Location  ',
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              softWrap: true,
                              connectionController.vpnState.value != 'Connected'
                                  ? 'Unavailable'
                                  : connectedVpn.value.countryLong,
                              style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //third row
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.015),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ping ',
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              softWrap: true,
                              connectionController.vpnState.value != 'Connected'
                                  ? 'Unavailable'
                                  : '${connectedVpn.value.ping} ms',
                              style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.015),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Encryption type ',
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              softWrap: true,
                              connectionController.vpnState.value != 'Connected'
                                  ? 'Unavailable'
                                  : 'SSL/TLS',
                              style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //fourth row
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: size.width * 0.08,
                    //       vertical: size.height * 0.015),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Speed  ',
                    //       ),
                    //       SizedBox(
                    //         width: size.width * 0.4,
                    //         child: Text(
                    //           softWrap: true,
                    //           connectionController.vpnState.value != 'Connected'
                    //               ? 'Unavailable'
                    //               : '${ByteToSpeedConversion.formatBytes(connectedVpn.value.speed, 0)}',
                    //           style: TextStyle(
                    //               overflow: TextOverflow.fade,
                    //               color: Theme.of(context).colorScheme.primary,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 16),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    //fifth row
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.015),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Public IP',
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Text(
                              softWrap: true,
                              connectionController.vpnState.value != 'Connected'
                                  ? 'Unavailable'
                                  : connectedVpn.value.ip,
                              style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //sixth row
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.015),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data transmitted',
                          ),
                          SizedBox(
                              width: size.width * 0.4,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StreamBuilder<VpnStatus?>(
                                      initialData: VpnStatus(),
                                      stream: VpnEngine.vpnStatusSnapshot(),
                                      builder: (context, s) {
                                        if (s.connectionState !=
                                                ConnectionState.active ||
                                            !s.hasData) {
                                          return Text('');
                                        }

                                        return Text(
                                          "${s.data?.byteIn!.split('-')[0] ?? ""} ${s.data?.byteOut!.split('-')[0] ?? ""}",
                                          style: TextStyle(
                                              overflow: TextOverflow.fade,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        );
                                      }),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                        bottom: size.height * 0.035,
                        top: size.height * 0.025,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Back',
                                style: TextStyle(color: Colors.white),
                              )),
                          ElevatedButton.icon(
                              icon: Icon(
                                LucideIcons.globe,
                                size: 17,
                              ),
                              onPressed: () {
                                Get.back();
                                Future.delayed(Duration(milliseconds: 300))
                                    .then((value) => Get.to(LocationsPage()));
                              },
                              label: Text('Change Loction')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
