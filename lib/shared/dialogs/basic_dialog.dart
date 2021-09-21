import 'package:flutter/material.dart';
import 'package:my_grocery_list/enums/basic_dialog_status.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/shared/styles.dart';
import 'package:my_grocery_list/pages/authenticate/dumb_widgets/shared/ui_helpers.dart';
import 'package:my_grocery_list/shared/constants.dart';
import 'package:stacked_services/stacked_services.dart';

// Todo  Create dubm widget to use dialog in multiple places
class BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const BasicDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: _BasicDialogContent(request: request, completer: completer),
    );
  }
}

class _BasicDialogContent extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialogContent({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenHeightPercentage(context, percentage: 0.04),
          ),
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              kVerticalSpaceSmall,
              Text(
                request.title ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              kVerticalSpaceSmall,
              Text(
                request.description ?? '',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              kVerticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (request.secondaryButtonTitle != null)
                    TextButton(
                      onPressed: () =>
                          completer(DialogResponse(confirmed: false)),
                      child: Text(
                        request.secondaryButtonTitle!,
                      ),
                    ),
                  TextButton(
                      onPressed: () =>
                          completer(DialogResponse(confirmed: true)),
                      child: Text(request.mainButtonTitle ?? ''))
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -28,
          child: CircleAvatar(
            minRadius: 16,
            maxRadius: 28,
            backgroundColor: _getStatusColor(request.customData),
            child: Icon(
              _getStatusIcon(request.customData),
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(dynamic customData) {
    if (customData is BasicDialogStatus) {
      switch (customData) {
        case BasicDialogStatus.error:
          return kcRedColor;
        case BasicDialogStatus.warning:
          return kcOrangeColor;
        default:
          return kcPrimaryColor;
      }
    } else {
      return kcPrimaryColor;
    }
  }

  IconData _getStatusIcon(dynamic regionDialogStatus) {
    if (regionDialogStatus is BasicDialogStatus) {
      switch (regionDialogStatus) {
        case BasicDialogStatus.error:
          return Icons.close;
        case BasicDialogStatus.warning:
          return Icons.warning_amber;

        default:
          return Icons.check;
      }
    } else {
      return Icons.check;
    }
  }
}
