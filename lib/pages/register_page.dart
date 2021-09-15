part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool _isLoading = false;

  var errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Container(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back, color: mainColor),
                      ),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Buat Akun Baru",
                            style: purpleTextFont.copyWith(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                isEmailValid = EmailValidator.validate(text);
                              });
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Alamat Email",
                                hintText: "Email"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                isPasswordValid = text.length >= 6;
                              });
                            },
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Password",
                                hintText: "Password"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(top: 60, bottom: 40),
                            child: FloatingActionButton(
                                child: Icon(Icons.arrow_forward,
                                    color: isEmailValid && isPasswordValid
                                        ? Colors.white
                                        : Colors.white30),
                                backgroundColor: isEmailValid && isPasswordValid
                                    ? mainColor
                                    : Colors.blueGrey,
                                onPressed: isEmailValid && isPasswordValid
                                    ? () async {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        // tampilan pesan
                                        if (!(emailController.text.trim() !=
                                                "" &&
                                            passwordController.text.trim() !=
                                                "")) {
                                          Flushbar(
                                            duration: Duration(seconds: 4),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Colors.redAccent,
                                            message:
                                                ("Isi email dan password dengan benar!"),
                                          )..show(context);
                                        } else {
                                          register(emailController.text,
                                              passwordController.text);
                                        }
                                      }
                                    : null),
                          ),
                        ]),
                  ],
                ),
        ),
      ),
    );
  }

  register(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var response =
        await http.post("https://reqres.in/api/register", body: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => SplashPage()));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
  }
}
