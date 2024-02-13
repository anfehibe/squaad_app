import 'package:flutter/material.dart';
import 'package:squaad_app/config/constants/environment.dart';

class ActiveLicenseScreen extends StatelessWidget {
  static const name = 'active-license';
  const ActiveLicenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(Environment.squaadUrl),
        ));
  }
}
