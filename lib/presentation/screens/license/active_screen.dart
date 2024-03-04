// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants/sizes.dart';
import '../../../domain/datasources/shared_preferences_datasource.dart';

class ActiveLicenseScreen extends StatefulWidget {
  static const name = 'active-license';
  const ActiveLicenseScreen({super.key});

  @override
  State<ActiveLicenseScreen> createState() => _ActiveLicenseScreenState();
}

class _ActiveLicenseScreenState extends State<ActiveLicenseScreen> {
  @override
  initState() {
    SharedPreferencesDatasource.getLicense().then((value) {
      String? license = value;
      if (license != null) {
        if (license == '123456789') {
          context.go('/dashboard');
        }
      }
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Sizes.initSizes(height, width);

    return Scaffold(
      body: SizedBox(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        child: const SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          child: Column(
            children: [Header(), Body()],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.screenHeight * (1 - Sizes.headerHeigthPercentage) -
          Sizes.overallPadding,
      width: double.infinity,
      child: const Row(
        children: [
          FormValidateLicense(),
          ImageSports(),
        ],
      ),
    );
  }
}

class FormValidateLicense extends StatefulWidget {
  const FormValidateLicense({super.key});

  @override
  State<FormValidateLicense> createState() => _FormValidateLicenseState();
}

class _FormValidateLicenseState extends State<FormValidateLicense> {
  TextEditingController licenseController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    licenseController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    licenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return 'License key is required';
      }
      if (value != '123456789') {
        return 'License not found';
      }
      return null;
    }

    submit(String? value) {
      final isValid = formKey.currentState!.validate();
      // Guardar la licencia
      if (isValid) {
        SharedPreferencesDatasource.saveLicense(licenseController.text);
        context.go('/dashboard');
      }
    }

    return Container(
      color: const Color.fromRGBO(44, 44, 44, 1),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 130),
      width: Sizes.screenWidth * 0.65,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Thank you for installing.",
              style: TextStyle(fontSize: Sizes.font2),
              textAlign: TextAlign.center,
            ),
            Text(
              "Activation is required to authenticate this copy of SQUAAD Board. Please Provide a valid License number to activate your software.",
              style: TextStyle(
                fontSize: Sizes.font9,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "If you do not have a license number please contact us.",
              style: TextStyle(fontSize: Sizes.font9),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.overallPadding),
              child: TextFormField(
                controller: licenseController,
                onFieldSubmitted: submit,
                style: const TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "LICENSE KEY",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: validator,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
            ),
            Text(
              "License Number",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.font6),
            ),
            SizedBox(
              height: Sizes.overallPadding * 2,
            ),
            TextButton(
              focusNode: _focusNode,
              onPressed: () {
                submit(licenseController.text);
              },
              child: Text(
                "VALIDATE",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Sizes.font8),
              ),
            ),
            SizedBox(
              height: Sizes.overallPadding * 2,
            ),
          ],
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
    return Container(
      width: Sizes.screenWidth * 0.35,
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
