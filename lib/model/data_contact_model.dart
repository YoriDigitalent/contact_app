part of 'models.dart';

class DataContact {
  String id;
  String email;
  String name;
  String avatar;

  DataContact({this.id, this.email, this.name, this.avatar});

  factory DataContact.getData(Map<String, dynamic> object) {
    return DataContact(
        id: object['id'].toString(),
        email: object['email'],
        name: object['first_name'] + object['last_name'],
        avatar: object['avatar']);
  }
}
