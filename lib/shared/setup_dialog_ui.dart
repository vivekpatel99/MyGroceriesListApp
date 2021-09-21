import 'package:flutter/material.dart';
import 'package:my_grocery_list/app/app.locator.dart';
import 'package:my_grocery_list/enums/dialog_type.dart';
import 'package:my_grocery_list/shared/dialogs/basic_dialog.dart';
import 'package:my_grocery_list/shared/dialogs/form_dialog_layout.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();
  final builders = {
    DialogType.basic: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        BasicDialog(request: request, completer: completer),
    DialogType.form: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        FormDialogLayout(request: request, completer: completer),
  };
  dialogService.registerCustomDialogBuilders(builders);
}
