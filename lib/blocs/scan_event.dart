import 'package:flutter/foundation.dart';

abstract class ScanEvent {
  const ScanEvent();
}

@immutable
class Result extends ScanEvent {
  final String code;

  const Result(this.code) : super();

  @override
  bool operator ==(other) {
    return identical(this, other) || (other is Result && code == other.code);
  }

  @override
  int get hashCode => code.hashCode;
}

@immutable
class ScanError extends ScanEvent {
  final Exception error;

  const ScanError(this.error) : super();

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is ScanError && error == other.error);
  }

  @override
  int get hashCode => error.hashCode;
}
