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
            lazy: false,
          ),
        ],
        child: _PermissionCheckScreen(),
      );
}

class _PermissionCheckScreen extends StatefulWidget {
  @override
  _PermissionCheckScreenState createState() => _PermissionCheckScreenState();
}

class _PermissionCheckScreenState extends State<_PermissionCheckScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    BlocProvider.of<PermissionCheckBloc>(context)
        .add(PermissionCheckEvent.checkPermissions);
  }

  @override
  Widget build(BuildContext context) {
    final permissionHandler = Provider.of<PermissionHandler>(context);

    return BlocConsumer<PermissionCheckBloc, PermissionStatus>(
      listener: (BuildContext context, PermissionStatus state) {
        if (state == PermissionStatus.granted) {
          // PermissionStatus.granted does not trigger rebuilds,
          // so the redirect call does not require a postFrameCallback
          Navigator.of(context).pushReplacementNamed(Routes.scan);
        }
      },
      listenWhen: (_, state) => [
        PermissionStatus.granted,
        PermissionStatus.denied,
        PermissionStatus.unknown,
      ].contains(state),
      builder: (BuildContext context, PermissionStatus state) => Scaffold(
        body: (state == PermissionStatus.unknown)
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'qr_scanner requires camera permissions to function properly',
                      textAlign: TextAlign.center,
                    ),
                    MaterialButton(
                      child: Text('grant permissions'),
                      onPressed: () {
                        permissionHandler.openAppSettings();
                      },
                    ),
                  ],
                ),
              ),
      ),
      buildWhen: (_, state) => state != PermissionStatus.granted,
    );
  }
}
