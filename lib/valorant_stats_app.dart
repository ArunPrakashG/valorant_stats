import 'package:flutter/material.dart';

import 'pages/home_page/user_page.dart';

class ValorantStatsApp extends StatelessWidget {
  const ValorantStatsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valorant Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        top: false,
        child: const UserPage(),
      ),
    );
  }
}
