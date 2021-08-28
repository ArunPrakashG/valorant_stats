import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:valorant_api/api_enums.dart';
import 'package:valorant_api/models/current_mmr.dart';
import 'package:valorant_stats/client.dart';
import 'named_chip.dart';
import 'recent_matches.dart';

class UserBannerWidget extends StatefulWidget {
  const UserBannerWidget({Key? key}) : super(key: key);

  @override
  _UserBannerWidgetState createState() => _UserBannerWidgetState();
}

class _UserBannerWidgetState extends State<UserBannerWidget> {
  Future<MMR?> _fetchMMR(BuildContext context) async {
    if (Client.of(context)!.mmrCache != null) {
      return Client.of(context)!.mmrCache;
    }

    Client.of(context)!.mmrCache = await Client.of(context)!.client!.getCurrentMMR();
    return Client.of(context)!.mmrCache;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  NamedChipWidget(labelText: 'region', valueText: Client.of(context)!.client?.user?.region.humanizeRegionName() ?? '~'),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: Client.of(context)!.client?.user?.name,
                      style: GoogleFonts.fjallaOne(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '  #${Client.of(context)!.client?.user?.tag}',
                          style: GoogleFonts.fjallaOne(
                            fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  NamedChipWidget(labelText: 'account level', valueText: Client.of(context)!.client?.user?.accountLevel.toString()),
                ],
              ),
              Expanded(
                child: FutureBuilder<MMR?>(
                  future: _fetchMMR(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error Occured while fetching your match stats.'),
                      );
                    }

                    final rank = getRankWithTierId(snapshot.data!.currentTierId);

                    return Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            rank != null ? rank.getIconUri().toString() : Ranks.Unranked.getIconUri().toString(),
                            fit: BoxFit.fitHeight,
                            filterQuality: FilterQuality.high,
                            isAntiAlias: true,
                            alignment: Alignment.centerRight,
                            height: 130,
                          ),
                          Text(
                            snapshot.data!.currentTierName.toUpperCase(),
                            style: GoogleFonts.ubuntu(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          LinearPercentIndicator(
            animation: true,
            lineHeight: 30.0,
            animationDuration: 1000,
            percent: (Client.of(context)!.mmrCache?.rankingInTier ?? 0) / 100,
            center: Text(
              '${(Client.of(context)!.mmrCache?.rankingInTier ?? 0)} / 100',
              style: GoogleFonts.ptSansCaption(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: ImageIcon(
                NetworkImage(
                  RankEventTypes.Demoted.getIconUri().toString(),
                  scale: 0.8,
                ),
                color: Colors.grey,
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerRight,
              child: ImageIcon(
                NetworkImage(
                  RankEventTypes.Promoted.getIconUri().toString(),
                  scale: 0.8,
                ),
                color: Colors.green,
              ),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.greenAccent,
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Recent Matchs',
              style: GoogleFonts.notoSans(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 2,
            color: Colors.black,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, bottom: 10, right: MediaQuery.of(context).size.width - 150),
          ),
          RecentMatchesWidget(),
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(10),
            child: Text(
              'Valorant Stats is not affiliated with Riot Games.',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(10),
            child: Text(
              'This app is made possible using API provided by henrikdev',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(),
            ),
          ),
        ],
      ),
    );
  }
}
