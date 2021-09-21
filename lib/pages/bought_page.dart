

// class BoughtPage extends StatelessWidget {
//   final log = logger(BoughtPage);
//   @override
//   Widget build(BuildContext context) {
//     // context.read<TotalPriceViewModel>().reset();
//     context.read<TotalPriceViewModelOld>().reset();
//     try {
//       return DisplayNestedListView(groceryList: groceryList, onBuyPage: onBuyPage)(onBuyPage: false);
//     } catch (error) {
//       log.e('$error');
//       log.i('Returning to Loading page');
//       return const Loading();
//     }
//   }
// }
