import 'dart:convert';

import 'package:http/http.dart' as httpClient;
import 'package:valorant_api/models/matches.dart';

import '../../helpers.dart';
import 'api_enums.dart';
import 'endpoints.dart';
import 'models/current_mmr.dart';
import 'models/mm_history.dart';
import 'models/user.dart';

class ValorantClient {
  final String name;
  final String tag;

  Endpoints? _endpoints;
  User? user;
  DateTime? _lastRequestTime;
  int? _requestCount;

  // RATE LIMIT: 250 request / 2.5 minutes

  bool get _isRateLimited => _lastRequestTime != null && DateTime.now().difference(_lastRequestTime!).inSeconds >= 140;

  bool get _hasInitProperly => _endpoints != null && !isNullOrEmpty(name) && !isNullOrEmpty(tag) && user != null && user!.isValid;

  ValorantClient(this.name, this.tag) {
    _endpoints = Endpoints(name, tag);
  }

  bool _canRequest() {
    if (_requestCount == null) {
      return true;
    }

    return !_isRateLimited || _requestCount! < 250;
  }

  Future<bool> initClient() async {
    if (isNullOrEmpty(name) || isNullOrEmpty(tag)) {
      return false;
    }

    if (_hasInitProperly) {
      return true;
    }

    final requestUrl = _endpoints?.accountEndpoint();

    if (requestUrl == null) {
      return false;
    }

    final response = await httpClient.get(requestUrl);

    print('requesting user data');

    if (response.statusCode != 200) {
      return false;
    }

    final json = jsonDecode(response.body);

    if (json == null || int.tryParse(json['status'] as String) != 200) {
      return false;
    }

    final region = getRegionFromString(json['data']['region'] as String);
    final level = json['data']['account_level'];

    if (region == null || level == null) {
      return false;
    }

    user = User(name, tag, region, (json['data']['puuid'] as String), level);
    return true;
  }

  Future<List<MMRHistoryItem>?> getMMRHistory() async {
    if (!_hasInitProperly || !_canRequest()) {
      return null;
    }

    final requestUri = _endpoints!.mmrHistoryByPuuidEndpoint(user?.puuid, user?.region.regionName);

    if (requestUri == null) {
      return null;
    }

    final respones = await httpClient.get(requestUri);

    _requestCount ??= 0;
    _requestCount = _requestCount! + 1;

    if (respones.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(respones.body);

    if (json == null || int.tryParse(json['status'] as String) != 200) {
      return null;
    }

    final historyItems = <MMRHistoryItem>[];

    for (final item in json['data'] as Iterable<dynamic>) {
      historyItems.add(
        MMRHistoryItem(
          item['currenttier'] ?? 0,
          item['currenttierpatched'] as String,
          item['ranking_in_tier'] ?? 0,
          item['mmr_change_to_last_game'] ?? 0,
          item['elo'] ?? 0,
          item['date_raw'] ?? 0,
        ),
      );
    }

    return historyItems;
  }

  Future<Matches?> getMatchHistory() async {
    if (!_hasInitProperly) {
      return null;
    }

    final requestUri = _endpoints!.matchHistoryEndpoint(user?.region.regionName);
    if (requestUri == null) {
      return null;
    }

    final respones = await httpClient.get(requestUri);
    _requestCount ??= 0;
    _requestCount = _requestCount! + 1;
    if (respones.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(respones.body);
    return Matches.fromMap(json);
  }

  Future<MMR?> getCurrentMMR() async {
    if (!_hasInitProperly) {
      return null;
    }

    final requestUri = _endpoints!.currentMMREndpoint(user?.puuid, user?.region.regionName);

    if (requestUri == null) {
      return null;
    }

    final respones = await httpClient.get(requestUri);

    _requestCount ??= 0;
    _requestCount = _requestCount! + 1;

    if (respones.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(respones.body);

    if (json == null || int.tryParse(json['status'] as String) != 200) {
      return null;
    }

    return MMR(
      json['data']['currenttier'] ?? 0,
      json['data']['currenttierpatched'] as String,
      json['data']['elo'] ?? 0,
      json['data']['mmr_change_to_last_game'] ?? 0,
      json['data']['ranking_in_tier'] ?? 0,
    );
  }
}
