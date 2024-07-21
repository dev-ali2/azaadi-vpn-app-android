import 'dart:developer';

import 'package:get/get.dart';

import 'package:azaadi_vpn_android/controller/hive_controller.dart';
import 'package:azaadi_vpn_android/core/models/vpn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchController extends GetxController {
  static Future<List<Vpn>> getVPNServers() async {
    final List<Vpn> vpnList = [];
    log('Getting servers');

    try {
      final listFromStorage = await HiveController.getVpnList;
      if (listFromStorage.isNotEmpty) {
        log('Got list from storage');
        log('total enteries ${listFromStorage.length}');

        return listFromStorage;
      }
      log('no servers saved, going to Database');

      final res = await Supabase.instance.client.from('vpns_table').select();
      for (int i = 0; i < res.length; i++) {
        vpnList.add(Vpn.fromJson(res[i]));
      }
    } catch (e) {
      log('\ngetVPNServersE: $e');
    }

    log('Sorted all vpns total length now ${vpnList.length}');

    if (vpnList.isNotEmpty) HiveController.setVpnList = vpnList;
    log('vpn list is set up in storage');

    return vpnList;
  }
}
