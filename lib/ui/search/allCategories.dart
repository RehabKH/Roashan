import 'package:flutter/material.dart';
import 'package:roashan/api/categoriesApi.dart';
import 'package:roashan/models/categoryModel.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  CategoryModel selectedCategory = new CategoryModel();
  CategoryApi categoryApi = new CategoryApi();
  CommonUI commonUI;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categoryApi.getAllCategories().then((value) {
      setState(() {
        _loading = false;
      });
      print(categoryApi.categoryList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: commonUI.companyAppBar("اختر القسم"),
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
            height: MediaQuery.of(context).size.height ,
                      child:Column(
                        children: [
                          SizedBox(height: 10.0,),
                           commonUI.buildCategoryGridView(
                 categoryApi.categoryList),
                        ],
                      )
          ),
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
