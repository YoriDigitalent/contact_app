part of 'pages.dart';

class DetailPage extends StatelessWidget {
  final DataContact dataContact;

  const DetailPage({Key key, this.dataContact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          //note: HEADER
          Container(
              height: 500,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              padding:
                  EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 30),
              child: Center(
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/profil_avatar.png'),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Name:    ',
                      style: whiteTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "$dataContact",
                      style: whiteTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ]),
                ]),
              )),
          SizedBox(
            height: 25,
          ),
          // note: TEXT
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Email:    ',
                style: purpleTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                "$dataContact",
                style: purpleTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ]),
          ),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
