
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future permissionHandler() async {
   
    await Permission.contacts.shouldShowRequestRationale;
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.photos,
      Permission.camera,
      Permission.microphone,
      Permission.notification,
      Permission.storage,
      Permission.accessMediaLocation,
      Permission.contacts
    ].request();

    if (statuses[Permission.location]!.isDenied) {
      print('location permision denied');
    }
    if (statuses[Permission.storage]!.isDenied) {
      print('storage permision denied');
    }
    if (statuses[Permission.accessMediaLocation]!.isDenied) {
      print('accessMediaLocation permision denied');
    }
    if (statuses[Permission.camera]!.isDenied) {
      print('camera permision denied');
    }
    if (statuses[Permission.photos]!.isDenied) {
      print('photo permision denied');
    }
    if (statuses[Permission.notification]!.isDenied) {
      print('notification permision denied');
    }
    if (statuses[Permission.microphone]!.isDenied) {
      print('microphone permision denied');
    }

   
  }
}
