class SingleParkingDataModel {
  String? docId;
  String? bookedStatus;
  String? bookedTime;
  String? bookerId;
  String? createdAt;
  String? description;
  bool? gragevalue;
  String? parkingimage;
  String? parkingLocation;
  double? parkingLocationLatitude;
  double? parkingLocationLongitude;
  String? parkingName;
  String? parkingPrice;
  String? parkingType;
  String? postalCode;
  bool? roofValue;
  String? ownerId;
  String? startTime;
  String? endTime;
  String? totalTime;
  String? totalPrice;
  bool? bookMark;
  String? uniqueParkingId;

  SingleParkingDataModel({
    this.docId,
    this.bookedStatus,
    this.bookedTime,
    this.bookerId,
    this.createdAt,
    this.description,
    this.gragevalue,
    this.parkingimage,
    this.parkingLocation,
    this.parkingLocationLatitude,
    this.parkingLocationLongitude,
    this.parkingName,
    this.parkingPrice,
    this.parkingType,
    this.postalCode,
    this.roofValue,
    this.ownerId,
    this.startTime,
    this.endTime,
    this.totalPrice,
    this.totalTime,
    this.bookMark,
    this.uniqueParkingId,
  });

  factory SingleParkingDataModel.fromJson(Map<String, dynamic> json) =>
      SingleParkingDataModel(
        docId: json['docId'] == null ? '' : json['docId'].toString(),
        bookedStatus:
            json['bookedStatus'] == null ? '' : json['bookedStatus'].toString(),
        bookedTime:
            json['bookedTime'] == null ? '' : json['bookedTime'].toString(),
        bookerId: json['bookerID'] == null ? '' : json['bookerID'].toString(),
        createdAt: json['createdAt'] == null
            ? DateTime.now().toString()
            : json['createdAt'].toString(),
        description:
            json['description'] == null ? '' : json['description'].toString(),
        gragevalue: json['garageValue'] ?? false,
        parkingimage:
            json['parkingImg'] == null ? '' : json['parkingImg'].toString(),
        parkingLocation: json['parkingLocation'] == null
            ? ''
            : json['parkingLocation'].toString(),
        parkingLocationLatitude: json['parkingLocationLatitude'] ?? 0.0,
        parkingLocationLongitude: json['parkingLocationLongitude'] ?? 0.0,
        parkingName:
            json['parkingName'] == null ? '' : json['parkingName'].toString(),
        parkingPrice:
            json['parkingPrice'] == null ? '' : json['parkingPrice'].toString(),
        parkingType:
            json['parkingType'] == null ? '' : json['parkingType'].toString(),
        postalCode:
            json['postalCode'] == null ? '' : json['postalCode'].toString(),
        roofValue: json['roofValue'] ?? false,
        ownerId: json['uid'] == null ? '' : json['uid'].toString(),
        startTime:
            json['startTime'] == null ? '' : json['startTime'].toString(),
        endTime: json['endTime'] == null ? '' : json['endTime'].toString(),
        totalPrice:
            json['totalPrice'] == null ? '' : json['totalPrice'].toString(),
        totalTime:
            json['totalTime'] == null ? '' : json['totalTime'].toString(),
        bookMark: json['bookmark'] ?? false,
        uniqueParkingId:  json['parkingUniqueId'] == null ? '' : json['parkingUniqueId'].toString(),
      );

  data() {}
}
