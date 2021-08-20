import 'package:my_grocery_list/models/item_model.dart';

/// This file contains the test data used in tests to remove non-deterministing behavior
const Map<String, num> firebaseResponseMap = {
  'cheese': 2.99,
  'butter': 1.99,
  'apples': 1.99,
  'marcha': 2.50,
  'lot': 11
};
const String catagoryName = 'Dairy';
final Catagory dairy = Catagory(name: 'milk', price: 0.99, quantity: '');
final Catagory cheese = Catagory(name: 'cheese', price: 2, quantity: '');
final Catagory apples = Catagory(name: 'apples', price: 0, quantity: '');

final List<Catagory> catagoryItems = [dairy, cheese, apples];
