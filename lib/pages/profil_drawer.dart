part of 'pages.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerItem(
              icon: Icons.home,
              text: 'Beranda',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BerandaPage(),
                    ),
                  )),
          _drawerItem(
            icon: Icons.person_add,
            text: 'Your Profil',
            onTap: () {},
          ),
          _drawerItem(
              icon: Icons.list,
              text: 'List Contact',
              onTap: () => print('Tap Top Related')),
          _drawerItem(
              icon: Icons.logout,
              text: 'Sign Out',
              onTap: () {
                sharedPreferences.containsKey("token");
                sharedPreferences.clear();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              }),
          Divider(height: 25, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
            child: Text("Labels",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
          ),
          _drawerItem(
              icon: Icons.question_answer,
              text: 'About',
              onTap: () => print('Tap About')),
        ],
      ),
    );
  }
}

Widget _drawerHeader() {
  return UserAccountsDrawerHeader(
    decoration: BoxDecoration(color: mainColor),
    currentAccountPicture: ClipOval(
      child: Image(
          image: AssetImage('assets/profil_avatar.png'), fit: BoxFit.cover),
    ),
    accountName: Text('Contact App'),
    accountEmail: Text('test@reqres.in'),
  );
}

Widget _drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text,
            style: blackTextFont,
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
