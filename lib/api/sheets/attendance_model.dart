import 'package:google_spreadsheets_flutter/api/sheets/model_fields_names.dart';

class Attendance{

  String id;
  String userId;
  String userName;
  String date;

  Attendance(this.id, this.userId, this.userName, this.date);

  Map<String ,dynamic> toJson() =>{
    AttendanceFields.id:id,
    AttendanceFields.userId:userId,
    AttendanceFields.userName:userName,
    AttendanceFields.date:date,
  };
}