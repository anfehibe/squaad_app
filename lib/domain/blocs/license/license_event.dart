part of 'license_bloc.dart';

sealed class LicenseEvent {}

class ActiveLicense extends LicenseEvent {
  final License license;
  ActiveLicense(this.license);
}

class InactiveLicense extends LicenseEvent {}
