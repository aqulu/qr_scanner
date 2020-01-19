import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_scanner/blocs/scan_bloc.dart';
import 'package:qr_scanner/blocs/scan_event.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<ScanBloc>(
        create: (_) => ScanBloc(),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              QrCamera(
                qrCodeCallback: (code) {
                  BlocProvider.of<ScanBloc>(context).add(Result(code));
                },
                onError: (context, error) {
                  BlocProvider.of<ScanBloc>(context).add(ScanError(error));
                  return SizedBox.shrink(); // leave error handling to bloc
                },
                child: Center(
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.black45,
                        width: 10.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
