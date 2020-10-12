import 'package:flutter/cupertino.dart';
import 'package:roashan/models/cartModel.dart';


class FavoriteProvider with ChangeNotifier {
  List<CartModel> favoriteList = new List<CartModel>();

  // List<CartModel> get getCartList => cartList;
  addToFav(CartModel cartItem) {
    favoriteList.add(cartItem);
    notifyListeners();
  }
}
