import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/models/user_model.dart';
import 'package:my_grocery_list/services/database.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:my_grocery_list/shared/my_extensions.dart';
import 'package:my_grocery_list/utils/logging.dart';
import 'package:provider/provider.dart';

class AddCatagoryButton extends StatefulWidget {
  const AddCatagoryButton({
    Key? key,
  }) : super(key: key);

  @override
  _AddCatagoryButtonState createState() => _AddCatagoryButtonState();
}

class _AddCatagoryButtonState extends State<AddCatagoryButton> {
  final GlobalKey<FormState> _popUpAddCatagoryformKey = GlobalKey<FormState>();
  final TextEditingController _catagoryNametextFieldController =
      TextEditingController();
  bool _addItemTextStatus = false;
  late String _catagoryName;
  bool _validate = false;
  final log = logger(AddCatagoryButton);
  // ---------------------------------------------------------------------------
  @override
  void dispose() {
    _catagoryNametextFieldController.dispose();

    super.dispose();
  }

//------------------------------------------------------------------------------
  void _addItemButtonVerification(BuildContext context) {
    // Check if Item Name field is empty then show message
    if (_popUpAddCatagoryformKey.currentState!.validate()) {
      setState(() {
        _addItemTextStatus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final String userId = user?.uid ?? '';
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('New Catagory Name'),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _popUpAddCatagoryformKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _catagoryNametextFieldController,
                            onChanged: (String text) {
                              _catagoryName = text.capitalize();
                            },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Catagory Name can not be empty';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Catagory Name',
                              labelText: 'Catagory Name',
                            ),
                          ),
                          kSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  final FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }

                                  _addItemButtonVerification(context);
                                  if (_catagoryNametextFieldController
                                      .text.isNotEmpty) {
                                    log.i('catagoryName: $_catagoryName');
                                    await DatabaseService(uid: userId)
                                        .addCatagory(
                                            catagoryName: _catagoryName);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
            });
      },
      child: const Icon(CupertinoIcons.add),
    );
  }
}
