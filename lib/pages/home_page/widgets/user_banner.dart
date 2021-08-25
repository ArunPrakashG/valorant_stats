import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:valorant_api/api_enums.dart';
import 'package:valorant_api/models/current_mmr.dart';
import '../../../valorant_stats_app.dart';
import 'named_chip.dart';

class UserBannerWidget extends StatefulWidget {
  const UserBannerWidget({Key? key}) : super(key: key);

  @override
  _UserBannerWidgetState createState() => _UserBannerWidgetState();
}

class _UserBannerWidgetState extends State<UserBannerWidget> {
  MMR? _mmrCache;

  Future<MMR?> _fetchMMR(BuildContext context) async {
    if (_mmrCache != null) {
      return _mmrCache;
    }

    final mmrRespose = await ValorantStatsApp.client!.getCurrentMMR();
    setState(() {
      _mmrCache = mmrRespose;
    });

    return _mmrCache;
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
                  NamedChipWidget(labelText: 'region', valueText: ValorantStatsApp.client?.user?.region.humanizeRegionName() ?? '~'),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: ValorantStatsApp.client!.user!.name,
                      style: GoogleFonts.fjallaOne(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '  #${ValorantStatsApp.client!.user!.tag}',
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
                  NamedChipWidget(labelText: 'account level', valueText: ValorantStatsApp.client!.user!.accountLevel.toString()),
                ],
              ),
              Expanded(
                child: FutureBuilder<MMR?>(
                  future: _fetchMMR(context),
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
            percent: (_mmrCache?.rankingInTier ?? 0) / 100,
            center: Text(
              '${(_mmrCache?.rankingInTier ?? 0)} / 100',
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
        ],
      ),
    );
  }
}
