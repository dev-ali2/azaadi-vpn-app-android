import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:azaadi_vpn_android/helpers/byte_to_speed.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocationsPage extends StatelessWidget {
  LocationsPage({super.key});
  final List<Vpn> servers = HiveController.getVpnList;

  final connectionController = Get.find<ConnectionController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Available Locations (${servers.length})',
            style: GoogleFonts.ptSans(
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
          ),
        ),
        body: servers.length <= 0
            ? Center(
                child: Text('No Available servers'),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: SizedBox(
                  height: size.height,
                  child: GridView.builder(
                    itemCount: servers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4 / (size.height * 0.006).toInt(),
                        crossAxisSpacing: size.width * 0.06,
                        mainAxisSpacing: size.height * 0.05),
                    itemBuilder: (context, index) => Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.1),
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.1)
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.01),
                                  child: Text(
                                    'Country',
                                    style: GoogleFonts.ptSans(
                                        textStyle: TextStyle(
                                      fontSize: 13,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.01,
                                      vertical: size.height * 0.01),
                                  child: SizedBox(
                                    width: size.width * 0.2,
                                    child: Text(
                                      softWrap: true,
                                      servers[index].countryLong.toUpperCase(),
                                      style: GoogleFonts.ptSans(
                                          textStyle: TextStyle(
                                              overflow: TextOverflow.fade,
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.01),
                                  child: Text(
                                    'Symbol',
                                    style: GoogleFonts.ptSans(
                                        textStyle: TextStyle(
                                      fontSize: 13,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.01),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: Image.asset(
                                      'assets/flags/${servers[index].countryShort.toLowerCase()}.png',
                                      fit: BoxFit.cover,
                                      height: size.width * 0.05,
                                      width: size.width * 0.07,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.01),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Speed ',
                                        style: GoogleFonts.ptSans(
                                            textStyle: TextStyle(
                                          fontSize: 13,
                                        )),
                                      ),
                                      Icon(
                                        Icons.speed,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 17,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.01),
                                  child: Text(
                                    ByteToSpeedConversion.formatBytes(
                                        servers[index].speed, 0),
                                    style: GoogleFonts.ptSans(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.01),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Connections ',
                                        style: GoogleFonts.ptSans(
                                            textStyle: TextStyle(
                                          fontSize: 13,
                                        )),
                                      ),
                                      Icon(
                                        Icons.people,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 17,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.03,
                                      vertical: size.height * 0.01),
                                  child: Text(
                                    servers[index].numVpnSessions.toString(),
                                    style: GoogleFonts.ptSans(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  connectionController
                                      .manualConnection(servers[index]);
                                },
                                child: Text('Connect'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
