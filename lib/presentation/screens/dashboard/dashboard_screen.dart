import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:squaad_app/domain/blocs/license/license_bloc.dart';
import 'package:squaad_app/domain/entities/license.dart';
import 'package:video_player/video_player.dart';
import '../../../config/constants/sizes.dart';
import '../../../domain/datasources/shared_preferences_datasource.dart';

class DashboardScreen extends StatelessWidget {
  static const name = 'dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    KeepScreenOn.turnOn();
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
    License? license = BlocProvider.of<LicenseBloc>(context).state.license;
    return SizedBox(
      height: Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
          Sizes.overallPadding,
      child: license != null
          ? Row(
              children: [
                PlayerSwipper(
                  license: license,
                ),
                SponsorAndInfo(
                  license: license,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}

class PlayerSwipper extends StatefulWidget {
  final License license;
  const PlayerSwipper({
    super.key,
    required this.license,
  });

  @override
  State<PlayerSwipper> createState() => _PlayerSwipperState();
}

class _PlayerSwipperState extends State<PlayerSwipper> {
  PageController pageController = PageController();
  Timer? globalTimer;
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
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
    var data = widget.license.media;
    return SizedBox(
      width: Sizes.screenWidth * 0.65,
      child: PageView.builder(
        controller: pageController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data[index].type == 1) {
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
            return Image.network(
              data[index].fileUrl,
              fit: BoxFit.fitHeight,
            );
          } else {
            globalTimer?.cancel();
            return PlayerV(
              pageController: pageController,
              url: data[index].fileUrl,
              lengthData: data.length,
              currentIndex: index,
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
    required this.lengthData,
    required this.currentIndex,
  });
  final PageController pageController;
  final String url;
  final int lengthData;
  final int currentIndex;

  @override
  State<PlayerV> createState() => _PlayerVState();
}

class _PlayerVState extends State<PlayerV> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url),
        videoPlayerOptions: VideoPlayerOptions())
      ..setVolume(1.0)
      ..setLooping(widget.lengthData == 1)
      ..addListener(() {
        if (widget.lengthData != 1) {
          if (_controller.value.isCompleted) {
            if (widget.currentIndex == widget.lengthData - 1) {
              widget.pageController.jumpTo(0);
            } else {
              widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            }
          }
        }
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
  final License license;
  const SponsorAndInfo({super.key, required this.license});

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
            child: Image.network(
              license.qrInfoUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: Sizes.boxSeparation * 2),
            height: (Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
                    Sizes.overallPadding) *
                0.25,
            color: Colors.white,
            child: Image.network(
              license.bannerUrl,
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
              BlocProvider.of<LicenseBloc>(context).add(InactiveLicense());
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
