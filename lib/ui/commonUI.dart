import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:provider/provider.dart';
import 'package:roashan/api/favoriteApi.dart';
import 'package:roashan/api/searchApi.dart';
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/models/categoryModel.dart';
import 'package:roashan/provider/cart.dart';
import 'package:roashan/provider/favoriteProvider.dart';
import 'package:roashan/ui/favouritePage.dart';
import 'package:roashan/ui/homePage.dart';
import 'package:roashan/ui/productDetails.dart';
import 'package:roashan/ui/search/allCategories.dart';
import 'package:roashan/ui/search/productsForCat.dart';
import 'package:roashan/ui/searchPage.dart';
import 'package:roashan/ui/searchResult.dart';
import 'package:roashan/ui/sectionPage.dart';
import 'package:toast/toast.dart';

class CommonUI {
  BuildContext context;
  CommonUI(this.context);
  bool selectedSection = false;
  bool selectedHome = false;
  bool selectedFavorite = false;
  bool selectedCompany = false;
  bool selectedComparision = false;
  bool selectedNotification = false;
  bool selectedAllCompanies = false;
  bool selectedProduct = false;
  SearchApi searchApi = new SearchApi();
  FavoriteApi favoriteApi = new FavoriteApi();
  List<String> categoriesName = [
    "السعر",
    "النوع",
    "القسم",
    "المدينة",
  ];

