import 'package:flutter/material.dart';
import '../../../config/constants/sizes.dart';

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
        children: [
          Container(
            height: Sizes.screenHeight * Sizes.headerHeigthPercentage +
                Sizes.overallPadding,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Image.asset(
                    "assets/images/LogoPV.png",
                    fit: BoxFit.contain,
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
          ),
          SizedBox(
            height: Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
                Sizes.overallPadding,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Placeholder(),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Container(
                        height: (Sizes.screenHeight *
                                    (1 - Sizes.headerHeigthPercentage) -
                                Sizes.overallPadding) *
                            0.55,
                        color: Colors.yellowAccent,
                      ),
                      Container(
                        height: (Sizes.screenHeight *
                                    (1 - Sizes.headerHeigthPercentage) -
                                Sizes.overallPadding) *
                            0.2,
                        color: Colors.redAccent,
                      ),
                      Container(
                        height: (Sizes.screenHeight *
                                    (1 - Sizes.headerHeigthPercentage) -
                                Sizes.overallPadding) *
                            0.25,
                        color: Colors.lightBlueAccent,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/LogoSQUAAD.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      /*
                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
                              child: Text(
                                "Sponsors:",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: Image.asset(
                                "assets/images/sponsors.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ), SizedBox(
                        height: Sizes.screenHeight * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.boxSeparation),
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
                                  horizontal: Sizes.overallPadding * 3.5),
                              child: Image.asset(
                                "assets/images/LogoSQUAAD.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ],
                        ),
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
