class ProfileModel {
  String? email;
  String? mobileNimber;
  String? name;
  String? userImage;
  ProfileModel({
    this.email,
    this.mobileNimber,
    this.name,
    this.userImage,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        email: json['email'] == null ? '' : json['email'].toString(),
        mobileNimber:
            json['mobileNumber'] == null ? '' : json['mobileNumber'].toString(),
        name: json['fullName'] == null ? '' : json['fullName'].toString(),
        userImage: json['image'] == null ? '' : json['image'].toString(),
      );
}
