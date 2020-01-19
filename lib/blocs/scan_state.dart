import 'package:flutter/foundation.dart';
import 'package:qr_scanner/models/qr_code.dart';

/// represents the current state of the scanner
@immutable
class ScanState {
  final List<QrCode> results;

  const ScanState(this.results);

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is ScanState && listEquals(results, other.results));
  }

  @override
  int get hashCode => results.hashCode;
}
