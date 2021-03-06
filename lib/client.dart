import 'package:flutter/widgets.dart';
import 'package:valorant_api/valorant_client.dart';

class Client extends InheritedWidget {
  Client(this.client, Widget child, {Key? key}) : super(key: key, child: child);

  static Client? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Client>();

  final ValorantClient? client;

  @override
  bool updateShouldNotify(covariant Client oldWidget) => true;
}
