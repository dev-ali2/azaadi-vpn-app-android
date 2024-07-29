import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TempServersPage extends StatefulWidget {
  const TempServersPage({super.key});

  @override
  State<TempServersPage> createState() => _TempServersPageState();
}

class _TempServersPageState extends State<TempServersPage> {
  final client = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder(
          future: client.from('vpns_table').select(),
          builder: (context, s) {
            if (s.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Text('Length of data got ${s.data!.length}'),
                Text('country long ${s.data![2]['countryLong']}')
              ],
            );
          },
        ),
      ),
    );
  }
}
