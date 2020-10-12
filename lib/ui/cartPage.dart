import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roashan/provider/cart.dart';

class CartPage extends StatelessWidget {
  // Cart cartList = new Cart();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
      ),
      body: Consumer<Cart>(
        // selector: (context, cartlist) => cartlist.getCartList,
        builder: (context, cartNotifier, widget) {
          //
          //
          return ListView.separated(
            itemCount: cartNotifier.cartList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(cartNotifier.cartList[index].prodName),
                trailing:  Text("\$"+cartNotifier.cartList[index].prodPrice.toString(),style: TextStyle(color: Colors.red),),
                subtitle: Text(
                  cartNotifier.cartList[index].prodDetails,
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
