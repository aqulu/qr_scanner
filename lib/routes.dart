import 'package:flutter/widgets.dart';
import 'package:qr_scanner/ui/permission_check_screen.dart';
import 'package:qr_scanner/ui/scan_screen.dart';

abstract class Routes {
  static const permissionCheck = 'permissionCheck';
  static const scan = 'scan';

  static Map<String, WidgetBuilder> get() => {
        permissionCheck: (context) => PermissionCheckScreen(),
        scan: (context) => ScanScreen(),
      };
}
