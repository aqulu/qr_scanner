import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/blocs/scan_event.dart';
import 'package:qr_scanner/blocs/scan_state.dart';
import 'package:qr_scanner/models/qr_code.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  @override
  ScanState get initialState => ScanState([]);

  @override
  Stream<ScanState> transformEvents(
    Stream<ScanEvent> events,
    Stream<ScanState> Function(ScanEvent) next,
  ) =>
      super.transformEvents(
        events.distinct(),
        next,
      );

  @override
  Stream<ScanState> mapEventToState(ScanEvent event) async* {
    if (event is Result) {
      final currentState = state;
      yield currentState.copy(
        results: [QrCode(event.code), ...currentState.results],
        error: None(),
      );
    }

    if (event is ScanError) {
      yield state.copy(error: Some(event.error));
    }
  }
}
