import 'package:flutter/foundation.dart';

@immutable
class QrCode {
  final String content;

  const QrCode(this.content);

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is QrCode && content == other.content);
  }

  @override
  int get hashCode => content.hashCode;
}
