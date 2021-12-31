import 'package:google_spreadsheets_flutter/api/sheets/model_fields_names.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi{

  static const credentials=r'''
  
  {
  "type": "service_account",
  "project_id": "flutter-attendance-331907",
  "private_key_id": "69c07e0019c56f012d0e140e347dbbfc7cb28fc1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCYnQ6C1Fg0MPa9\nU63ddmRkL0MuQEJvVhhg1KhJedQsrPirYSuRJjOIJm+VVcj29n9F2ZEH2QrZ2RyZ\na9eNrK7gbesZ2o9p8T2Wc3RPDo9aMgaZx7ADPh7czEBRoqSzj3thw9uw46krftqW\nDCmmzKCa3xIBgHqCI390rb/h0PCdFgdmceNFmBS+Nsm1IYR4OGNzG/ASPRUg5cV2\n4uUtqQzoqbI8ZHR/4tIk7WKnEaLKUam27c7uYZZ8Jl5qnD0bREKpFEuVYQQZfWa9\n1qMhBNzxud9jWO4XFbsrrf5ad4xOd4pJaSGsrxD0FTXiwKVU0WEUiOx+iVHc64Ai\nNfOoEssBAgMBAAECggEAAZIxrAxzkVX6XvNAPvS7uSxODL6B8JN6Uhozq/iiboij\n/ApWtc/Rh/1H+MmWoAmO6zEqL7fUR28svtzqrdKxRNjc1WSimqdDyGC35Hh0kVZ3\n1ZgbVRfhSXSbf5D6Zml7uQNDJ7cFmXpc1bPvryqRcga0hhTEg20fdXFfIFFTqMpP\n3D04plg1LNeR5kRgelst4U7q6Rdg5Cn9oSCzseab1u/cEMBq2FxMOln3y7A7chR8\nj+fdf5jTaTd4tgjyKRyXYf/Q7KdSgJ1gVH4sqRy/fNqDHybgA56DiOFyp60o6bsT\nQLX+SqTZdqLC6+xEt+btPVSBcHvmxnkeQOPgx4EgAQKBgQDLmpAprO14VuRTF5sJ\nG5Xz5pru6Vci/VFe5z+vzgsQZJFo2zVFfiOwc6d5/gt0tNYhmqIAPSOZSZHYpYcC\nGrwLXUKi31MG97r0RfMJa/Tt8bqCEj5I0GE9Xb9+AqPOVuu71d4SusqNxUp9Hgck\npJ42q/3/n427etGRcKN1l4/JoQKBgQC/4z//EsaeiO/HX3G1hLukfIR2iCf55slZ\nPElY0BIyEFnuFJsZdm96PJUH57+ttmTGMOCGCuvmKWQ71qrpRc/eyZfitvkPXoRd\nhZxVK+1NgcSvqGDHvqmumnXCsvbu9QVcstFBS8SZIg7v6HJt53sUjlTAes5VvDJy\nfCWXFt9FYQKBgFhRN2+cf3XP20Lf3nRY7vbZdSNlPFMFJyLPlKSh79KwjRK646S9\nTqXfxSn5tOZu+uOgu9z2qFZ5vzYGt0WGa0NStPEJhm5jT0lefkn79kawsIJzf2j+\nWu/Plp0GcB+1PJRB9Q6S0AInLmSPffG7JpX4jTkw8L3+TKGWBpGfqNOBAoGAEc1D\nYqabRpntpNF1+yEVR21F3LlE/CotA9pT86laBsr9jNjcisAyF2UHbnRRlAwXzUs7\niTP6LqAobGS99mZDoqeRL7dJ4+Mg5IxAtKYendIsLR+x2tYVZ91sj2OLBSA2HyN3\nxlcBJjPCrv8hnpCbGo0Zz8GU4t9Szsw1sI6uqAECgYB5OOAxgE+uhV1U69cq4xkR\nBHcuFyQ2BPxdvVqjag8u+d1hqVwL0+J6dbQpmFcxMZq2QLMhVpWp2ulG0dvugpi3\n67vbZfDUvZFWW3rIM+Clq8s7F4XY8emEVMH1WRiFCPEBFGb8Sq8iUzVq4+gmdUjM\nCehCItLzMyLmk8rVnpXvlw==\n-----END PRIVATE KEY-----\n",
  "client_email": "attendace-app-sheets@flutter-attendance-331907.iam.gserviceaccount.com",
  "client_id": "103899981795797516282",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/attendace-app-sheets%40flutter-attendance-331907.iam.gserviceaccount.com"
}
  
  ''';

  static final spreadSheetId='1GnsgP9sUunP4wRbTX9dFbNeKt5nJDHjCSLK_hwS0Kcc';

  static final gsheets=GSheets(credentials);
  static Worksheet? worksheet;

  static Future init() async {
    try {
      final spreadSheed=await gsheets.spreadsheet(spreadSheetId);
      worksheet=await getWorkSheet(spreadSheed,title:'Attendance');

      final firstRow=AttendanceFields.getFields();
      worksheet!.values.insertRow(1, firstRow);
    } on Exception catch (e) {
      print('google sheet init error: $e');
    }
  }

  static Future<Worksheet?> getWorkSheet(
      Spreadsheet spreadSheed,
      {required String title
      }) async{
    try{
      return await spreadSheed.addWorksheet(title);
    }catch(e){
      return await spreadSheed.worksheetByTitle(title);
    }
  }

  static Future insertRow(List<Map<String,dynamic>> rowList)async{
    if(worksheet==null) return;
    worksheet!.values.map.appendRows(rowList);
  }

  static Future<int> getRowCount()async{
    if(worksheet==null) return 0;

    var lastRow=await worksheet!.values.lastRow();
    return lastRow==null ? 0 : int.tryParse(lastRow.first) ?? 0 ;

  }
}