import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_background/animated_background.dart';

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:azaadi_vpn_android/controller/connection_controller.dart';
import 'package:azaadi_vpn_android/core/models/services/vpn_engine.dart';

class ConnectButtonContainer extends StatefulWidget {
  @override
  State<ConnectButtonContainer> createState() => _ConnectButtonContainerState();
}

class _ConnectButtonContainerState extends State<ConnectButtonContainer>
    with TickerProviderStateMixin {
  final connectionController = Get.put(ConnectionController());

  @override
  Widget build(BuildContext context) {
    connectionController.listenVpnState();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      child: Obx(
        () => AnimatedBackground(
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
            baseColor: Theme.of(context).colorScheme.onSecondary,
            particleCount: connectionController.showAnimation.value ? 100 : 0,
            maxOpacity: 1,
            minOpacity: 0.5,
            spawnMaxRadius: 10,
            spawnMinSpeed: 10,
            spawnMaxSpeed: 30,
          )),
          vsync: this,
          child: Column(
            children: [
              Container(
                height: size.height * 0.28,
                width: double.infinity,
                child: GestureDetector(
                  onTap: connectionController.connectVpn,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: (size.height * size.width * 0.00085),
                        width: (size.height * size.width * 0.00085),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: connectionController
                              .buttonColor(context)
                              .withOpacity(0),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: (size.height * size.width * 0.00070),
                        width: (size.height * size.width * 0.00070),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: connectionController.buttonColor(context),
                              width: 0.1),
                          shape: BoxShape.circle,
                          color: connectionController
                              .buttonColor(context)
                              .withOpacity(0.2),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: (size.height * size.width * 0.00055),
                        width: (size.height * size.width * 0.00055),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: connectionController.buttonColor(context),
                              width: 0.3),
                          shape: BoxShape.circle,
                          color: connectionController
                              .buttonColor(context)
                              .withOpacity(0.6),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: (size.height * size.width * 0.00040),
                        width: (size.height * size.width * 0.00040),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: connectionController.vpnState ==
                                        'Disconnected'
                                    ? Theme.of(context).colorScheme.primary
                                    : connectionController.buttonColor(context),
                                width: 0.5),
                            color: connectionController.buttonColor(context)),
                        child: Icon(
                          LucideIcons.power,
                          size: 45,
                          color: connectionController.vpnState == 'Almost done'
                              ? Colors.black
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.025),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 16),
                              children: [
                            TextSpan(text: 'Status: '),
                            TextSpan(
                                text: connectionController.vpnState.value ==
                                        VpnEngine.vpnDisconnected
                                    ? 'Disconnected'
                                    : connectionController.vpnState.value
                                        .replaceAll("_", " "),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold))
                          ])),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
