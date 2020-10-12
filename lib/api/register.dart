import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:roashan/models/companyModel.dart';
// import 'package:roashan/models/cartModel.dart';
// import 'package:roashan/provider/cart.dart';
// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterApi {
  // Cart cartList = new Cart();

  /////////////////////////////////////////////register

  signUp(String name, String email, String phone, String pass) async {
    var response = await http.post(
      "http://ros.vision.com.sa/api/api.php?type=reg&Email=$email&pass=$pass&name=$name&phone=$phone&utype=1",
    );
    var result = json.decode(response.body);

    print("register result: " + result.toString());
    if (result["success"] == 1) {
      return "success";
    } else {
      return result["message"];
    }
  }

  /////////////////////login
  var userData;
  login(String email, String pass) async {
    var response = await http.post(
      "http://ros.vision.com.sa/api/api.php?type=login&Email=$email&pass=$pass",
    );
    var userData = json.decode(response.body);

    print("login result: " + userData.toString());
    if (userData["success"] == 1) {
      // print(userData["type"]);
      //save user data

      await saveUserData(userData);
      return "success";
    } else {
      return userData["message"];
    }
  }

// Cart cartList
//////////////////////////////get all products
  getAllProducts() async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=products",
    );
    var products = json.decode(response.body);
    print("products result: " + products.toString());
    if (products["message"] == "Sucsess") {
      // print(userData["type"]);
      //save user data

      // print("cart list::::::::::::::::::::::::::: "+cartList.cartList[0].prodName);
      return products["Allproducts"];
    } else {
      return products["message"];
    }
  }

  /////////////////////////////
  //////////////////////////////get all categories
  getAllCategories() async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=cat",
    );
    var categories = json.decode(response.body);

    print("categories result: " + categories.toString());
    if (categories["message"] == "Sucsess") {
      // print(userData["type"]);
      //save user data

      return categories["Allcat"];
    } else {
      return categories["message"];
    }
  }

  //////////////////////////////
  /// //////////////////////////////get all companies
  getAllCompanies() async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=companies",
    );
    var categories = json.decode(response.body);

    print("companies result: " + categories.toString());
    if (categories["message"] == "Sucsess") {
      // print(userData["type"]);
      //save user data
      // CompanyModel companyModel = categories["companies"];
      return categories["companies"];
    } else {
      return categories["message"];
    }
  }

  /////////////////////////////////get all products in specify category
  /// //////////////////////////////get all companies
  getProductsWithCat(String catID) async {
    var response = await http.get(
      "http://ros.vision.com.sa/api/api.php?type=products&cat_id=$catID",
    );
    var productsForCat = json.decode(response.body);

    print("products for this cat result: " + productsForCat.toString());
    if (productsForCat["message"] == "Sucsess") {
      // print(userData["type"]);
      //save user data

      return productsForCat["Allproducts"];
    } else {
      return productsForCat["message"];
    }
  }

  Future<void> saveUserData(userData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("type", userData["type"]);
    prefs.setString("name", userData["Name"]);
    prefs.setString("email", userData["Email"]);
    prefs.setString("mobile", userData["Mobile"]);
    prefs.setString("img", userData["img"]);
    prefs.setString("userID", userData["userType"]);

    print("user id ________________________________________"+userData["userType"]);
  }
}
