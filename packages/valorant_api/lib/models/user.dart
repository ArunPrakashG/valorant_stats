import '../api_enums.dart';
import '../helpers.dart';

class User {
  final String name;
  final String tag;
  final Region region;
  final String puuid;
  final int accountLevel;

  bool get isValid => !isNullOrEmpty(name) && !isNullOrEmpty(tag) && !isNullOrEmpty(region.regionName) && !isNullOrEmpty(puuid) && accountLevel >= 0;

  User(this.name, this.tag, this.region, this.puuid, this.accountLevel);
}
