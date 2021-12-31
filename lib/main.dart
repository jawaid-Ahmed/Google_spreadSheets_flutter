import 'package:flutter/material.dart';
import 'package:google_spreadsheets_flutter/api/sheets/attendance_model.dart';
import 'package:google_spreadsheets_flutter/api/sheets/model_fields_names.dart';
import 'package:google_spreadsheets_flutter/api/sheets/google_sheet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  UserSheetApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoogleSheets'),elevation: 0.0,),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),

          ),
          child: ElevatedButton(
            onPressed: () async {
             insertRow();

            },
            child: const Text('Get Data',style: TextStyle(color: Colors.white,fontSize: 24,),),
          ),
        ),
      ),
    );
  }

  void insertRow() async{
    List<Map<String, dynamic>> listofJson=[];

    for(int i=1; i<10; i++){
      listofJson.add(Attendance("$i", "5$i", "SomeOne", "$i/12/2021").toJson());
    }

    //final jsonAttendance=listofJson.map((attendance) => attendance.toJson()).toList();

    await UserSheetApi.insertRow(listofJson);
  }
}


