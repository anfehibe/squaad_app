import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants/sizes.dart';

class ActiveLicenseScreen extends StatelessWidget {
  static const name = 'active-license';
  const ActiveLicenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Sizes.initSizes(height, width);

    TextEditingController licenseController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SizedBox(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        child: Column(
          children: [
            const Header(),
            Body(formKey: formKey, licenseController: licenseController)
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.formKey,
    required this.licenseController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController licenseController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
          Sizes.overallPadding,
      child: Row(
        children: [
          FormValidateLicense(
              formKey: formKey, licenseController: licenseController),
          const ImageSports(),
        ],
      ),
    );
  }
}

class FormValidateLicense extends StatelessWidget {
  const FormValidateLicense({
    super.key,
    required this.formKey,
    required this.licenseController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController licenseController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Container(
        color: const Color.fromRGBO(44, 44, 44, 1),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 130),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thank you for installing.",
                    style: TextStyle(fontSize: Sizes.font2),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Activation is required to authenticate this copy of SQUAAD Board. Please Provide a valid License numer to activate your software.",
                    style: TextStyle(
                      fontSize: Sizes.font9,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "If you do not hace a license number please contact us.",
                    style: TextStyle(fontSize: Sizes.font9),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Sizes.overallPadding),
                    child: TextFormField(
                      controller: licenseController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: "LICENSE KEY",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'License key is required';
                        }
                        if (value != '123456789') {
                          return 'License not found';
                        }
                        return null;
                      },
                    ),
                  ),
                  Text(
                    "License Number",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Sizes.font6),
                  ),
                  SizedBox(
                    height: Sizes.overallPadding * 2,
                  ),
                  TextButton(
                      onPressed: () {
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          context.go('/dashboard');
                        } else {
                          return;
                        }
                      },
                      child: Text(
                        "VALIDATE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: Sizes.font8),
                      )),
                  SizedBox(
                    height: Sizes.overallPadding * 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageSports extends StatelessWidget {
  const ImageSports({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Players.png",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Sizes.screenHeight * Sizes.headerHeigthPercentage) +
          Sizes.overallPadding,
      color: const Color.fromRGBO(148, 148, 148, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 36),
            child: Image.asset(
              "assets/images/Logo.png",
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
