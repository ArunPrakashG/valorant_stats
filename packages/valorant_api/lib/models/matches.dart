// To parse this JSON data, do
//
//     final matches = matchesFromMap(jsonString);

import 'dart:convert';

import '../helpers.dart';

Matches matchesFromMap(String str) => Matches.fromMap(json.decode(str));

String matchesToMap(Matches data) => json.encode(data.toMap());

class Matches {
  Matches({
    this.status,
    this.puuid,
    this.data = const [],
  });

  final String? status;
  final String? puuid;
  final List<Match> data;

  factory Matches.fromMap(Map<String, dynamic> json) => Matches(
        status: json["status"],
        puuid: json["puuid"],
        data: List<Match>.from(json["data"].map((x) => Match.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "puuid": puuid,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Match {
  Match({
    this.metadata,
    this.players,
    this.teams,
    this.rounds = const [],
  });

  final Metadata? metadata;
  final Players? players;
  final Teams? teams;
  final List<Round> rounds;

  factory Match.fromMap(Map<String, dynamic> json) => Match(
        metadata: Metadata.fromMap(json["metadata"]),
        players: Players.fromMap(json["players"]),
        teams: Teams.fromMap(json["teams"]),
        rounds: List<Round>.from(json["rounds"].map((x) => Round.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "metadata": metadata?.toMap(),
        "players": players?.toMap(),
        "teams": teams?.toMap(),
        "rounds": List<dynamic>.from(rounds.map((x) => x.toMap())),
      };
}

class Metadata {
  Metadata({
    this.map,
    this.gameVersion,
    this.gameLength = 0,
    this.gameStart = 0,
    this.gameStartPatched,
    this.roundsPlayed = 0,
    this.mode,
    this.seasonId,
    this.platform,
    this.matchid,
  });

  final String? map;
  final String? gameVersion;
  final int gameLength;
  final int gameStart;
  final String? gameStartPatched;
  final int roundsPlayed;
  final String? mode;
  final String? seasonId;
  final String? platform;
  final String? matchid;

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata(
        map: json["map"],
        gameVersion: json["game_version"],
        gameLength: json["game_length"] ?? 0,
        gameStart: json["game_start"] ?? 0,
        gameStartPatched: json["game_start_patched"],
        roundsPlayed: json["rounds_played"] ?? 0,
        mode: json["mode"],
        seasonId: json["season_id"],
        platform: json["platform"],
        matchid: json["matchid"],
      );

  Map<String, dynamic> toMap() => {
        "map": map,
        "game_version": gameVersion,
        "game_length": gameLength,
        "game_start": gameStart,
        "game_start_patched": gameStartPatched,
        "rounds_played": roundsPlayed,
        "mode": mode,
        "season_id": seasonId,
        "platform": platform,
        "matchid": matchid,
      };
}

class Players {
  Players({
    this.allPlayers,
    this.red,
    this.blue,
  });

  final List<Player>? allPlayers;
  final List<Player>? red;
  final List<Player>? blue;

  factory Players.fromMap(Map<String, dynamic> json) => Players(
        allPlayers: json["all_players"] == null ? null : List<Player>.from(json["all_players"].map((x) => Player.fromMap(x))),
        red: json["red"] == null ? null : List<Player>.from(json["red"].map((x) => Player.fromMap(x))),
        blue: json["blue"] == null ? null : List<Player>.from(json["blue"].map((x) => Player.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "all_players": allPlayers == null ? [] : List<dynamic>.from(allPlayers!.map((x) => x.toMap())),
        "red": red == null ? [] : List<dynamic>.from(red!.map((x) => x.toMap())),
        "blue": blue == null ? [] : List<dynamic>.from(blue!.map((x) => x.toMap())),
      };
}

class Player {
  Player({
    this.puuid,
    this.name,
    this.tag,
    this.team,
    this.character,
    this.currenttier = 0,
    this.currenttierPatched,
    this.playerCard,
    this.playerTitle,
    this.stats,
    this.abilityCasts,
    this.damageMade = 0,
    this.damageReceived = 0,
  });

  final String? puuid;
  final String? name;
  final String? tag;
  final String? team;
  final String? character;
  final int currenttier;
  final String? currenttierPatched;
  final String? playerCard;
  final String? playerTitle;
  final Stats? stats;
  final AbilityCasts? abilityCasts;
  final int damageMade;
  final int damageReceived;

  factory Player.fromMap(Map<String, dynamic> json) => Player(
        puuid: json["puuid"],
        name: json["name"],
        tag: json["tag"],
        team: json["team"],
        character: json["character"],
        currenttier: json["currenttier"] ?? 0,
        currenttierPatched: json["currenttier_patched"],
        playerCard: json["player_card"],
        playerTitle: json["player_title"],
        stats: Stats.fromMap(json["stats"]),
        abilityCasts: AbilityCasts.fromMap(json["ability_casts"]),
        damageMade: json["damage_made"] ?? 0,
        damageReceived: json["damage_received"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "puuid": puuid,
        "name": name,
        "tag": tag,
        "team": team,
        "character": character,
        "currenttier": currenttier,
        "currenttier_patched": currenttierPatched,
        "player_card": playerCard,
        "player_title": playerTitle,
        "stats": stats?.toMap(),
        "ability_casts": abilityCasts?.toMap(),
        "damage_made": damageMade,
        "damage_received": damageReceived,
      };
}

class AbilityCasts {
  AbilityCasts({
    this.cCast = 0,
    this.qCast = 0,
    this.eCast = 0,
    this.xCast = 0,
    this.yCast = 0,
  });

  final int cCast;
  final int qCast;
  final int eCast;
  final int xCast;
  final int yCast;

  factory AbilityCasts.fromMap(Map<String, dynamic> json) => AbilityCasts(
        cCast: isNullOrOfType<String>(json["c_cast"]) ? 0 : json["c_cast"],
        qCast: isNullOrOfType<String>(json["q_cast"]) ? 0 : json["q_cast"],
        eCast: isNullOrOfType<String>(json["e_cast"]) ? 0 : json["e_cast"],
        xCast: isNullOrOfType<String>(json["x_cast"]) ? 0 : json["x_cast"],
        yCast: isNullOrOfType<String>(json["y_cast"]) ? 0 : json["y_cast"],
      );

  Map<String, dynamic> toMap() => {
        "c_cast": cCast,
        "q_cast": qCast,
        "e_cast": eCast,
        "x_cast": xCast,
        "y_cast": yCast,
      };
}

class Stats {
  Stats({
    this.score = 0,
    this.kills = 0,
    this.deaths = 0,
    this.assists = 0,
  });

  final int score;
  final int kills;
  final int deaths;
  final int assists;

  factory Stats.fromMap(Map<String, dynamic> json) => Stats(
        score: json["score"] ?? 0,
        kills: json["kills"] ?? 0,
        deaths: json["deaths"] ?? 0,
        assists: json["assists"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "score": score,
        "kills": kills,
        "deaths": deaths,
        "assists": assists,
      };
}

class Round {
  Round({
    this.winningTeam,
    this.endType,
    this.bombPlanted = false,
    this.bombDefused = false,
    this.plantEvents,
    this.defuseEvents,
    this.playerStats,
  });

  final String? winningTeam;
  final String? endType;
  final bool bombPlanted;
  final bool bombDefused;
  final PlantEvents? plantEvents;
  final DefuseEvents? defuseEvents;
  final List<PlayerStat>? playerStats;

  factory Round.fromMap(Map<String, dynamic> json) => Round(
        winningTeam: json["winning_team"],
        endType: json["end_type"],
        bombPlanted: json["bomb_planted"] ?? false,
        bombDefused: json["bomb_defused"] ?? false,
        plantEvents: PlantEvents.fromMap(json["plant_events"]),
        defuseEvents: DefuseEvents.fromMap(json["defuse_events"]),
        playerStats: List<PlayerStat>.from(json["player_stats"].map((x) => PlayerStat.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "winning_team": winningTeam,
        "end_type": endType,
        "bomb_planted": bombPlanted,
        "bomb_defused": bombDefused,
        "plant_events": plantEvents?.toMap(),
        "defuse_events": defuseEvents?.toMap(),
        "player_stats": playerStats == null ? [] : List<dynamic>.from(playerStats!.map((x) => x.toMap())),
      };
}

class DefuseEvents {
  DefuseEvents({
    this.defusedBy,
    this.defuseLocation,
    this.defuseTimeInRound = 0,
    this.playerLocationsOnDefuse,
  });

  final EventSource? defusedBy;
  final Coordinate? defuseLocation;
  final int defuseTimeInRound;
  final List<PlayerLocationsOn>? playerLocationsOnDefuse;

  factory DefuseEvents.fromMap(Map<String, dynamic> json) => DefuseEvents(
        defusedBy: json["defused_by"] == null ? null : EventSource.fromMap(json["defused_by"]),
        defuseLocation: json["defuse_location"] == null ? null : Coordinate.fromMap(json["defuse_location"]),
        defuseTimeInRound: json["defuse_time_in_round"] ?? 0,
        playerLocationsOnDefuse: List<PlayerLocationsOn>.from(json["player_locations_on_defuse"].map((x) => PlayerLocationsOn.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "defused_by": defusedBy == null ? null : defusedBy!.toMap(),
        "defuse_location": defuseLocation == null ? null : defuseLocation!.toMap(),
        "defuse_time_in_round": defuseTimeInRound,
        "player_locations_on_defuse": playerLocationsOnDefuse == null ? [] : List<dynamic>.from(playerLocationsOnDefuse!.map((x) => x.toMap())),
      };
}

class Coordinate {
  Coordinate({
    this.x = 0,
    this.y = 0,
  });

  final int x;
  final int y;

  factory Coordinate.fromMap(Map<String, dynamic> json) => Coordinate(
        x: json["x"] ?? 0,
        y: json["y"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "x": x,
        "y": y,
      };
}

class EventSource {
  EventSource({
    this.displayName,
    this.team,
  });

  final String? displayName;
  final String? team;

  factory EventSource.fromMap(Map<String, dynamic> json) => EventSource(
        displayName: json["display_name"],
        team: json["team"],
      );

  Map<String, dynamic> toMap() => {
        "display_name": displayName,
        "team": team,
      };
}

class PlayerLocationsOn {
  PlayerLocationsOn({
    this.location,
    this.playerPuuid,
    this.playerDisplayName,
    this.playerTeam,
  });

  final Coordinate? location;
  final String? playerPuuid;
  final String? playerDisplayName;
  final String? playerTeam;

  factory PlayerLocationsOn.fromMap(Map<String, dynamic> json) => PlayerLocationsOn(
        location: Coordinate.fromMap(json["location"]),
        playerPuuid: json["player_puuid"],
        playerDisplayName: json["player_display_name"],
        playerTeam: json["player_team"],
      );

  Map<String, dynamic> toMap() => {
        "location": location?.toMap(),
        "player_puuid": playerPuuid,
        "player_display_name": playerDisplayName,
        "player_team": playerTeam,
      };
}

class PlantEvents {
  PlantEvents({
    this.plantLocation,
    this.plantedBy,
    this.plantSide,
    this.plantTimeInRound = 0,
    this.playerLocationsOnPlant = const [],
  });

  final Coordinate? plantLocation;
  final EventSource? plantedBy;
  final String? plantSide;
  final int plantTimeInRound;
  final List<PlayerLocationsOn> playerLocationsOnPlant;

  factory PlantEvents.fromMap(Map<String, dynamic> json) => PlantEvents(
        plantLocation: json["plant_location"] == null ? null : Coordinate.fromMap(json["plant_location"]),
        plantedBy: json["planted_by"] == null ? null : EventSource.fromMap(json["planted_by"]),
        plantSide: json["plant_side"] == null ? null : json["plant_side"],
        plantTimeInRound: json["plant_time_in_round"] ?? 0,
        playerLocationsOnPlant: List<PlayerLocationsOn>.from(json["player_locations_on_plant"].map((x) => PlayerLocationsOn.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "plant_location": plantLocation == null ? null : plantLocation?.toMap(),
        "planted_by": plantedBy == null ? null : plantedBy?.toMap(),
        "plant_side": plantSide == null ? null : plantSide,
        "plant_time_in_round": plantTimeInRound,
        "player_locations_on_plant": List<dynamic>.from(playerLocationsOnPlant.map((x) => x.toMap())),
      };
}

class PlayerStat {
  PlayerStat({
    this.abilityCasts,
    this.playerPuuid,
    this.playerDisplayName,
    this.playerTeam,
    this.damageEvents = const [],
    this.damage = 0,
    this.bodyshots = 0,
    this.headshots = 0,
    this.legshots = 0,
    this.killEvents = const [],
    this.kills = 0,
  });

  final AbilityCasts? abilityCasts;
  final String? playerPuuid;
  final String? playerDisplayName;
  final String? playerTeam;
  final List<DamageEvent> damageEvents;
  final int damage;
  final int bodyshots;
  final int headshots;
  final int legshots;
  final List<KillEvent> killEvents;
  final int kills;

  factory PlayerStat.fromMap(Map<String, dynamic> json) => PlayerStat(
        abilityCasts: AbilityCasts.fromMap(json["ability_casts"]),
        playerPuuid: json["player_puuid"],
        playerDisplayName: json["player_display_name"],
        playerTeam: json["player_team"],
        damageEvents: List<DamageEvent>.from(json["damage_events"].map((x) => DamageEvent.fromMap(x))),
        damage: json["damage"] ?? 0,
        bodyshots: json["bodyshots"] ?? 0,
        headshots: json["headshots"] ?? 0,
        legshots: json["legshots"] ?? 0,
        killEvents: List<KillEvent>.from(json["kill_events"].map((x) => KillEvent.fromMap(x))),
        kills: json["kills"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "ability_casts": abilityCasts?.toMap(),
        "player_puuid": playerPuuid,
        "player_display_name": playerDisplayName,
        "player_team": playerTeam,
        "damage_events": List<dynamic>.from(damageEvents.map((x) => x.toMap())),
        "damage": damage,
        "bodyshots": bodyshots,
        "headshots": headshots,
        "legshots": legshots,
        "kill_events": List<dynamic>.from(killEvents.map((x) => x.toMap())),
        "kills": kills,
      };
}

class DamageEvent {
  DamageEvent({
    this.receiverPuuid,
    this.receiverDisplayName,
    this.receiverTeam,
    this.bodyshots = 0,
    this.damage = 0,
    this.headshots = 0,
    this.legshots = 0,
  });

  final String? receiverPuuid;
  final String? receiverDisplayName;
  final String? receiverTeam;
  final int bodyshots;
  final int damage;
  final int headshots;
  final int legshots;

  factory DamageEvent.fromMap(Map<String, dynamic> json) => DamageEvent(
        receiverPuuid: json["receiver_puuid"],
        receiverDisplayName: json["receiver_display_name"],
        receiverTeam: json["receiver_team"],
        bodyshots: json["bodyshots"] ?? 0,
        damage: json["damage"] ?? 0,
        headshots: json["headshots"] ?? 0,
        legshots: json["legshots"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "receiver_puuid": receiverPuuid,
        "receiver_display_name": receiverDisplayName,
        "receiver_team": receiverTeam,
        "bodyshots": bodyshots,
        "damage": damage,
        "headshots": headshots,
        "legshots": legshots,
      };
}

class KillEvent {
  KillEvent({
    this.killTimeInRound = 0,
    this.killTimeInMatch = 0,
    this.killerPuuid,
    this.killerDisplayName,
    this.killerTeam,
    this.victimPuuid,
    this.victimDisplayName,
    this.victimTeam,
    this.victimDeathLocation,
    this.damageWeaponId,
    this.secondaryFireMode = false,
    this.playerLocationsOnKill = const [],
    this.assistants = const [],
  });

  final int killTimeInRound;
  final int killTimeInMatch;
  final String? killerPuuid;
  final String? killerDisplayName;
  final String? killerTeam;
  final String? victimPuuid;
  final String? victimDisplayName;
  final String? victimTeam;
  final Coordinate? victimDeathLocation;
  final String? damageWeaponId;
  final bool secondaryFireMode;
  final List<PlayerLocationsOn> playerLocationsOnKill;
  final List<Assistant> assistants;

  factory KillEvent.fromMap(Map<String, dynamic> json) => KillEvent(
        killTimeInRound: json["kill_time_in_round"] ?? 0,
        killTimeInMatch: json["kill_time_in_match"] ?? 0,
        killerPuuid: json["killer_puuid"],
        killerDisplayName: json["killer_display_name"],
        killerTeam: json["killer_team"],
        victimPuuid: json["victim_puuid"],
        victimDisplayName: json["victim_display_name"],
        victimTeam: json["victim_team"],
        victimDeathLocation: Coordinate.fromMap(json["victim_death_location"]),
        damageWeaponId: json["damage_weapon_id"],
        secondaryFireMode: json["secondary_fire_mode"] ?? false,
        playerLocationsOnKill: List<PlayerLocationsOn>.from(json["player_locations_on_kill"].map((x) => PlayerLocationsOn.fromMap(x))),
        assistants: List<Assistant>.from(json["assistants"].map((x) => Assistant.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "kill_time_in_round": killTimeInRound,
        "kill_time_in_match": killTimeInMatch,
        "killer_puuid": killerPuuid,
        "killer_display_name": killerDisplayName,
        "killer_team": killerTeam,
        "victim_puuid": victimPuuid,
        "victim_display_name": victimDisplayName,
        "victim_team": victimTeam,
        "victim_death_location": victimDeathLocation?.toMap(),
        "damage_weapon_id": damageWeaponId,
        "secondary_fire_mode": secondaryFireMode,
        "player_locations_on_kill": List<dynamic>.from(playerLocationsOnKill.map((x) => x.toMap())),
        "assistants": List<dynamic>.from(assistants.map((x) => x.toMap())),
      };
}

class Assistant {
  Assistant({
    this.assistantPuuid,
    this.assistantDisplayName,
    this.assistantTeam,
  });

  final String? assistantPuuid;
  final String? assistantDisplayName;
  final String? assistantTeam;

  factory Assistant.fromMap(Map<String, dynamic> json) => Assistant(
        assistantPuuid: json["assistant_puuid"],
        assistantDisplayName: json["assistant_display_name"],
        assistantTeam: json["assistant_team"],
      );

  Map<String, dynamic> toMap() => {
        "assistant_puuid": assistantPuuid,
        "assistant_display_name": assistantDisplayName,
        "assistant_team": assistantTeam,
      };
}

class Teams {
  Teams({
    this.red,
    this.blue,
  });

  final TeamContained? red;
  final TeamContained? blue;

  factory Teams.fromMap(Map<String, dynamic> json) => Teams(
        red: json["red"] == null ? null : TeamContained.fromMap(json["red"]),
        blue: json["blue"] == null ? null : TeamContained.fromMap(json["blue"]),
      );

  Map<String, dynamic> toMap() => {
        "red": red == null ? null : red?.toMap(),
        "blue": blue == null ? null : blue?.toMap(),
      };
}

class TeamContained {
  TeamContained({
    this.hasWon = false,
    this.roundsWon = 0,
    this.roundsLost = 0,
  });

  final bool hasWon;
  final int roundsWon;
  final int roundsLost;

  factory TeamContained.fromMap(Map<String, dynamic> json) => TeamContained(
        hasWon: json["has_won"] ?? false,
        roundsWon: json["rounds_won"] ?? 0,
        roundsLost: json["rounds_lost"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "has_won": hasWon,
        "rounds_won": roundsWon,
        "rounds_lost": roundsLost,
      };
}
