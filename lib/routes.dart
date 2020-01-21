import 'package:flutter/cupertino.dart';
import 'package:qr_scanner/ui/scan_screen.dart';

abstract class Routes {
  static const scan = 'scan';

  static Map<String, WidgetBuilder> get() => {
        scan: (context) => ScanScreen(),
      };
}
