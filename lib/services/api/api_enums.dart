import '../../helpers.dart';

enum Region { EU, NA, AP, KR }

enum Ranks {
  Unranked,
  Iron1,
  Iron2,
  Iron3,
  Bronze1,
  Bronze2,
  Bronze3,
  Silver1,
  Silver2,
  Silver3,
  Gold1,
  Gold2,
  Gold3,
  Platinum1,
  Platinum2,
  Platinum3,
  Diamond1,
  Diamond2,
  Diamond3,
  Immortal,
  Radiant,
}

enum RankEventTypes {
  Stable,
  Promoted,
  Demoted,
  MajorIncreement,
  MinorIncreement,
  MajorDecreement,
  MediumDecreement,
  MinorDecreement,
}

extension RankEventTypeExtension on RankEventTypes {
  Uri getIconUri() {
    switch (this) {
      case RankEventTypes.Stable:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_Stable.png');
      case RankEventTypes.Promoted:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_Promoted.png');
      case RankEventTypes.Demoted:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_Demoted.png');
      case RankEventTypes.MajorIncreement:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_MajorIncrease.png');
      case RankEventTypes.MinorIncreement:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_MinorIncrease.png');
      case RankEventTypes.MajorDecreement:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_MajorDecrease.png');
      case RankEventTypes.MinorDecreement:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_MinorDecrease.png');
      case RankEventTypes.MediumDecreement:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTierMovement_MediumDecrease.png');
    }
  }
}

extension RanksExtension on Ranks {
  String? humanizedRank() {
    var raw = this.toString().split('.').last;
    String? numberOnly = raw.replaceAll(RegExp('[^0-9]'), '');
    String? replaced = raw.replaceAll(numberOnly, '');
    return !isNullOrEmpty(numberOnly) ? '$replaced $numberOnly' : replaced;
  }

  Uri getIconUri() {
    switch (this) {
      case Ranks.Unranked:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_0.png');
      case Ranks.Iron1:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_3.png');
      case Ranks.Iron2:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_4.png');
      case Ranks.Iron3:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_5.png');
      case Ranks.Bronze1:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_6.png');
      case Ranks.Bronze2:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_7.png');
      case Ranks.Bronze3:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_8.png');
      case Ranks.Silver1:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_9.png');
      case Ranks.Silver2:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_10.png');
      case Ranks.Silver3:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_11.png');
      case Ranks.Gold1:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_12.png');
      case Ranks.Gold2:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_13.png');
      case Ranks.Gold3:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_14.png');
      case Ranks.Platinum1:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_15.png');
      case Ranks.Platinum2:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_16.png');
      case Ranks.Platinum3:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_17.png');
      case Ranks.Diamond1:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_18.png');
      case Ranks.Diamond2:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_19.png');
      case Ranks.Diamond3:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_20.png');
      case Ranks.Immortal:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_23.png');
      case Ranks.Radiant:
        return Uri.parse('https://raw.githubusercontent.com/RumbleMike/ValorantStreamOverlay/main/Resources/TX_CompetitiveTier_Large_24.png');
    }
  }
}

Ranks? getRankWithTierId(int? tierId) {
  if (tierId == null) {
    return null;
  }

  return Ranks.values[tierId - 2];
}

extension RegionExtension on Region {
  String get regionName => this.toString().split('.').last.toLowerCase();

  String humanizeRegionName() {
    switch (this) {
      case Region.EU:
        return 'Europe';
      case Region.NA:
        return 'North America';
      case Region.AP:
        return 'Asia Pacific';
      case Region.KR:
        return 'Korea';
    }
  }
}

Region? getRegionFromString(String region) {
  if (isNullOrEmpty(region)) {
    return null;
  }

  return Region.values.where((element) => element.regionName == region.toLowerCase()).first;
}
