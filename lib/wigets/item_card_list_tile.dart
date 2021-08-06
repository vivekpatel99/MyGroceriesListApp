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

  static const String assetsPath = 'assets/images/';

  static const String imageExt = '.png';

  @override
  Widget build(BuildContext context) {
    final String firstLettter = name[0];

    final String imagePath = '$assetsPath${name.toLowerCase()}$imageExt';
    // final String imagePath = 'assets/images/broccoli.png';

    Future<AssetImage?> checkImageExist(String imagePath) async {
      try {
        await rootBundle.load(imagePath);
        return AssetImage(imagePath);
      } catch (e) {
        log.e(e.toString());
        return null;
      }
    }

    return FutureBuilder(
      future: checkImageExist(imagePath),
      builder: (BuildContext context, snapshot) {
        final _data = snapshot.data;
        return SizedBox(
          height: 70,
          child: Card(
            child: tobuy
                ? ListTile(
                    // dense: true,
                    leading: CircleAvatar(
                      foregroundImage:
                          (_data != null) ? AssetImage(imagePath) : null,
                      child: (_data != null) ? null : Text(firstLettter),
                    ),
                    title: Text(name),
                    subtitle: const Text('Quantity'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('€2.99'),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          // color: Colors.deepPurpleAccent,
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ))
                : const SizedBox(),
          ),
        );
      },
    );
  }
}
