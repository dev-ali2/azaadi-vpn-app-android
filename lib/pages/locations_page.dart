import 'package:azaadi_vpn_android/controller/color_controller.dart';
import 'package:azaadi_vpn_android/controller/haptic_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LocationsPage extends StatelessWidget {
  LocationsPage({super.key});
  static final List<Vpn> servers = HiveController.getVpnList;

  @override
  Widget build(BuildContext context) {
    final connectionController = Get.find<ConnectionController>();
    final colors = Get.find<ColorController>();
    final hapticController = Get.find<HapticController>();
    final List<Map<String, String>> locations =
        connectionController.getAvailableLocations();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Available Locations (${locations.length})',
            style: GoogleFonts.ptSans(
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
          ),
        ),
        body: locations.length <= 0
            ? Center(
                child: Text('No Available Locations\nTry restarting the app'),
              )
            : Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(gradient: colors.pageGradient()),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: size.height * 0.85,
                          child: ListView.builder(
                            itemCount: locations.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                hapticController
                                    .provideFeedback(FeedbackType.light);
                                connectionController.trySelectedLocation(
                                    locations[index]['country']!);
                              },
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: ListTile(
                                  // trailing: Icon(
                                  //   LucideIcons.arrowRight,
                                  //   color:
                                  //       Theme.of(context).colorScheme.primary,
                                  //   size: 20,
                                  // ),
                                  trailing: Icon(
                                    CupertinoIcons.arrow_right_circle_fill,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  // trailing: connectionController.noOfServers(
                                  //             locations[index]['country']!) <
                                  //         3
                                  //     ? Icon(
                                  //         Icons.speed,
                                  //         color: Colors.red,
                                  //       )
                                  //     : connectionController.noOfServers(
                                  //                 locations[index]
                                  //                     ['country']!) <
                                  //             8
                                  //         ? Icon(
                                  //             Icons.speed,
                                  //             color: Colors.yellow,
                                  //           )
                                  //         : connectionController.noOfServers(
                                  //                     locations[index]
                                  //                         ['country']!) >=
                                  //                 15
                                  //             ? Icon(
                                  //                 Icons.speed,
                                  //                 color: Colors.green,
                                  //               )
                                  //             : null,
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.04),
                                    child: Text(
                                      locations[index]['country']!,
                                      style: GoogleFonts.ptSans(
                                          textStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  leading: SizedBox(
                                    width: 60,
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                          fit: BoxFit.cover,
                                          // width: 80,
                                          // height: 60,
                                          locations[index]['flag']!
                                              .toLowerCase()),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.015),
                        child: Text(
                          'More locations will be added soon...',
                          style: GoogleFonts.ptSans(
                              textStyle: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 15,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
