part of 'pages.dart';

class DetailPage extends StatelessWidget {
  final DataContact dataContact;

  const DetailPage({Key key, this.dataContact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 30),
            child: Center(
              child: Column(children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(dataContact.avatar),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  '${dataContact.name}',
                  style: whiteTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ]),
            )),
        SizedBox(
          height: 25,
        ),
        //note: TEXT
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            "Ada yang bisa Kami bantu?",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        //note: TOMBOL
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
