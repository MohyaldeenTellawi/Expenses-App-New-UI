import 'package:expenses_app/screens/home_screen/manager/localization_event.dart';
import 'package:expenses_app/screens/home_screen/manager/localization_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState()) {
    on<ChaneLocalization>((event, emit) {
      emit(LocalizationState(
        newLocal: event.newLocal,
      ));
    });
  }
}
