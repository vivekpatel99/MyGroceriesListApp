import 'package:flutter/material.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:package_info/package_info.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();
  final log = logger(MyDrawer);
  Widget createDrawerBodyItem(
      {required IconData icon,
      required String title,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: kDrawerManuTextStyle,
      ),
      onTap: onTap,
    );
  }

//------------------------------------------------------------------------------
  Future<String> _myPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                MyDrawerHeader(),
                createDrawerBodyItem(
                  icon: Icons.reset_tv_sharp,
                  title: 'Reset',
                  onTap: () {},
                ),
                createDrawerBodyItem(
                  icon: Icons.email_sharp,
                  title: 'Contact',
                  onTap: () {},
                ),
                createDrawerBodyItem(
                  icon: Icons.coffee_sharp,
                  title: 'Buy me Coffee',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                createDrawerBodyItem(
                  icon: Icons.logout_sharp,
                  title: 'Sign Out',
                  onTap: () async {
                    log.i('Sign Out');
                    await _auth.signOut();
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).accentColor,
                  child: Center(
                    child: FutureBuilder(
                      future: _myPackageInfo(),
                      builder: (BuildContext context, snapshot) => Text(
                        snapshot.hasData
                            ? 'App Version ${snapshot.data}'
                            : 'Laoding....',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//------------------------------------------------------------------------------
class MyDrawerHeader extends StatelessWidget {
  MyDrawerHeader({
    Key? key,
  }) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final String _email = _auth.getemailAdrress;

    return DrawerHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/background.png'),
            radius: 40.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vivek Patel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                _email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
