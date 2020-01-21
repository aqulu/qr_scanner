import 'package:flutter/material.dart';
import 'package:qr_scanner/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: Routes.get(),
      initialRoute: Routes.scan,
    );
  }
}
