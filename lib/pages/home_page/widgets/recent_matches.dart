import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:valorant_api/models/matches.dart';
import 'package:valorant_stats/helpers.dart';
import 'package:valorant_stats/pages/home_page/widgets/pie_chart.dart';

import '../../../valorant_stats_app.dart';

class RecentMatchesWidget extends StatelessWidget {
  RecentMatchesWidget({Key? key}) : super(key: key);

  static Matches? _matches;

  Future<Matches?> _getRecentMatchesData(BuildContext context) async {
    if (_matches != null && _matches!.data.isNotEmpty) {
      return _matches;
    }

    _matches ??= await ValorantStatsApp.client!.getMatchHistory();
    return _matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Matches?>(
      future: _getRecentMatchesData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // TODO: Loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          // TODO: Error Indicator
          return Text('error');
        }

        //var timeStamp = DateTime.fromMicrosecondsSinceEpoch(2580111);
        //print(DateTime(1970, 1, 1).difference(timeStamp).inHours);

        final currentPlayer = snapshot.data?.data[0].players?.allPlayers?.singleWhere((element) => element.name == ValorantStatsApp.client!.user!.name);

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: Card(
            elevation: 8,
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
                            (snapshot.data?.data[0].metadata?.mode)?.toUpperCase() ?? '~',
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            humanizeDateTime(convertTimeStampToDateTime(snapshot.data!.data[0].metadata!.gameStart)),
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
                            (snapshot.data?.data[0].metadata?.map)?.toUpperCase() ?? '~',
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${snapshot.data?.data[0].metadata?.roundsPlayed} Rounds',
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PieChartWidget(
                    sectionData: [
                      MapEntry('Kills', double.parse(currentPlayer?.stats?.kills.toString() ?? '0.0')),
                      MapEntry('Deaths', double.parse(currentPlayer?.stats?.deaths.toString() ?? '0.0')),
                      MapEntry('Assists', double.parse(currentPlayer?.stats?.assists.toString() ?? '0.0')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
