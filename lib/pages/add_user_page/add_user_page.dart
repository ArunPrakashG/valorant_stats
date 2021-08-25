import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  Future<void> _onAddPressed(BuildContext context, String? userName, String? tag) async {
    if (isNullOrEmpty(userName) || isNullOrEmpty(tag)) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.setString('user_info', '$userName#$tag')) {
      return Navigator.of(context).pop<void>();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController tagController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('ADD PLAYER'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: userNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'In-game Name'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: tagController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Tag'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed: () async => _onAddPressed(context, userNameController.text, tagController.text),
                      icon: Icon(Icons.done),
                      label: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
