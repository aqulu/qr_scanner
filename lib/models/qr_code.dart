import 'package:flutter/foundation.dart';

@immutable
class QrCode {
  final String content;

  const QrCode(this.content);

  /// true if [content] is a parsable and an absolute URI
  bool get isAbsoluteUri => Uri.tryParse(content)?.isAbsolute ?? false;

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        (other is QrCode && content == other.content);
  }

  @override
  int get hashCode => content.hashCode;
}
