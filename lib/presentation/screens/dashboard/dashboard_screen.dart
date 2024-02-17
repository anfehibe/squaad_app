import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../config/constants/sizes.dart';
import '../../../domain/datasources/shared_preferences_datasource.dart';

class DashboardScreen extends StatelessWidget {
  static const name = 'dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: Sizes.screenHeight,
      width: Sizes.screenWidth,
      child: Column(
        children: const [HeaderDashboard(), BodyDashboard()],
      ),
    ));
  }
}

class BodyDashboard extends StatelessWidget {
  const BodyDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
          Sizes.overallPadding,
      child: Row(
        children: const [
          Player(),
          SponsorAndInfo(),
        ],
      ),
    );
  }
}

class Player extends StatefulWidget {
  const Player({
    super.key,
  });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final List<String> _ids = [
    'DcLb2lX6los',
    'es5Yefj0ncI',
    '0PA39XnRetE',
    'eW9XAiYWnPw',
  ];
  SwiperController swiperController = SwiperController();
  YoutubePlayerController youtubeController =
      YoutubePlayerController(initialVideoId: '');
  List<Map<String, String>> data = [];
  @override
  void initState() {
    data = _ids.map((id) => {'type': 'video', 'url': id}).toList();
    for (var i = 0; i < _ids.length; i++) {
      data.add({'type': 'img', 'url': '$i'});
    }
    youtubeController = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
          autoPlay: false, mute: false, loop: false, hideControls: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.screenWidth * 0.65,
      child: Swiper(
        controller: swiperController,
        autoplay: false,
        loop: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data[index]['type'] == "img") {
            swiperController.startAutoplay();

            return Image.asset(
              'assets/images/swiper/${data[index]['url']}.jpg',
              fit: BoxFit.fitHeight,
            );
          } else {
            swiperController.stopAutoplay();
            youtubeController.load(data[index]['url']!);

            return YoutubePlayer(
              controller: youtubeController,
              showVideoProgressIndicator: true,
              onReady: () {
                youtubeController.play();
              },
              onEnded: (metaData) {
                youtubeController.pause();
                swiperController.next();
              },
            );
          }
        },
      ),
    );
  }
}

class SponsorAndInfo extends StatelessWidget {
  const SponsorAndInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.screenWidth * 0.35,
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: (Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
                    Sizes.overallPadding) *
                0.50,
            width: double.infinity,
            child: Image.asset(
              'assets/images/schools/0.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            height: (Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
                    Sizes.overallPadding) *
                0.25,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                  child: const Text(
                    "Sponsors:",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Sizes.boxSeparation * 3),
                  child: Image.asset(
                    "assets/images/sponsors.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: (Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
                    Sizes.overallPadding) *
                0.25,
            color: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
                  child: Row(
                    children: const [
                      Text(
                        "Powered by:",
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.overallPadding * 3.39),
                  child: Image.asset(
                    "assets/images/LogoSQUAAD.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderDashboard extends StatelessWidget {
  const HeaderDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Sizes.screenHeight * Sizes.headerHeigthPercentage) +
          Sizes.overallPadding,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onLongPress: () {
              SharedPreferencesDatasource.saveLicense("");
              context.go('/');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Image.asset(
                "assets/images/LogoPV.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "www.pvsportkids.com",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.font8),
            ),
          ),
        ],
      ),
    );
  }
}
