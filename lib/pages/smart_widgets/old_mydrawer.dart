import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/smart_widgets/drawer/drawer_widget_view.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:package_info/package_info.dart';

//--------------------------------------------------------------------------------------------
class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  final log = getLogger('MyDrawer');
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

//--------------------------------------------------------------------------------------------
  Future<String> _myPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    // final String? userId = _auth.auth.currentUser?.uid;
    // final DatabaseService databaseService = DatabaseService(uid: userId);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                MyDrawerHeader(),
                createDrawerBodyItem(
                  icon: Icons.email_sharp,
                  title: 'Contact',
                  onTap: () {},
                ),
                createDrawerBodyItem(
                  icon: Icons.coffee_sharp,
                  title: 'Buy me a Coffee',
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
                    // await _auth.signOut();
                    //Routes.loginView;
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
                            : 'Loading....',
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

//--------------------------------------------------------------------------------------------
class AlertDialogButton extends StatelessWidget {
  const AlertDialogButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

//--------------------------------------------------------------------------------------------
