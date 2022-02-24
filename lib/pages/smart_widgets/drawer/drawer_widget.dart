import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/smart_widgets/drawer/drawer_widget_viewmodel.dart';
import 'package:my_grocery_list/pages/smart_widgets/mydrawer.dart';
import 'package:my_grocery_list/services/auth.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:package_info/package_info.dart';
import 'package:stacked/stacked.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  final log = getLogger('DrawerWidget');
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
    return ViewModelBuilder<DrawerWidgetViewModel>.nonReactive(
      builder: (context, model, child) => Drawer(
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
      ),
      viewModelBuilder: () => DrawerWidgetViewModel(),
    );
  }
}
