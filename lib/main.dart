import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:valorant_api/valorant_client.dart';
import 'package:valorant_stats/client.dart';
import 'package:valorant_stats/valorant_stats_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    Client(
      ValorantClient(),
      const ValorantStatsApp(),
    ),
  );
}
