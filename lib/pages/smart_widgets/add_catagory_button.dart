import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/enums/dialog_type.dart';
import 'package:my_grocery_list/pages/smart_widgets/add_catagory_button_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'add_catagory_button.form.dart';

const String ksNewCatagoryName = 'New Catagory Name';
const String ksCatagoryName = 'catagory';

//--------------------------------------------------------------------------------------------
@FormView(fields: [
  FormTextField(name: ksCatagoryName),
])
class AddCatagoryButton extends StatelessWidget with $AddCatagoryButton {
  final DialogService _dialogService = locator<DialogService>();
  @override
  Widget build(
    BuildContext context,
  ) {
    return ViewModelBuilder<AddCatagoryButtonViewModel>.reactive(
        builder: (context, model, child) => FloatingActionButton(
              onPressed: () async {
                final dialgResult = await _dialogService.showCustomDialog(
                    variant: DialogType.form,
                    // customData: BasicDialogStatus.error,
                    // data: Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     TextField(
                    //       decoration:
                    //           const InputDecoration(labelText: ksNewCatagoryName),
                    //       controller: catagoryController,
                    //     )
                    //   ],
                    // ),
                    title: 'Add New Catagory',
                    secondaryButtonTitle: 'Cancel',
                    mainButtonTitle: 'Add');

                if (!dialgResult!.confirmed) {
                  print('confirmed ****************');
                }
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
        viewModelBuilder: () => AddCatagoryButtonViewModel());
  }
}
// class AddCatagoryButton extends StatefulWidget {
//   const AddCatagoryButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _AddCatagoryButtonState createState() => _AddCatagoryButtonState();
// }

// class _AddCatagoryButtonState extends State<AddCatagoryButton> {
//   final GlobalKey<FormState> _popUpAddCatagoryformKey = GlobalKey<FormState>();
//   final TextEditingController _catagoryNametextFieldController =
//       TextEditingController();
//   bool _addItemTextStatus = false;
//   late String _catagoryName;
//   bool _validate = false;
//   final log = logger(AddCatagoryButton);
//   // ---------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _catagoryNametextFieldController.dispose();

//     super.dispose();
//   }

// //------------------------------------------------------------------------------
//   void _addItemButtonVerification(BuildContext context) {
//     // Check if Item Name field is empty then show message
//     if (_popUpAddCatagoryformKey.currentState!.validate()) {
//       setState(() {
//         _addItemTextStatus = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserModel?>(context);
//     final String userId = user?.uid ?? '';
//     final CatagoryItemsViewModel catagoryItemsViewModel =
//         Provider.of<CatagoryItemsViewModel>(context);
//     return FloatingActionButton(
//       onPressed: () {
//         showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                   title: const Text('New Catagory Name'),
//                   content: SingleChildScrollView(
//                     child: Form(
//                       key: _popUpAddCatagoryformKey,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextFormField(
//                             controller: _catagoryNametextFieldController,
//                             onChanged: (String text) {
//                               _catagoryName = text.capitalize();
//                             },
//                             validator: (String? value) {
//                               if (value!.isEmpty) {
//                                 return 'Catagory Name can not be empty';
//                               }
//                               return null;
//                             },
//                             decoration: const InputDecoration(
//                               hintText: 'Enter Catagory Name',
//                               labelText: 'Catagory Name',
//                             ),
//                           ),
//                           kSizedBox,
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(
//                                 onPressed: () async {
//                                   final FocusScopeNode currentFocus =
//                                       FocusScope.of(context);
//                                   if (!currentFocus.hasPrimaryFocus) {
//                                     currentFocus.unfocus();
//                                   }

//                                   _addItemButtonVerification(context);
//                                   if (_catagoryNametextFieldController
//                                       .text.isNotEmpty) {
//                                     log.i('catagoryName: $_catagoryName');
//                                     catagoryItemsViewModel.addCatagory(
//                                         catagoryName: _catagoryName);
//                                     // await DatabaseService(uid: userId)
//                                     //     .addCatagory(
//                                     //         catagoryName: _catagoryName);
//                                     Navigator.pop(context);
//                                   }
//                                 },
//                                 child: Text(
//                                   'Add',
//                                   style: TextStyle(
//                                       color: Theme.of(context).accentColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20.0),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ));
//             });
//       },
//       child: const Icon(CupertinoIcons.add),
//     );
//   }
// }
