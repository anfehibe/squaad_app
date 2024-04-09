import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squaad_app/domain/entities/license.dart';

part 'license_event.dart';
part 'license_state.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  LicenseBloc() : super(const LicenseInitial()) {
    on<ActiveLicense>((event, emit) => emit(LicenseSet(event.license)));
    on<InactiveLicense>((event, emit) => emit(const LicenseInitial()));
  }
}
