import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_scanner/blocs/permission_check_event.dart';

class PermissionCheckBloc extends Bloc<PermissionCheckEvent, PermissionStatus> {
  final PermissionHandler _permissionHandler;

  PermissionCheckBloc(this._permissionHandler) : super() {
    add(PermissionCheckEvent.checkPermissions);
  }

  @override
  PermissionStatus get initialState => PermissionStatus.unknown;

  @override
  Stream<PermissionStatus> mapEventToState(PermissionCheckEvent event) async* {
    switch (event) {
      case PermissionCheckEvent.checkPermissions:
        yield await _checkOrRequestPermissionStatus();
        break;
    }
  }

  ///
  /// Checks the current permission status for [PermissionGroup.camera].
  /// Will start a request for permissions if the current PermissionStatus is not granted (and the OS settings allow it)
  ///
  /// returns [PermissionStatus] after permission request has finished
  ///
  Future<PermissionStatus> _checkOrRequestPermissionStatus() =>
      _permissionHandler
          .checkPermissionStatus(
            PermissionGroup.camera,
          )
          .then(
            (state) => _shouldRequestPermissions(state)
                ? _permissionHandler.requestPermissions(
                    [PermissionGroup.camera],
                  ).then(
                    (result) => result[PermissionGroup.camera],
                  )
                : state,
          );

  /// checks whether or not permissions should be requested based on [permissionStatus]
  bool _shouldRequestPermissions(PermissionStatus permissionStatus) =>
      [PermissionStatus.denied, PermissionStatus.unknown].contains(
        permissionStatus,
      );
}
