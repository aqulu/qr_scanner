import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scanner/models/qr_code.dart';

void main() {
  test('isAbsoluteUri returns true for custom uris', () {
    final code = QrCode('market://details?id=com.example.your.package');
    expect(code.isAbsoluteUri, true);
  });

  test('isAbsoluteUri returns false for text', () {
    final code = QrCode('Cheers love, the cavalry\'s here!');
    expect(code.isAbsoluteUri, false);
  });

  test('isAbsoluteUri returns false on urls without specified protocol', () {
    final code = QrCode('ddg.gg');
    expect(code.isAbsoluteUri, false);
  });
}
