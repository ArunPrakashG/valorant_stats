import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant_api/valorant_client.dart';

import '../../helpers.dart';
import '../../valorant_stats_app.dart';
import '../add_user_page/add_user_page.dart';
import 'widgets/user_banner.dart';

class UserInfo {
  String? name;
  String? tag;

  UserInfo({this.name, this.tag});
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  Future<bool> _init(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_info')) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUserPage(), fullscreenDialog: true));
      return false;
    }

    String? userInfo = prefs.getString('user_info');

    if (isNullOrEmpty(userInfo)) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUserPage(), fullscreenDialog: true));
      return false;
    }

    final split = userInfo!.split('#');
    ValorantStatsApp.client ??= ValorantClient(split[0], split[1]);
    return ValorantStatsApp.client!.initClient();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // TODO: Handle loading
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 3,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /*
        if (snapshot.hasError) {
          // TODO: Handle error (possibly network issue or API down)
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 3,
              title: Text(
                'Valorant Stats',
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Center(
              child: Text('An error occured!'),
            ),
          );
        }
*/
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            title: Text(
              'Valorant Stats',
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: UserBannerWidget(),
          ),
        );
      },
    );
  }
}
