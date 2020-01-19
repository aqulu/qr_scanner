import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:qr_scanner/blocs/scan_bloc.dart';
import 'package:qr_scanner/blocs/scan_event.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<ScanBloc>(
        create: (_) => ScanBloc(),
        child: _ScanScreen(),
      );
}

class _ScanScreen extends StatefulWidget {
  @override
  __ScanScreenState createState() => __ScanScreenState();
}

class __ScanScreenState extends State<_ScanScreen> {
  void _onQrReaderInitialized(QrReaderViewController controller) {
    controller.startCamera((code, _) {
      BlocProvider.of<ScanBloc>(context).add(Result(code));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => QrReaderView(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            callback: _onQrReaderInitialized,
          ),
        ),
      );
}