  Widget buildChoosePage(IconData icon, String name) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5.0),
        Icon(icon, color: Colors.black),
        SizedBox(height: 5.0),
        Text(name)
      ],
    );
  }

  Widget buildCategories(String name) {
    return Container(
        width: 40.0,
        height: 40.0,
        color: Colors.amberAccent[400],
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.black)),
              // Flexible(child: SizedBox(width: 5.0)),
              Flexible(
                child: Text(
                  name,
                ),
              )
            ],
          ),
        ));
  }

  Widget searchRow(TextEditingController searchController) {
    return Container(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Flexible(
        child: Container(
          height: 60.0,
          child: Theme(
            data: new ThemeData(
              primaryColor: Colors.amberAccent[400],
              primaryColorDark: Colors.amberAccent[400],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Container(
                width: 350.0,
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      // style:  TextStyle(color:Colors.white),

                      onChanged: (val) {
                        // updateTitle();
                      },

                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              // bool result ;
                              searchApi
                                  .getSearchResult(searchController.text)
                                  .then((value) {
                                if (value == true) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => new SearchResult(
                                          serachResult: searchApi.products)));
                                } else {
                                  Toast.show("لا يوجد " + searchController.text,
                                      context,
                                      backgroundColor: Colors.amber);
                                }
                              });
                            },
                            child: Container(
                                width: 60.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        bottomLeft: Radius.circular(5.0))),
                                child: Center(
                                  child: Image.asset(
                                    "files/imgs/serch.png",
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                )),
                          ),
                          hintText: "بحث",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 7.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),

                            borderSide: BorderSide(
                                color: Colors.black, style: BorderStyle.solid),

                            // color:Colors.grey
                          ),
                          hintStyle: TextStyle(color: Colors.amber),
                          // labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),

                            // color:Colors.grey
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 10.0),
      Padding(
        padding: const EdgeInsets.only(right: 30.0, top: 10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => new AllCategories()));
          },
          child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: Image(
                  image: AssetImage(
                    "files/imgs/app-ui-ROS_012_15.png",
                  ),
                  height: 30.0,
                  width: 30.0)),
        ),
      ),
    ]));
  }
  // //footer
  // Widget buildFooter(){
  //   return  Container(
  //                 color: Colors.amberAccent[400],
  //                 height: 80.0,
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: <Widget>[
  //                       SizedBox(width: 30.0),
  //                       GestureDetector(
  //                           onTap: () {
  //                             // setState(() {
  //                               selectedSection = false;
  //                               selectedHome = false;

  //                             // });
  //                             print("$selectedSection, $selectedSection");

  //                           },
  //                           child: buildChoosePage(Icons.favorite, "المفضلة")),
  //                       //  SizedBox(width:5.0),
  //                       Text("|",
  //                           style: TextStyle(
  //                               fontSize: 35.0, fontWeight: FontWeight.bold)),
  //                       //  SizedBox(width:30.0),
  //                       GestureDetector(
  //                           onTap: () {
  //                             // setState(() {
  //                               selectedSection = true;
  //                                selectedHome = false;
  //                             // });
  //                             print("$selectedSection, $selectedSection");

  //                           },
  //                           child: buildChoosePage(
  //                               Icons.format_list_bulleted, "الأقسام")),
  //                       //  SizedBox(width:5.0),
  //                       Text("|",
  //                           style: TextStyle(
  //                               fontSize: 35.0, fontWeight: FontWeight.bold)),
  //                       GestureDetector(
  //                           onTap: () {
  //                             // setState(() {
  //                               selectedSection = false;
  //                                selectedHome = true;
  //                             // });
  //                             print("$selectedSection, $selectedSection");
  //                           },
  //                           child: buildChoosePage(Icons.home, "الرئيسية")),
  //                       SizedBox(width: 30.0),

  //                       //  SizedBox(width:5.0),
  //                       //  Text("|",style:TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold)),
  //                     ],
  //                   ),
  //                 ));
  // }
  Widget buildCategoriesRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        //width: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategories(categoriesName[0]),
            SizedBox(width: 10.0),
            _buildCategories(categoriesName[1]),
            SizedBox(width: 10.0),
            _buildCategories(categoriesName[2]),
            SizedBox(width: 10.0),
            _buildCategories(categoriesName[3]),
            SizedBox(width: 10.0)
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(String name) {
    return Center(
      child: Container(
          color: Colors.amberAccent[400],
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.keyboard_arrow_down, color: Colors.black),
                SizedBox(width: 10.0),
                Text(
                  name,
                )
              ],
            ),
          )),
    );
  }

  int currentIndex = 0;
  final tabs = [
    Center(
      child: Text("المفضلة"),
    ),
    Center(
      child: Text("الأقسام"),
    ),
    Center(
      child: Text("الرىيسية"),
    ),
  ];
  ///////////////////////////////build bottom navigation bar
  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          currentIndex = index;
        },
        backgroundColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              title: Text("المفضلة")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              title: Text("الأقسام")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text("الرىيسية")),
        ]);
  }

  //////////////////common appbar
  Widget companyAppBar(String title) {
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
                  Navigator.of(context).pop();
                  // selectedSection = false;
                  // selectedHome = true;
                  // selectedFavorite = false;
                  // selectedCompany = false;
                  // selectedComparision = false;
                  // selectedAllCompanies = false;
                  // selectedProduct = false;
                  // selectedNotification = false;
                  // print("after select home: $selectedHome");
                },
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
        centerTitle: true,
        title: Text(title));
  }

  Widget buildGridView(double height, List cartList, int userID, String type) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Container(
        height: MediaQuery.of(context).size.height - height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(400.0)),
        child:
            // (loading)
            //     ? Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Center(
            //             child: CircularProgressIndicator(
            //               backgroundColor: Colors.amberAccent[400],
            //             ),
            //           )
            //         ],
            //       )
            //     :
            Consumer<FavoriteProvider>(builder: (context, favoriteObj, child) {
          return GridView.builder(
            itemBuilder: (BuildContext context, int index) {
              /////////////////////check if this product in favorite
              // isInsideFavorite(cartList[index], userID);
              return Container(
                  // height: 400.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Stack(
                    children: <Widget>[
                      // SizedBox(height:10.0),
                      Positioned(
                          top: 10.0,
                          left: 5.0,
                          right: 5.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              height: 100.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                              image: NetworkImage("http://" +
                                      cartList[index].prodImg ??
                                  "http://ros.vision.com.sa/userfiles/5e273edf7c652_item2.jpg"),
                            ),
                          )),
                      Positioned(
                          top: 60.0,
                          left: 15.0,
                          child: Container(
                            height: 20.0,
                            // width: 50.0,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                                child: Text(
                                    (cartList[index].prodPrice == null)
                                        ? "\$ " + "0"
                                        : "\$ " +
                                            cartList[index]
                                                .prodPrice
                                                .toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0))),
                          )),
                      Positioned(
                          top: 85.0,
                          left: 30.0,
                          child: Container(
                            width: 100.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  onPressed: () {
                                    favoriteApi
                                        .addFavoriteProducts(userID,
                                            int.parse(cartList[index].prodID))
                                        .then((value) {
                                      Toast.show(value, context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.CENTER,
                                          backgroundColor: Colors.amber);
                                      favoriteObj.addToFav(cartList[index]);
                                      // isFavorite =
                                      //     true; /////////////////////////////////////////
                                      print(cartList[index].isFav.toString());
                                      cartList[index].isFav = true;
                                      print(cartList[index].isFav.toString());
                                    });
                                  },
                                  icon: Icon(
                                      // (cartList[index].isFav)
                                      (type == "المفضلة")
                                          ? Icons.favorite
                                          : (favoriteObj.favoriteList
                                                  .contains(cartList[index]))
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                      color: Colors.red),
                                ),
                                // Text(cartList[index].isFav.toString()),
                                IconButton(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  onPressed: () {},
                                  icon: Icon(Icons.add, color: Colors.grey),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                          top: 130.0,
                          left: 60.0,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(cartList[index].prodName,
                                  style: TextStyle(fontSize: 14.0)))),
                      Positioned(
                          top: 150.0,
                          left: 15.0,
                          // width: 200,
                          right: 15.0,
                          // bottom: 20.0,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(cartList[index].prodDetails ?? "",
                                style: TextStyle(fontSize: 13.0)),
                          )),
                      Positioned(
                          top: 205.0,
                          left: MediaQuery.of(context).size.width / 4 - 40.0,
                          width: 50.0,
                          height: 40.0,
                          child: InkWell(
                            onTap: () {
                              print("current item::::" +
                                  cartList[index].listColor.toString());
                                  if(type == "search"){
                                       Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => new SearchPage(
                              
                                      )));
                                  }
                                  else{
 Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => new ProductDetails(
                                        cartItem: cartList[index],
                                      )));
                                  }
                             
                              // selectedSection = false;
                              // selectedHome = false;
                              // selectedFavorite = false;
                              // selectedCompany = false;
                              // selectedComparision = false;
                              // selectedAllCompanies = false;
                              // selectedProduct = true;
                              // selectedNotification = false;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amberAccent[400],
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                  child: Icon(Icons.arrow_forward,
                                      color: Colors.white)),
                            ),
                          )),
                      SizedBox(height: 10.0),
                    ],
                  ));
            },
            itemCount: cartList.length,
            //_allCompanies.length,
            // primary: false,
            padding: const EdgeInsets.only(left: 20, right: 20.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              //for height of card
              childAspectRatio: 0.6,
              //for horizontal space
              mainAxisSpacing: 6.0,
            ),
          );
        }),
      );
    });
  }

  // //footer
  Widget buildFooter({CartModel cartItem}) {
    return Container(
        color: Colors.amberAccent[400],
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(width: 30.0),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => new FavouritePage(
                              cartItem: cartItem,
                            )));
                  },
                  child: buildChoosePage(Icons.favorite, "المفضلة")),
              //  SizedBox(width:5.0),
              Text("|",
                  style:
                      TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
              //  SizedBox(width:30.0),
              GestureDetector(
                  onTap: () {
                    // selectedSection = true;
                    // selectedHome = false;
                    // selectedFavorite = false;
                    // selectedCompany = false;
                    // selectedComparision = false;
                    // selectedAllCompanies = false;
                    // selectedProduct = false;
                    // selectedNotification = false;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => new SectionsPage()));
                  },
                  child:
                      buildChoosePage(Icons.format_list_bulleted, "الأقسام")),
              //  SizedBox(width:5.0),
              Text("|",
                  style:
                      TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
              GestureDetector(
                  onTap: () {
                    // selectedSection = false;
                    // selectedHome = true;
                    // selectedFavorite = false;
                    // selectedCompany = false;
                    // selectedComparision = false;
                    // selectedAllCompanies = false;
                    // selectedProduct = false;
                    // selectedNotification = false;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => new HomePage()));
                  },
                  child: buildChoosePage(Icons.home, "الرئيسية")),
              SizedBox(width: 30.0),

              //  SizedBox(width:5.0),
              //  Text("|",style:TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }

  bool isInsideFavorite(CartModel item, int userID) {
    // bool isInsideFavorite = false;
    favoriteApi.getFavoriteProducts(userID).then((value) {
      print(
          "favorite length :::::::::::::::::::::::" + value.length.toString());
      print("item ::::::::::::::::::::::" + item.prodName);

      for (int i = 0; i < value.length; i++) {
        print("value[i].prodName::::::::::::::::::::::" + value[i].prodName);

        if (item == (value[i])) {
          // setState(() {
          // isInsideFavorite = true;
          // });
          // item.isFav = true;
          // print("in favorite::::::::" + item.prodName);

          // continue;
          print("true");
          return true;
        } else {
          print("current item :::::::::::::::::" + value[i].prodName);
          // print("my item ::::::::::::::::::" + item.prodName);
          return false;
        }
      }
      // item.isFav = false;
      // print("not in favorite::::::::" + item.prodName);
      return false;

      // setState(() {
      // isInsideFavorite = false;
      // // });
      // return isInsideFavorite;
    });
    // item.isFav = false;
    print("false");

    return false;
    // return isInsideFavorite;
  }

  Widget buildCategoryGridView(List<CategoryModel> categoryList) {
    return Container(
      height: MediaQuery.of(context).size.height - 90.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(400.0)),
      child: Consumer<FavoriteProvider>(builder: (context, favoriteObj, child) {
        return GridView.builder(
          itemBuilder: (BuildContext context, int index) {
            /////////////////////check if this product in favorite
            // isInsideFavorite(cartList[index], userID);
            return Container(
                // height: 400.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Stack(
                  children: <Widget>[
                    // SizedBox(height:10.0),
                    Positioned(
                        top: 10.0,
                        left: 5.0,
                        right: 5.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            height: 100.0,
                            width: 150.0,
                            fit: BoxFit.cover,
                            image: AssetImage("files/imgs/images (1).jpg"),
                            // image: NetworkImage("http://" +
                            //         categoryList[index].logoUrl ??
                            //     "http://ros.vision.com.sa/userfiles/5e273edf7c652_item2.jpg"),
                          ),
                        )),

                    Positioned(
                        top: 100.0,
                        left: 60.0,
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(categoryList[index].name,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)))),
                    Positioned(
                        top: 120.0,
                        left: 15.0,
                        // width: 200,
                        right: 15.0,
                        // bottom: 20.0,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(categoryList[index].details ?? "",
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.grey)),
                        )),
                    Positioned(
                        top: 140.0,
                        left: MediaQuery.of(context).size.width / 4 - 25.0,
                        width: 30.0,
                        height: 30.0,
                        child: InkWell(
                          onTap: () {
                            print("cat id :::: " + categoryList[index].id);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProductsForCat(categoryList[index].id)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amberAccent[400],
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            child: Center(
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.white)),
                          ),
                        )),
                    SizedBox(height: 10.0),
                  ],
                ));
          },
          itemCount: categoryList.length,
          //_allCompanies.length,
          // primary: false,
          padding: const EdgeInsets.only(left: 20, right: 20.0),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            //for height of card
            childAspectRatio: 0.9,
            //for horizontal space
            mainAxisSpacing: 6.0,
          ),
        );
      }),
    );
  }
}
