class MMRHistoryItem {
  final int currentTierId;
  final String currentTierName;
  final int rankingInTier;
  final int mmrChangeToLastGame;
  final int elo;
  final int dateRaw;

  DateTime get date => DateTime.fromMicrosecondsSinceEpoch(dateRaw);

  MMRHistoryItem(this.currentTierId, this.currentTierName, this.dateRaw, this.elo, this.mmrChangeToLastGame, this.rankingInTier);
}
