import 'package:flutter/foundation.dart';

@immutable
class QrCode {
  final String code;

  const QrCode(this.code);

  @override
  bool operator ==(other) {
    return identical(this, other) || (other is QrCode && code == other.code);
  }

  @override
  int get hashCode => code.hashCode;
}
