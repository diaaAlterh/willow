import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) =>
    ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  bool status;
  String statusMessage;
  Data data;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        status: json["status"],
        statusMessage: json["status_message"]??'',
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusMessage": statusMessage,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.appointment,
  });

  List<Appointment> appointment;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        appointment: json["appointment"] == null
            ? []
            : List<Appointment>.from(
                json["appointment"].map((x) => Appointment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "appointment": List<dynamic>.from(appointment.map((x) => x.toJson())),
      };
}

class Appointment {
  Appointment({
    required this.doctorId,
    required this.name,
    required this.photoName,
    required this.consultType,
    required this.status,
    required this.time,
  });

  int doctorId;
  String name;
  String photoName;
  String consultType;
  DateTime? time;
  String status;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        doctorId: json["id"],
        name: json["name"],
        photoName: json["photoName"],
        consultType: json["consultType"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": doctorId,
        "name": name,
        "photoName": photoName,
        "time": time?.toIso8601String(),
        "consultType": consultType,
        "status": status,
      };
}
