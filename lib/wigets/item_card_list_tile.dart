import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_grocery_list/utils/logging.dart';

class ItemCardListTile extends StatelessWidget {
  final bool tobuy;
  final String name;
  ItemCardListTile({
    Key? key,
    required this.tobuy,
    required this.name,
  }) : super(key: key);

  final log = logger(ItemCardListTile);

  String assetsPath = 'assets/images/';

  String imageExt = '.png';

  @override
  Widget build(BuildContext context) {
    final String firstLettter = name[0];
    // AssetImage? imageAssets;
    String imagePath = '$assetsPath${name.toLowerCase()}$imageExt';
    // final String imagePath = 'assets/images/broccoli.png';

    Future<AssetImage?> checkImageExist(String imagePath) async {
      try {
        await rootBundle.load(imagePath);
        return AssetImage(imagePath);
      } catch (e) {
        print('xxxxxxxxxxxxx');
        print(e.toString());
        return null;
      }
    }

    return FutureBuilder(
      future: checkImageExist(imagePath),
      builder: (BuildContext context, snapshot) {
        print('DAAATAAAA ${snapshot.data} $imagePath');
        print('##########${snapshot.error}');
        return Card(
          child: tobuy
              ? ListTile(
                  leading: CircleAvatar(
                    foregroundImage:
                        (snapshot.data != null) ? AssetImage(imagePath) : null,
                    child: Text(firstLettter),
                  ),
                  title: Text(name),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
