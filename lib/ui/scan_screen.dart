import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:qr_scanner/blocs/scan_bloc.dart';
import 'package:qr_scanner/blocs/scan_event.dart';
import 'package:qr_scanner/blocs/scan_state.dart';
import 'package:qr_scanner/models/qr_code.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<ScanBloc>(
        create: (_) => ScanBloc(),
        child: _ScanScreen(),
      );
}

class _ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: <Widget>[
            // wrap into LayoutBuilder to get concrete width / height parameters for QrReaderView
            LayoutBuilder(
              builder: (context, constraints) => QrReaderView(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                callback: (QrReaderViewController controller) {
                  controller.startCamera((code, _) {
                    BlocProvider.of<ScanBloc>(context).add(Result(code));
                  });
                },
              ),
            ),
            SizedBox.expand(child: _bottomSheet),
          ],
        ),
      );

  Widget get _bottomSheet => DraggableScrollableSheet(
        minChildSize: 0.25,
        initialChildSize: 0.25,
        maxChildSize: 0.75,
        builder: (_, ScrollController scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: const BorderRadius.vertical(
              top: const Radius.circular(8.0),
            ),
          ),
          child: BlocBuilder<ScanBloc, ScanState>(
            builder: (_, ScanState state) => ListView.builder(
              controller: scrollController,
              itemCount: state.results.length,
              itemBuilder: (context, index) => _buildResultRow(
                state.results[index],
              ),
            ),
          ),
        ),
      );

  ListTile _buildResultRow(QrCode code) => ListTile(
        title: Text(code.code),
      );
}
