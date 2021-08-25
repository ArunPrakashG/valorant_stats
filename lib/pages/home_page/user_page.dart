import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';
import '../../services/api/api_enums.dart';
import '../../services/api/models/user.dart';
import '../../services/api/valorant_client.dart';
import '../../valorant_stats_app.dart';
import '../add_user_page/add_user_page.dart';

class UserInfo {
  String? name;
  String? tag;

  UserInfo({this.name, this.tag});
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  Future<User?> _initialProcess(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user_info')) {
      String? userInfo = prefs.getString('user_info');

      if (isNullOrEmpty(userInfo)) {
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUserPage(), fullscreenDialog: true));
      }

      final split = userInfo!.split('#');
      ValorantStatsApp.client ??= ValorantClient(split[0], split[1]);
      await ValorantStatsApp.client!.initClient();
      return ValorantStatsApp.client!.user;
    }

    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUserPage(), fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: FutureBuilder<User?>(
        future: _initialProcess(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }

          if (snapshot.data?.name == null || snapshot.data?.tag == null) {
            return Text('ERROR');
          }

          return Column(
            children: [
              Text(snapshot.data!.region.regionName),
              Text(snapshot.data!.accountLevel.toString()),
            ],
          );
        },
      ),
    );
  }
}
