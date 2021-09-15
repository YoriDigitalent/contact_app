part of 'models.dart';

class Data {
  String id;
  String name;
  String job;
  String created;

  Data({this.id, this.name, this.job, this.created});

  factory Data.addContact(Map<String, dynamic> object) {
    return Data(
        id: object['id'],
        name: object['name'],
        job: object['job'],
        created: object['createdAt']);
  }
}
