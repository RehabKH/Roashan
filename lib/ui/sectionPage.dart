import 'package:flexible/flexible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:roashan/api/categoriesApi.dart';
import 'package:roashan/api/register.dart';
import 'package:roashan/models/categoryModel.dart';
import 'package:roashan/ui/commonUI.dart';

class SectionsPage extends StatefulWidget {
  @override
  _SectionsPageState createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  CommonUI commonUI;
  CategoryApi categoryApi = new CategoryApi();
  // RegisterApi registerApi = new RegisterApi();
  // var categories;
  // bool _loading = false;
  List<CategoryModel> categoryList = new List<CategoryModel>();

  @override
  void initState() {
    super.initState();
    categoryApi.getAllCategories().then((value) {
      setState(() {
        categoryList = value;
      });
      // for (int i = 0; i < categories["Allcat"].length; i++) {
      //   setState(() {
      //     categoryList.add(new CategoryModel(
      //       id: categories["Allcat"][i]["id"],
      //       name: categories["Allcat"][i]["name"],
      //       details: categories["Allcat"][i]["details"],
      //       logoUrl: categories["Allcat"][i]["logo"],
      //       countProductincat: categories["Allcat"][i]["countProductincat"],
      //     ));
      //   });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: _buildSectionAppBar(),
      body: _buildHomeGridView(),
    );
  }

  Widget _buildHomeGridView() {
    return
        //  (_loading)
        //     ? Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Center(
        //             child: CircularProgressIndicator(
        //               backgroundColor: Colors.amberAccent[400],
        //             ),
        //           ),
        //         ],
        //       )
        //     :
        Container(
            // height: MediaQuery.of(context).size.height,

            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                (categoryList.length <=0)?
                Container(
                  height: MediaQuery.of(context).size.height - 190.0,
                  child: Center(child: CircularProgressIndicator(backgroundColor: Colors.amber,))):
                Container(
                  height: MediaQuery.of(context).size.height - 190.0,
                  child: GridView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => new SpecifyCompany()));
                          //   setState(() {
                          //       commonUI.selectedSection = false;
                          //         commonUI.selectedHome = false;
                          //         commonUI.selectedFavorite = false;
                          //         commonUI.selectedCompany = true;
                          //         commonUI.selectedComparision = false;
                          //         commonUI.selectedAllCompanies = false;
                          //         commonUI.selectedProduct = false;
                          //         commonUI.selectedNotification = false;
                          // // selectedCompanyID = campanies[index]["id"];
                          //     // selectedCompanyName = campanies[index]["title"];
                          //     // selectedCompanyDetails = campanies[index]["details"];
                          //     // selectedCompanyImg = campanies[index]["img"];
                          //   });
                        },
                        child: Container(
                            // height: 400.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                ScreenFlexibleWidget(
                                    // 1. Wrap with `ScreenFlexibleWidget`

                                    child: Builder(
                                        builder: (BuildContext context) {
                                  return Container(
                                      height: 80.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                               "http://"+ categoryList[index].logoUrl),
                                              fit: BoxFit.cover)));
                                })),
                                SizedBox(height: 10.0),
                                Text(categoryList[index].name)
                              ],
                            )),
                      );
                    },
                    itemCount:categoryList.length,
                    //_allCompanies.length,
                    // primary: false,
                    padding: const EdgeInsets.only(left: 20, right: 20.0),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15.0,
                      //for height of card
                      childAspectRatio: 0.7,
                      //for horizontal space
                      mainAxisSpacing: 15.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                commonUI.buildFooter()
              ],
            ));
  }

  //////////////////////////////////////////App bar section
  Widget _buildSectionAppBar() {
    return AppBar(
      backgroundColor: Colors.amberAccent[400],
      leading: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            child: new IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.amberAccent[400],
              ),
              onPressed: () {
                setState(() {
                  commonUI.selectedSection = false;
                  commonUI.selectedHome = true;
                  commonUI.selectedFavorite = false;
                  commonUI.selectedCompany = false;
                  commonUI.selectedComparision = false;
                  commonUI.selectedAllCompanies = false;
                  commonUI.selectedProduct = false;
                  commonUI.selectedNotification = false;
                  // products = val1;
                });
                // registerApi.getAllProducts().then((val1) {
                //   setState(() {
                //     selectedSection = false;
                //     selectedHome = true;
                //     selectedFavorite = false;
                //     selectedCompany = false;
                //     selectedComparision = false;
                //     selectedAllCompanies = false;
                //     selectedProduct = false;
                //     selectedNotification = false;
                //     products = val1;
                //   });
                // });
              },
            ),
          ),
        ),
      ),
      title: Text("الأقسام"),
      centerTitle: true,
    );
  }
}
