import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_api/models/matches.dart';
import 'package:valorant_stats/client.dart';

import '../../../helpers.dart';
import 'pie_chart.dart';

class RecentMatchesWidget extends StatelessWidget {
  RecentMatchesWidget({Key? key}) : super(key: key);

  Future<Matches?> _getRecentMatchesData(BuildContext context) async {
    if (Client.of(context)?.matchesCache != null && Client.of(context)!.matchesCache!.data.isNotEmpty) {
      return Client.of(context)!.matchesCache;
    }

    Client.of(context)!.matchesCache = await Client.of(context)!.client!.getMatchHistory();
    return Client.of(context)!.matchesCache;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Matches?>(
      future: _getRecentMatchesData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error occured while fetching your recent matches data.'),
          );
        }

        //var timeStamp = DateTime.fromMicrosecondsSinceEpoch(2580111);
        //print(DateTime(1970, 1, 1).difference(timeStamp).inHours);

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              for (var i = 0; i < snapshot.data!.data.length; i++) generateStatsWidgetForIndex(context, i, snapshot.data),
            ],
          ),
        );
      },
    );
  }

  Widget generateStatsWidgetForIndex(BuildContext context, int index, Matches? data) {
    var match = data?.data[index];

    if (match == null) {
      return Card(
        elevation: 6,
        shadowColor: Colors.blue[100],
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text('Error occured!'),
        ),
      );
    }

    final currentPlayer = match.players?.allPlayers?.singleWhere((element) => element.name == Client.of(context)!.client!.user!.name);

    return Card(
      elevation: 6,
      shadowColor: Colors.blue[100],
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MODE',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      (match.metadata?.mode)?.toUpperCase() ?? '~',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      humanizeDateTime(convertTimeStampToDateTime(match.metadata!.gameStart)),
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'MAP',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      (match.metadata?.map)?.toUpperCase() ?? '~',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${match.metadata?.roundsPlayed} Rounds',
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      (currentPlayer?.character ?? '~').toUpperCase(),
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'KDA',
              style: GoogleFonts.notoSans(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            PieChartWidget(
              sectionData: [
                MapEntry('Kills', double.parse(currentPlayer?.stats?.kills.toString() ?? '0.0')),
                MapEntry('Deaths', double.parse(currentPlayer?.stats?.deaths.toString() ?? '0.0')),
                MapEntry('Assists', double.parse(currentPlayer?.stats?.assists.toString() ?? '0.0')),
              ],
            ),
            Text(
              'Ability Usage',
              style: GoogleFonts.notoSans(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            renderIfAllowed(match.metadata?.mode, currentPlayer),
          ],
        ),
      ),
    );
  }

  Widget renderIfAllowed(String? mode, Player? currentPlayer) {
    if (mode?.toLowerCase() == 'deathmatch') {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text('Abilties are not available in DM.'),
      );
    }

    return PieChartWidget(
      sectionData: [
        MapEntry('C Ability', double.parse(currentPlayer?.abilityCasts?.cCast.toString() ?? '0.0')),
        MapEntry('Q Ability', double.parse(currentPlayer?.abilityCasts?.qCast.toString() ?? '0.0')),
        MapEntry('E Ability', double.parse(currentPlayer?.abilityCasts?.eCast.toString() ?? '0.0')),
        MapEntry('Ultimate', double.parse(currentPlayer?.abilityCasts?.xCast.toString() ?? '0.0')),
      ],
    );
  }
}
