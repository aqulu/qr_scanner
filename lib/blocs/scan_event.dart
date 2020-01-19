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
