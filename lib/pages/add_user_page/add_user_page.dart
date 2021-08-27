import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';
import '../home_page/user_page.dart';

class AddUserPage extends StatefulWidget {
  AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  late TextEditingController userNameController;
  late TextEditingController tagController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    tagController = TextEditingController();
  }

  Future<void> _onAddPressed(BuildContext context, String? userName, String? tag) async {
    if (isNullOrEmpty(userName) || isNullOrEmpty(tag)) {
      await Fluttertoast.showToast(
        msg: 'Either IGN or tag is empty.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    userName = userName?.trim();
    tag = tag?.trim();

    if (await prefs.setString('user_info', '$userName#$tag')) {
      await Fluttertoast.showToast(
        msg: 'Your username is saved in your device. You dont need to type it again.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );

      await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.all(10),
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text(
                    'Valorant Stats',
                    style: GoogleFonts.ubuntu(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  color: Colors.black,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Roti',
                      labelText: 'In game name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: tagController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Tag',
                      hintText: 'man',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () async => _onAddPressed(context, userNameController.text, tagController.text),
                    icon: Icon(Icons.done),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    label: Text(
                      'View Stats',
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
