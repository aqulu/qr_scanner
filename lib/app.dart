import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/scan_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScanScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
