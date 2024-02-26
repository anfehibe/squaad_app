import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../../../config/constants/sizes.dart';
import '../../../domain/datasources/shared_preferences_datasource.dart';

class DashboardScreen extends StatelessWidget {
  static const name = 'dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: Sizes.screenHeight,
      width: Sizes.screenWidth,
      child: const Column(
        children: [HeaderDashboard(), BodyDashboard()],
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
      child: const Row(
        children: [
          PlayerSwipper(),
          SponsorAndInfo(),
        ],
      ),
    );
  }
}

class PlayerSwipper extends StatefulWidget {
  const PlayerSwipper({
    super.key,
  });

  @override
  State<PlayerSwipper> createState() => _PlayerSwipperState();
}

class _PlayerSwipperState extends State<PlayerSwipper> {
  // Instanciar el servicio de almacenamiento
  final List<String> _ids = [
    'assets/videos/1.mp4',
    'assets/videos/2.mp4',
    'assets/videos/3.mp4',
    'assets/videos/4.mp4',
  ];
  SwiperController swiperController = SwiperController();

  List<Map<String, String>> data = [];
  @override
  void initState() {
    getVideos();

    super.initState();
  }

  getVideos() async {
    // Obtener la lista de URLs de videos

    data = _ids.map((id) => {'type': 'video', 'url': id}).toList();
    for (var i = 0; i < 4; i++) {
      data.add({'type': 'img', 'url': '$i'});
    }
  }

  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.screenWidth * 0.7,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Sizes.boxSeparation),
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
              swiperController.stopAutoplay(animation: false);

              return PlayerV(
                swiperController: swiperController,
                url: data[index]['url']!,
              );
            }
          },
        ),
      ),
    );
  }
}

class PlayerV extends StatefulWidget {
  const PlayerV({
    super.key,
    required this.swiperController,
    required this.url,
  });
  final SwiperController swiperController;
  final String url;

  @override
  State<PlayerV> createState() => _PlayerVState();
}

class _PlayerVState extends State<PlayerV> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.url)
      ..setVolume(1.0)
      ..setLooping(false)
      ..addListener(() {
        if (_controller.value.isCompleted) {
          widget.swiperController.next();
        }
      })
      ..play();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller));
      },
    );
  }
}

class SponsorAndInfo extends StatelessWidget {
  const SponsorAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.screenWidth * 0.3,
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
              fit: BoxFit.fitWidth,
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
                  child: const Row(
                    children: [
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
