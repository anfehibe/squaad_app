import 'dart:async';
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
    'assets/videos/kidsPlanet.mp4',
  ];
  // SwiperController swiperController = SwiperController();
  PageController pageController = PageController();
  Timer? globalTimer;
  int currentPageIndex = 0;
  List<Map<String, String>> data = [];
  @override
  void initState() {
    getVideos();
    super.initState();
  }

  getVideos() async {
    // Obtener la lista de URLs de videos

    data = _ids.map((id) => {'type': 'video', 'url': id}).toList();
    int imagesCount = 0;
    for (var i = 0; i < imagesCount; i++) {
      data.add({'type': 'img', 'url': '$i'});
    }
  }

  @override
  void dispose() {
    // swiperController.dispose();
    pageController.dispose();
    globalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.screenWidth * 0.65,
      child: PageView.builder(
        controller: pageController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data[index]['type'] == "img") {
            globalTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
              if (index == data.length - 1) {
                timer.cancel();
                globalTimer!.cancel();
                pageController.jumpTo(0);
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }
              timer.cancel();
            });
            return Image.asset(
              'assets/images/swiper/${data[index]['url']}.jpg',
              fit: BoxFit.fitHeight,
            );
          } else {
            globalTimer?.cancel();
            return PlayerV(
              pageController: pageController,
              url: data[index]['url']!,
            );
          }
        },
      ),
    );
  }
}

class PlayerV extends StatefulWidget {
  const PlayerV({
    super.key,
    required this.pageController,
    required this.url,
  });
  final PageController pageController;
  final String url;

  @override
  State<PlayerV> createState() => _PlayerVState();
}

class _PlayerVState extends State<PlayerV> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.url,
        videoPlayerOptions: VideoPlayerOptions())
      ..setVolume(1.0)
      ..setLooping(true)
      ..addListener(() {
        /* if (_controller.value.isCompleted) {
          widget.pageController.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        } */
      })
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
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
        return Center(
          child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller)),
        );
      },
    );
  }
}

class SponsorAndInfo extends StatelessWidget {
  const SponsorAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.screenWidth * 0.35,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: Sizes.boxSeparation * 2),
            color: Colors.black,
            height: (Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
                    Sizes.overallPadding) *
                0.50,
            width: double.infinity,
            child: Image.asset(
              'assets/images/schools/KidsPlanet.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: Sizes.boxSeparation * 2),
            height: (Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
                    Sizes.overallPadding) *
                0.25,
            color: Colors.white,
            child: Image.asset(
              "assets/images/Group10.png",
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: Sizes.boxSeparation * 2),
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
                    fit: BoxFit.fitWidth,
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
