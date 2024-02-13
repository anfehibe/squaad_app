class Sizes {
  static double screenHeight = 0;
  static double screenWidth = 0;
  static double headerSize = 0;
  static double buttonWidth = 0;

  static double overallPadding = 0;
  static double boxSeparation = 0;

  static double font0 = 36;
  static double font2 = 32;
  static double font4 = 27;
  static double font6 = 22;
  static double font8 = 17;
  static double font9 = 15.5;
  static double font10 = 14;
  static double font11 = 12;
  static double font12 = 10;

  static double tileHeightExpandedCard = 0;
  static double tileHeightHugePlus = 0;
  static double tileHeightHuge = 0;
  static double tileHeightCard = 0;
  static double tileHeightBig = 0;
  static double tileHeightLarge = 0;
  static double tileHeightMedium = 0;
  static double tileHeightChip = 0;
  static double tileHeightSmall = 0;
  static double tileHeightMicro = 0;

  // HEIGHT
  static double headerHeigthPercentage = 0.1;

  static initSizes(double height, double width) {
    // print("Sizes $font10 $height $width");
    screenHeight = height;
    screenWidth = width;

    double maxSize = (screenHeight > screenWidth) ? screenHeight : screenWidth;

    overallPadding = maxSize / 36;
    boxSeparation = overallPadding / 2;

    // Headers:
    headerSize = maxSize / 4;

    // buttons
    buttonWidth = maxSize / 3;

    tileHeightExpandedCard = maxSize / 4;
    tileHeightHugePlus = maxSize / 6;
    tileHeightHuge = maxSize / 8;
    tileHeightCard = maxSize / 9;
    tileHeightBig = maxSize / 10;
    tileHeightLarge = maxSize / 12;
    tileHeightMedium = maxSize / 18;
    tileHeightChip = maxSize / 16;
    tileHeightSmall = maxSize / 22;
    tileHeightMicro = maxSize / 40;

    // font0 = 36 * width / 320;
    // font2 = 32 * width / 320;
    // font4 = 27 * width / 320;
    // font6 = 22 * width / 320;
    // font8 = 17 * width / 320;
    // font10 = 14 * width / 320;
    // font11 = 12 * width / 320;
    // font12 = 10 * width / 320;
  }

  static bool isLandscape() {
    return screenHeight < screenWidth;
  }
}
