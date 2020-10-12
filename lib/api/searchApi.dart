import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/models/countryModel.dart';
import 'package:roashan/models/prodTypeModel.dart';

class SearchApi {
  List<CartModel> products = new List<CartModel>();
  var searchResult;
  Future<bool> getSearchResult(String filter) async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=Search&filter=$filter",
    );
    searchResult = json.decode(response.body);
    products.clear();
    print("search result: " + searchResult.toString());
    if (searchResult["message"] == "Sucsess") {
      print(
          "result success////////////////////////////////////////$searchResult");
      for (int i = 0; i < searchResult["Allproducts"].length; i++) {
        products.add(new CartModel(
          prodName: searchResult["Allproducts"][i]["name"],
          prodDetails: searchResult["Allproducts"][i]["details"],
          prodImg: searchResult["Allproducts"][i]["img"],
          prodDate: DateTime.parse(searchResult["Allproducts"][i]["date"]),
          prodID: (searchResult["Allproducts"][i]["id"]),
          prodPrice: double.parse(searchResult["Allproducts"][i]["price"]),
          userID: searchResult["Allproducts"][i]["user_id"],
          catID: searchResult["Allproducts"][i]["cat_id"],
          listColor: searchResult["Allproducts"][i]["colors"].toString()
                    .substring(1, searchResult["Allproducts"][i]["colors"].toString().length - 1)
                    .replaceAll('"', "")
                    .split(","),
        ));
      }
      // print("products after search::" + products.toString());
      return true;
    }
    return false;
  }

  Future getSearchFilterResult(
      String countryID, String catID, String name, String price,String typeID) async {
    print(
        "country id: $countryID , catID:: $catID , name: $name , price: $price , type id: $typeID");
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=Searchfilter&Country_id=$countryID&cat_id=$catID&name=$name&price=$price&Type_id=$typeID",
    );
    var searchFilterResult = json.decode(response.body);
    print("search filter result ::::::::::::::::::$searchFilterResult");
    if (searchFilterResult["success"] == 0) {
      return searchFilterResult["message"];
    } else {
      return searchFilterResult["Allproducts"];
    }
  }

  Future<List<CountryModel>> getAllCountries() async {
    List<CountryModel> countryList = new List<CountryModel>();
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=Country",
    );
    var countries = json.decode(response.body);
    print("all countries :::::::::::::::::::::::::::::$countries");
    for (int i = 0; i < countries["Country"].length; i++) {
      countryList.add(
        new CountryModel(
            id: countries["Country"][i]["id"],
            name: countries["Country"][i]["name"]),
      );
    }
    return countryList;
  }

  Future<List<ProdTypeModel>> getAllProdType() async {
    List<ProdTypeModel> productList = new List<ProdTypeModel>();
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=Type_id",
    );
    var prodType = json.decode(response.body);
    print("all product type :::::::::::::::::::::::::::::$prodType");
    if (prodType["success"] == 1) {
      for (int i = 0; i < prodType["TypeProd"].length; i++) {
        productList.add(
          new ProdTypeModel(
              id: prodType["TypeProd"][i]["id"],
              name: prodType["TypeProd"][i]["Name"]),
        );
      }
    } else {
      productList.add(
          new ProdTypeModel(id: "1", name: prodType["message"]));
    }
    return productList;
  }
}
