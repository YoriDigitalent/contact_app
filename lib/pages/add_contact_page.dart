part of 'pages.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final formProvider = Provider.of<FormulirBloc>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 40),
                  height: 50,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back, color: mainColor),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Add Contact",
                          style: purpleTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Tambahkan Data Karyawan",
                    style: purpleTextFont.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Name",
                      hintText: "Name",
                    )),
                SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: jobController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Job",
                      hintText: "Job",
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 300,
                  height: 50,
                  margin: EdgeInsets.only(top: 40, bottom: 15),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Add Data",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                      color: mainColor,
                      onPressed: () {
                        if (!(nameController.text.trim() != "" &&
                            jobController.text.trim() != "")) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Colors.redAccent,
                            message: "Ada form yang belum terisi",
                          )..show(context);
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BerandaPage()),
                          );

                          AddDataServices.addDataContact(
                              nameController.text, jobController.text);
                        }
                      }),
                ),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
