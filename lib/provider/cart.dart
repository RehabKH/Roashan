import 'package:flutter/cupertino.dart';
import 'package:roashan/models/cartModel.dart';

class Cart with ChangeNotifier {
  List<CartModel> cartList = new List<CartModel>();

  List<CartModel> get getCartList => cartList;
  addToCart(CartModel cartItem) {
    cartList.add(cartItem);

    notifyListeners();
    print("new item from provider: " + cartItem.prodName);
    print("recent list: " + cartList.toString());
  }

  removeFromCart(CartModel cartItem) {
    cartList.remove(cartItem);
    notifyListeners();
  }

  int get cartListCount{
    return cartList.length;
  }
}
