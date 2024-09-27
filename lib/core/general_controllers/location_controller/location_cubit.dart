import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
part 'location_state.dart';

enum PositionItemType {
  log,
  position,
}

class PositionItem {
  PositionItem(this.type, this.displayValue);

  final PositionItemType type;
  final String displayValue;
}

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  static LocationCubit get(context) => BlocProvider.of(context);

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  String palcename = '';

  // PopupMenuButton createActions() {
  //   return PopupMenuButton(
  //     elevation: 40,
  //     onSelected: (value) async {
  //       switch (value) {
  //         case 1:
  //           getLocationAccuracy();
  //           break;
  //         case 2:
  //           requestTemporaryFullAccuracy();
  //           break;
  //         case 3:
  //           openAppSettings();
  //           break;
  //         case 4:
  //           openLocationSettings();
  //           break;
  //         default:
  //           break;
  //       }
  //     },
  //     itemBuilder: (context) => [
  //       if (Platform.isIOS)
  //         const PopupMenuItem(
  //           value: 1,
  //           child: Text("Get Location Accuracy"),
  //         ),
  //       if (Platform.isIOS)
  //         const PopupMenuItem(
  //           value: 2,
  //           child: Text("Request Temporary Full Accuracy"),
  //         ),
  //       const PopupMenuItem(
  //         value: 3,
  //         child: Text("Open App Settings"),
  //       ),
  //       if (Platform.isAndroid || Platform.isWindows)
  //         const PopupMenuItem(
  //           value: 4,
  //           child: Text("Open Location Settings"),
  //         ),
  //       const PopupMenuItem(
  //         value: 5,
  //         child: Text("Clear"),
  //       ),
  //     ],
  //   );
  // }

  // checkGps() async {
  //   servicestatus = await Geolocator.isLocationServiceEnabled();
  //   if (servicestatus) {
  //     permission = await Geolocator.checkPermission();
  //
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         permission = await Geolocator.requestPermission();
  //
  //         Geolocator.openLocationSettings();
  //         print('Location permissions are denied');
  //       } else if (permission == LocationPermission.deniedForever) {
  //         // Geolocator.openAppSettings();
  //
  //         print("'Location permissions are permanently denied");
  //       } else {
  //         haspermission = true;
  //       }
  //     } else {
  //       haspermission = true;
  //     }
  //
  //     if (haspermission) {
  //       emit(CheckGPSState());
  //
  //       // await getLocation();
  //     }
  //   } else {
  //     permission = await Geolocator.requestPermission();
  //     // await getLocation();
  //
  //     print("GPS Service is not enabled, turn on GPS location");
  //   }
  //   emit(CheckGPSState());
  // }
  Future<void> getLocation() async {
    // Request location permission
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // Get current location
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      long = position.longitude.toString();
      lat = position.latitude.toString();

      // LocationSettings locationSettings = const LocationSettings(
      //   accuracy: LocationAccuracy.high, //accuracy of the location data
      //   distanceFilter: 100, //minimum distance (measured in meters) a
      //   //device must move horizontally before an update event is generated;
      // );

      // Geolocator.getPositionStream(locationSettings: locationSettings)
      //     .listen((Position position) {
      //   print(position.longitude); //Output: 80.24599079
      //   print(position.latitude); //Output: 29.6593457
      //
      //   long = position.longitude.toString();
      //   lat = position.latitude.toString();
      //   emit(GetLocationState());
      // });
      emit(GetLocationState());
    } else {}
  }
  // getLocation() async {
  //
  //   try{
  //     // await checkGps();
  //
  //     position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     print(position.longitude); //Output: 80.24599079
  //     print(position.latitude); //Output: 29.6593457
  //
  //     long = position.longitude.toString();
  //     lat = position.latitude.toString();
  //
  //
  //     LocationSettings locationSettings = const LocationSettings(
  //       accuracy: LocationAccuracy.high, //accuracy of the location data
  //       distanceFilter: 100, //minimum distance (measured in meters) a
  //       //device must move horizontally before an update event is generated;
  //     );
  //
  //     Geolocator.getPositionStream(locationSettings: locationSettings)
  //         .listen((Position position) {
  //       print(position.longitude); //Output: 80.24599079
  //       print(position.latitude); //Output: 29.6593457
  //
  //       long = position.longitude.toString();
  //       lat = position.latitude.toString();
  //       emit(GetLocationState());
  //     });
  //     emit(GetLocationState());
  //   }catch(e){
  //     print(e);
  //   }
  //
  //
  // }

  getAddress() async {
    await getLocation();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    palcename = "${placemarks.first.administrativeArea}";
    emit(UpdateLocationPosition());
  }
}
