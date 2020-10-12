import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:roashan/models/cartModel.dart';
// import 'package:roashan/models/favoriteProdModel.dart';

class FavoriteApi {
  List<CartModel> allFavoriteProducts = new List<CartModel>();
  // FavoriteProdModel favoriteProdModel = new FavoriteProdModel();
  var favoriteProducts;
  Future<List<CartModel>> getFavoriteProducts(int userID) async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=FavoritePro&UserID=$userID",
    );
    favoriteProducts = json.decode(response.body);

    if (favoriteProducts["message"] == "Sucsess") {
      allFavoriteProducts.clear();
      for (int i = 0; i < favoriteProducts["Allproducts"].length; i++) {
        allFavoriteProducts.add(new CartModel(
          prodName: favoriteProducts["Allproducts"][i]["name"],
          prodDetails: favoriteProducts["Allproducts"][i]["details"],
          prodImg: favoriteProducts["Allproducts"][i]["img"],
          prodDate: DateTime.parse(favoriteProducts["Allproducts"][i]["date"]),
          prodID: (favoriteProducts["Allproducts"][i]["id"]),
          prodPrice: double.parse(favoriteProducts["Allproducts"][i]["price"]),
          userID: favoriteProducts["Allproducts"][i]["user_id"],
          catID: favoriteProducts["Allproducts"][i]["cat_id"],
          listColor: favoriteProducts["Allproducts"][i]["colors"].toString().substring(1,favoriteProducts["Allproducts"][i]["colors"].toString().length -1).replaceAll('"', "").split(" "),
        ));
      // print("all favorite pro ID: ${allFavoriteProducts[i].prodID}");


      }
      // print("all favorite pro: ${allFavoriteProducts[]}");

      // favoriteProdModel.product = allFavoriteProducts;
      return allFavoriteProducts;
      // return true;
    }
    return allFavoriteProducts;
  }

  Future<String> addFavoriteProducts(int userID, int prodID) async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=Addfavorites&UserID=$userID&ProdID=$prodID",
    );
    var res = json.decode(response.body);
    print("add favorite prod result::::::::::::::::::: $res");
    return res["message"];
  }
}
