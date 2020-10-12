import 'package:flutter/material.dart';
import 'package:roashan/api/categoriesApi.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsForCat extends StatefulWidget {
  final String catID;
  ProductsForCat(this.catID);
  @override
  _ProductsForCatState createState() => _ProductsForCatState();
}

class _ProductsForCatState extends State<ProductsForCat> {
  CommonUI commonUI;
  CategoryApi categoryApi = new CategoryApi();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getUserData().then((value) {
  categoryApi.getAllProductForCategoryID(widget.catID).then((value) {
      setState(() {
        _loading = false;
      });
    });


    });
  
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: commonUI.companyAppBar("اختر المنتج"),
      body: (_loading)
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  )
                ],
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  commonUI.buildGridView(90.0, categoryApi.productList,
                      int.parse(userID), "search"),
                ],
              )),
    );
  }

  String userID;
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString("userID");
    });
  }
}
