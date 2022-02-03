import 'dart:convert';

DoctorInfoModel doctorInfoModelFromJson(String str) =>
    DoctorInfoModel.fromJson(json.decode(str));

String doctorInfoModelToJson(DoctorInfoModel data) =>
    json.encode(data.toJson());

class DoctorInfoModel {
  DoctorInfoModel({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  bool status;
  String statusMessage;
  Data data;

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) =>
      DoctorInfoModel(
        status: json["status"] ?? false,
        statusMessage: json["statusMessage"] ?? '',
        data: Data.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusMessage": statusMessage,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.information,
  });

  Information information;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        information: Information?.fromJson(json["information"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "information": information.toJson(),
      };
}

class Information {
  Information({
    required this.id,
    required this.name,
    required this.photoName,
    required this.specialization,
    required this.profileViews,
    required this.patients,
    required this.experience,
    required this.rate,
  });

  int id;
  String name;
  String photoName;
  String specialization;
  int profileViews;
  int patients;
  int experience;
  double rate;

  factory Information.fromJson(Map<String, dynamic> json) => Information(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        photoName: json["photoName"] ?? '',
        specialization: json["specialization"] ?? '',
        profileViews: json["profileViews"] ?? 0,
        patients: json["patients"] ?? 0,
        experience: json["experience"] ?? 0,
        rate: json["rate"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoName": photoName,
        "specialization": specialization,
        "profileViews": profileViews,
        "patients": patients,
        "experience": experience,
        "rate": rate,
      };
}
