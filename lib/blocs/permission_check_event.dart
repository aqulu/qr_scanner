import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionCheckEvent {}

@immutable
class CheckPermissions extends PermissionCheckEvent {}

@immutable
class UpdatePermissionStatus extends PermissionCheckEvent {
  final PermissionStatus permissionStatus;

  UpdatePermissionStatus(this.permissionStatus);
}
