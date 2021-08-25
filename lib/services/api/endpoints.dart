import '../../helpers.dart';

class Endpoints {
  // https://github.com/Henrik-3/unofficial-valorant-api
  static const String _baseUrl = 'https://api.henrikdev.xyz';

  final String? _name;
  final String? _tag;

  Endpoints(this._name, this._tag);

  Uri? liveMatchEndpoint() {
    if (isNullOrEmpty(_name) || isNullOrEmpty(_tag)) {
      return null;
    }

    return Uri.tryParse('$_baseUrl/valorant/v1/live-match/$_name/$_tag');
  }

  Uri? matchWithMatchIdEndpoint(String? matchId) {
    if (isNullOrEmpty(matchId)) {
      return null;
    }

    return Uri.tryParse('$_baseUrl/valorant/v2/match/$matchId');
  }

  Uri? matchHistoryEndpoint(String? region) {
    if (isNullOrEmpty(_name) || isNullOrEmpty(_tag) || isNullOrEmpty(region)) {
      return null;
    }

    return Uri.tryParse('$_baseUrl/valorant/v3/matches/$region/$_name/$_tag');
  }

  Uri? accountEndpoint() {
    if (isNullOrEmpty(_name) || isNullOrEmpty(_tag)) {
      return null;
    }

    return Uri.tryParse('$_baseUrl/valorant/v1/account/$_name/$_tag');
  }

  Uri? currentMMREndpoint(String? puuid, String? region) {
    if (isNullOrEmpty(puuid) || isNullOrEmpty(region)) {
      return null;
    }

    return Uri.tryParse('$_baseUrl/valorant/v1/by-puuid/mmr/$region/$puuid');
  }

  Uri? mmrHistoryByPuuidEndpoint(String? puuid, String? region) {
    if (isNullOrEmpty(puuid) || isNullOrEmpty(region)) {
      return null;
    }

    return Uri.tryParse('$_baseUrl/valorant/v1/by-puuid/mmr-history/$region/$puuid');
  }
}
