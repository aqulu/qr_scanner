import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/blocs/permission_check_bloc.dart';
import 'package:qr_scanner/blocs/permission_check_event.dart';
import 'package:qr_scanner/routes.dart';

///
/// Screen for acquiring required permissions. Automatically redirects to
/// [Routes.scan], if permissions granted
///
class PermissionCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<PermissionHandler>(
            create: (_) => PermissionHandler(),
          ),
          BlocProvider<PermissionCheckBloc>(
            create: (context) => PermissionCheckBloc(
              Provider.of<PermissionHandler>(context, listen: false),
            ),
          ),
        ],
        child: _PermissionCheckScreen(),
      );
}

class _PermissionCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final permissionHandler = Provider.of<PermissionHandler>(context);

    return BlocConsumer<PermissionCheckBloc, PermissionStatus>(
      listener: (BuildContext context, PermissionStatus state) {
        if (state == PermissionStatus.granted) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(Routes.scan);
          });
        }

        if (state == PermissionStatus.denied ||
            state == PermissionStatus.unknown) {
          permissionHandler.requestPermissions([PermissionGroup.camera]).then(
            (result) {
              final permissionStatus = result[PermissionGroup.camera];
              BlocProvider.of<PermissionCheckBloc>(context)
                  .add(UpdatePermissionStatus(permissionStatus));
            },
          );
        }
      },
      listenWhen: (_, state) => [
        PermissionStatus.granted,
        PermissionStatus.denied,
        PermissionStatus.unknown,
      ].contains(state),
      builder: (BuildContext context, PermissionStatus state) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'qr_scanner requires camera permissions to function properly',
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              child: Text('grant permissions'),
              onPressed: () {
                permissionHandler.openAppSettings().then((_) {
                  BlocProvider.of<PermissionCheckBloc>(context)
                      .add(CheckPermissions());
                });
              },
            ),
          ],
        ),
      ),
      buildWhen: (_, state) => state != PermissionStatus.granted,
    );
  }
}
