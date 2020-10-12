// import 'package:flutter/material.dart';

class CartModel {
  String prodID;
  String prodName;
  String prodImg;
  String prodDetails;
  DateTime prodDate;
  double prodPrice;
  List<String> listColor;
  String userID;
  String catID;
  bool isFav;
  CartModel(
      {this.prodID,
      this.catID,
      this.userID,
      this.prodName,
      this.prodDetails,
      this.prodPrice,
      this.prodDate,
      this.prodImg,
      this.listColor,this.isFav});
}
