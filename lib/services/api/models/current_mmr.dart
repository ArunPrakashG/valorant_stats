class MMR {
  final int currentTierId;
  final String currentTierName;
  final int rankingInTier;
  final int mmrChangeToLastGame;
  final int elo;

  MMR(this.currentTierId, this.currentTierName, this.elo, this.mmrChangeToLastGame, this.rankingInTier);
}
