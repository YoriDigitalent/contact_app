part of 'pages.dart';

class BerandaPage extends StatefulWidget {
  final DataContact dataContact;
  const BerandaPage({Key key, this.dataContact}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  SharedPreferences sharedPreferences;

  loginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }

  String apiUrl = "https://reqres.in/api/users?page=2";

  Future<List<Map<String, dynamic>>> getAllData() async {
    var response = await http.get(apiUrl);
    if (response.statusCode != 200) return null;
    return List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
  }

  Future<List<Map<String, dynamic>>> _future;
  @override
  void initState() {
    super.initState();
    _future = getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact'),
          backgroundColor: mainColor,
        ),
        drawer: DrawerWidget(),
        body: ListView(children: <Widget>[
          Container(
            height: 600,
            child: RefreshIndicator(
                onRefresh: () async {
                  _future = getAllData();
                  setState(() {});
                  return _future;
                },
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getAllData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    snapshot.data[index]['avatar']),
                              ),
                              title: Text(snapshot.data[index]['first_name'] +
                                  " " +
                                  snapshot.data[index]['last_name']),
                              subtitle: Text(snapshot.data[index]['email']),
                              onTap: () {
                                // GetDataContact.getData(
                                //     snapshot.data[index]['id']);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DetailPage()));
                              },
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ),

          // Add Button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
              child: ClipOval(
                child: Material(
                  color: Colors.purple.shade300, // button color
                  child: InkWell(
                    splashColor: Colors.white, // inkwell color
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AddContactPage()));
                    },
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
