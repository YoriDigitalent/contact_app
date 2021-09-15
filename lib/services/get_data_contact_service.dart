part of 'services.dart';

class GetDataContact {
  static Future<DataContact> getData(String id) async {
    String apiURL = "https://reqres.in/api/users/" + id;

    var apiResult = await http.get(apiURL);
    var jsonData = json.decode(apiResult.body);
    var userData = (jsonData as Map<String, dynamic>)['data'];

    return DataContact.getData(userData);
  }
}
