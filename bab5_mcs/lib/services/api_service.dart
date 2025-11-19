import 'package:dio/dio.dart';
import 'package:mcs_bab_5/models/field1_model.dart';
import '../models/field2_model.dart';
import '../models/field3_model.dart';

class ApiService {
  Dio dio = Dio();

  final String readKey =
      "IW3FE5RVI5WEDIR3"; // SESUAIKAN DENGAN READ API KEYS PADA AKUN MASING-MASING

  String field1Url =
      "https://api.thingspeak.com/channels/3161641/fields/1/last.json?api_key="; // SESUAIKAN DENGAN CHANNEL ID PADA AKUN MASING-MASING
  String field2Url =
      "https://api.thingspeak.com/channels/3161641/fields/2/last.json?api_key="; // SESUAIKAN DENGAN CHANNEL ID PADA AKUN MASING-MASING
  String field3Url =
      "https://api.thingspeak.com/channels/3161641/fields/3/last.json?api_key="; // SESUAIKAN DENGAN CHANNEL ID PADA AKUN MASING-MASING

  // TEMPERATUR FIELD
  Future<Field1Model> getField1() async {
    try {
      final response = await dio.get("$field1Url$readKey");
      return Field1Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // HUMADITY FIELD
  Future<Field2Model> getField2() async {
    try {
      final response = await dio.get("$field2Url$readKey");
      return Field2Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // SOIL MOISTURE FIELD
  Future<Field3Model> getField3() async {
    try {
      final response = await dio.get("$field3Url$readKey");
      return Field3Model.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
