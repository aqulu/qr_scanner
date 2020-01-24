import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_scanner/blocs/permission_check_event.dart';

class PermissionCheckBloc extends Bloc<PermissionCheckEvent, PermissionStatus> {
  final PermissionHandler _permissionHandler;

  PermissionCheckBloc(this._permissionHandler) : super() {
    add(CheckPermissions());
  }

  @override
  PermissionStatus get initialState => PermissionStatus.unknown;

  @override
  Stream<PermissionStatus> mapEventToState(
    PermissionCheckEvent event,
  ) async* {
    if (event is CheckPermissions) {
      yield await _permissionHandler.checkPermissionStatus(
        PermissionGroup.camera,
      );
    }

    if (event is UpdatePermissionStatus) {
      yield event.permissionStatus;
    }
  }
}
