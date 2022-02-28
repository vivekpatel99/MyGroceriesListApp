import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.logger.dart';
import 'package:my_grocery_list/pages/smart_widgets/drawer/drawer_widget_viewmodel.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:package_info/package_info.dart';
import 'package:stacked/stacked.dart';

class DrawerWidgetView extends StatelessWidget {
  DrawerWidgetView({Key? key}) : super(key: key);

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
                  const MyDrawerHeader(),
                  createDrawerBodyItem(
                    icon: Icons.email_sharp,
                    title: 'Contact',
                    onTap: model.contactInfoOnTap,
                  ),
                  createDrawerBodyItem(
                    icon: Icons.coffee_sharp,
                    title: 'Buy me Coffee',
                    onTap: model.buyMeACoffeeOnTap,
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
                      model.signOut();
                      model.goBackToSignInPage();
                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).colorScheme.secondary,
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

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerWidgetViewModel>.nonReactive(
      builder: (context, model, child) => DrawerHeader(
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
                Text(
                  model.getUserName().toString(), //'Vivek Patel',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  model.getEmailAddress(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      viewModelBuilder: () => DrawerWidgetViewModel(),
    );
  }
}

//--------------------------------------------------------------------------------------------
class DeleteAllData extends StatefulWidget {
  const DeleteAllData({Key? key}) : super(key: key);

  @override
  _DeleteAllDataState createState() => _DeleteAllDataState();
}

//--------------------------------------------------------------------------------------------
class _DeleteAllDataState extends State<DeleteAllData> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete All Data!!'),
      content: const Text('Are you sure to delete?'),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            /* ///////////////////////////////////////////// */
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
