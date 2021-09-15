part of 'services.dart';

class AddDataServices {
  static Future<Data> addDataContact(String name, String job) async {
    String apiURL = "https://reqres.in/api/users";

    var apiResult = await http.post(apiURL, body: {"name": name, "job": job});

    var jsonObject = json.decode(apiResult.body);

    return Data.addContact(jsonObject);
  }
}
