part of 'license_bloc.dart';

sealed class LicenseState {
  final License? license;
  const LicenseState(this.license);
}

final class LicenseInitial extends LicenseState {
  const LicenseInitial() : super(null);
}

class LicenseSet extends LicenseState {
  final License newLicense;
  const LicenseSet(this.newLicense) : super(newLicense);
}
