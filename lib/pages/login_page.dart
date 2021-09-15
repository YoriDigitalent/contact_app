part of 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  var errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Contact App",
                      style: purpleTextFont.copyWith(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Aplikasi ini untuk admin yang ingin mengelola data karyawan",
                      style: purpleTextFont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Login",
                      style: purpleTextFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
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
                    Row(children: <Widget>[
                      Text(
                        "Lupa Password? ",
                        style: blackTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Klik di sini",
                        style: purpleTextFont.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ]),
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 60, bottom: 30),
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
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
                                        isSigningIn = true;
                                      });

                                      // tampilan pesan
                                      if (!(emailController.text.trim() != "" &&
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
                                        signIn(emailController.text,
                                            passwordController.text);
                                      }
                                    }
                                  : null),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Belum punya akun? ",
                          style: blackTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                            child: Text(
                              "Sign Up",
                              style: purpleTextFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterPage()));
                            }),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var response = await http.post("https://reqres.in/api/login", body: data);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          isSigningIn = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => BerandaPage()));
      }
    } else {
      setState(() {
        isSigningIn = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
  }
}
