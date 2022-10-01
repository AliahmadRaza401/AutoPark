import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/services/mapServices.dart';

import '../models/singleParkingData.dart';

class GetAllParkingProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  SingleParkingDataModel? singleParkingInstance;
  bool singleParkingloading = false;
  bool allMarkerAdded = false;
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Marker> markers = Set();
  final LatLng initialLatLng = LatLng(30.029585, 31.022356);
  GoogleMapController? myController;
  late LatLng currentLaltg;
  bool allParkingloading = false;
  bool mapTypeValue = false;
  var totalPriceofParking;
  int? totalPrkingTime;
  var subTotal;
  var tenPersentofPayment;
  var endParkingDateTime;
  var startParkingDateTime;

  setprkingstartDateTime(value) {
    startParkingDateTime = value;
    notifyListeners();
  }

  setprkingEndDateTime(value) {
    endParkingDateTime = value;
    notifyListeners();
  }

  void timeDifference() {
    totalPrkingTime = DateTime.parse(endParkingDateTime)
        .difference(DateTime.parse(startParkingDateTime))
        .inHours;

    log('totalParkingTime = $totalPrkingTime');
    totalPriceofParking = totalPrkingTime! *
        int.parse(singleParkingInstance!.parkingPrice.toString());

    log('totalPriceofParking = $totalPriceofParking');
    tenPersentofPayment = totalPriceofParking * 0.1;
    log('tenPersentofPayment = $tenPersentofPayment');
    subTotal = tenPersentofPayment + totalPriceofParking;
  }

  setMapTypeFun(bool val) {
    mapTypeValue = val;
    notifyListeners();
  }

  setLoading(bool val) {
    allParkingloading = val;
    // notifyListeners();
  }

  singleelementParkingloading(bool val) {
    // singleParkingloading = false;
    singleParkingloading = val;
    notifyListeners();
  }

  List<SingleParkingDataModel> allParkingDetails = [];

  saveDataintoList(List<SingleParkingDataModel> details) {
    allParkingDetails.clear();
    allParkingDetails.addAll(details);
    notifyListeners();
  }

  locatePosition() async {
    print('i am in the location function');
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    LocationPermission status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      print("Location is Off =======================>>");
    } else {
      print("Location is ON =======================>>");
      // Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      print('location 1 ');
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      print('location 2 ');
      print('position: $position');
      var currentPosition = position;
      currentLaltg = LatLng(position.latitude, position.longitude);
      print('currentLaltg: $currentLaltg');
      LatLng emulatorCurrentLocation =
          const LatLng(31.475358308308135, 74.30971891451699);
      // CameraPosition cameraPosition =
      //     CameraPosition(target: currentLaltg, zoom: 14);
      CameraPosition cameraPosition =
          CameraPosition(target: emulatorCurrentLocation, zoom: 14);
      myController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      print('Marker is going to add ');
      // addmarkers(currentLaltg);
      addmarkers(emulatorCurrentLocation);
      drawParkingMarker();
      print('Marker is added ');
      notifyListeners();
    }
  }

  void drawParkingMarker() async {
    print('drawParkingMarker function running');
    final Uint8List markerIcon = await MapServices.getMarkerWithSize(80);
    allParkingDetails.forEach((element) {
      var latitude = element.parkingLocationLatitude;
      var longitude = element.parkingLocationLongitude;
      var parkingId = element.parkingName;

      markers.add(
        Marker(
          onTap: () {
            singleParkingInstance = element;
            singleelementParkingloading(true);
            allMarkerAdded = true;
          },
          markerId: MarkerId(parkingId!),
          position: LatLng(latitude!, longitude!),
          infoWindow: InfoWindow(title: parkingId),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );
    });
    // allMarkerAdded = true;
    print('All Marker Added');
    notifyListeners();
  }

  void addmarkers(showLocation) async {
    final Uint8List markerIcon =
        await MapServices.getMarkerWithSizeandWithoutContedt(160);

    markers.add(
      Marker(
        markerId: const MarkerId('driver'),
        position: showLocation,
        infoWindow: const InfoWindow(title: 'Driver'),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(markerIcon),
      ),
    );

    notifyListeners();
  }
}
