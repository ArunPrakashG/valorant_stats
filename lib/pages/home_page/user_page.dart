import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorant_stats/client.dart';

import '../../helpers.dart';
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
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('user_info')) {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddUserPage()));
      return false;
    }

    String? userInfo = prefs.getString('user_info');

    if (isNullOrEmpty(userInfo)) {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddUserPage()));
      return false;
    }

    final split = userInfo!.split('#');
    Client.of(context)!.client!.name = split[0];
    Client.of(context)!.client!.tag = split[1];
    return await Client.of(context)!.client!.initClient(split[0], split[1]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
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

        if (!snapshot.data!) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 8,
              centerTitle: true,
              title: Text(
                'Valorant Stats',
                style: GoogleFonts.ubuntu(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const SizedBox.shrink(),
            ),
            body: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ERROR!',
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('If your are seeing this page, then that means an unknown error has occured.'),
                  Text('Check and verify you have stable network connectivity.'),
                  Text('If your network is stable, then it means API (https://api.henrikdev.xyz/) is down, possibly for maintance.'),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 8,
            centerTitle: true,
            title: Text(
              'Valorant Stats',
              style: GoogleFonts.ubuntu(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const SizedBox.shrink(),
            actions: [
              Tooltip(
                message: 'Remove this account',
                child: IconButton(
                  onPressed: () async => _onRemoveButtonPressed(context),
                  icon: Icon(
                    Icons.delete_outline_sharp,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: UserBannerWidget(),
          ),
        );
      },
    );
  }

  void _onRemoveButtonPressed(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Client.of(context)!.client!.name = '';
    Client.of(context)!.client!.tag = '';
    Client.of(context)!.client!.user = null;

    await Fluttertoast.showToast(
      msg: 'Your IGN and Tag has been successfully cleared!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16,
    );

    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddUserPage()));
  }
}
