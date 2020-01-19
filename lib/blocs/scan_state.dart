import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_scanner/models/qr_code.dart';

/// represents the current state of the scanner
@immutable
class ScanState {
  final List<QrCode> results;

  final Option<Exception> error;

  ScanState(List<QrCode> results, {Exception error})
      : this._(results ?? [], optionOf(error));

  const ScanState._(this.results, this.error)
      : assert(results != null && error != null);

  ///
  /// creates a new [ScanState] using the provided non-null parameters
  /// and copies the remaining values from the current ScanState
  ///
  ScanState copy({List<QrCode> results, Option<Exception> error}) =>
      ScanState._(results ?? this.results, error ?? this.error);

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is ScanState &&
            listEquals(results, other.results) &&
            error == other.error);
  }

  @override
  int get hashCode => results.hashCode ^ error.hashCode;
}
