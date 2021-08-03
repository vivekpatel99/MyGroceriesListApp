import 'package:flutter/material.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/utils/logging.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const MyDrawerHeader(),
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
            child: createDrawerBodyItem(
              icon: Icons.logout_sharp,
              title: 'Sign Out',
              onTap: () async {
                log.i('Sign Out');
                await _auth.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            children: const [
              Text(
                'Vivek Patel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'VivekPatel99@gmail.com',
                style: TextStyle(
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
