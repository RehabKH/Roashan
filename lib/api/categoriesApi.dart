import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/models/categoryModel.dart';



class CategoryApi {
  List<CategoryModel> categoryList = new List<CategoryModel>();
List<CartModel> productList = new List<CartModel>();
  Future<List<CategoryModel>> getAllCategories() async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=cat",
    );
    var categoryResult = json.decode(response.body);
    print("categories result ::::::::::::::::::$categoryResult");
    if (categoryResult["success"] == 1) {
      for (int i = 0; i < categoryResult["Allcat"].length; i++) {
        // setState(() {
        categoryList.add(new CategoryModel(
          id: categoryResult["Allcat"][i]["id"],
          name: categoryResult["Allcat"][i]["name"],
          details: categoryResult["Allcat"][i]["details"],
          logoUrl: categoryResult["Allcat"][i]["logo"],
          countProductincat: categoryResult["Allcat"][i]["countProductincat"],
        ));
        // selectedCategory.name = categoryResult["Allcat"][0]["name"];
        // selectedCategory.id = categories["Allcat"][0]["id"];
        // selectedCategory.details = categories["Allcat"][0]["details"];
        // selectedCategory.logoUrl = categories["Allcat"][0]["logo"];
        // selectedCategory.countProductincat = categories["Allcat"][0]["countProductincat"];
        // loading = false;

        // });
      }
      return categoryList;
    }

    return categoryList;
    // else {
    //   // categoryList.add(new CategoryModel(
    //   //         id: "1",
    //   //         name: categoryResult["message"],
    //   //         details:"",
    //   //         logoUrl:"",
    //   //         countProductincat:"",
    //   //       ));
    //   return categoryList;
    // }
    // return categoryList;
  }

  Future<List<CartModel>> getAllProductForCategoryID(String catID) async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=filter&Country_id=&cat_id=$catID&name=&price=&Type_id=",
    );
    var productResult = json.decode(response.body);
    print("product for this category ::::::::::::::::::$productResult");
    if (productResult["success"] == 1) {
      for (int i = 0; i < productResult["Allproducts"].length; i++) {
        // setState(() {
        productList.add(new CartModel(
       prodName: productResult["Allproducts"][i]["name"],
          prodDetails: productResult["Allproducts"][i]["details"],
          prodImg: productResult["Allproducts"][i]["img"],
          prodDate: DateTime.parse(productResult["Allproducts"][i]["date"]),
          prodID: (productResult["Allproducts"][i]["id"]),
          prodPrice: double.parse(productResult["Allproducts"][i]["price"]),
          userID: productResult["Allproducts"][i]["user_id"],
          catID: productResult["Allproducts"][i]["cat_id"],
          listColor: productResult["Allproducts"][i]["colors"].toString().substring(1,productResult["Allproducts"][i]["colors"].toString().length -1).replaceAll('"', "").split(" "),
        ));
      
      }
      return productList;
    }

    return productList;
  }
}
