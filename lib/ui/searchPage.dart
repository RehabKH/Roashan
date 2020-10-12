import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:roashan/api/categoriesApi.dart';
import 'package:roashan/api/searchApi.dart';
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/models/categoryModel.dart';
import 'package:roashan/models/countryModel.dart';
import 'package:roashan/models/prodTypeModel.dart';
// import 'package:roashan/api/searchApi.dart';
// import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:roashan/ui/commonVariables.dart';
import 'package:roashan/ui/searchResult.dart';
import 'package:toast/toast.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CommonUI commonUI;
  CommonVariables commonVariables = new CommonVariables();
  List<CountryModel> _countries = new List<CountryModel>();
  String _selectedCountryID;
  CountryModel selectedCountry;
  var categories;
  TextEditingController priceController = new TextEditingController();
  SearchApi searchApi = new SearchApi();
  bool loading = true;
  CategoryApi categoryApi = new CategoryApi();
  List<CategoryModel> categoryList = new List<CategoryModel>();
  List<CartModel> cartList = new List<CartModel>();
  // var selectedSection = "";
  CategoryModel selectedCategory = new CategoryModel();
  ProdTypeModel selectedProdType;
  String selectedTypeID;
  var prodType;

  List<ProdTypeModel> prodTypeList = new List<ProdTypeModel>();

  bool loadingProduct = true;

  CartModel selectedProduct;
  @override
  void initState() {
    super.initState();
    print(commonVariables.productsSection.toString());
    searchApi.getAllCountries().then((value) {
      setState(() {
        _countries = value;
        selectedCountry = _countries[0];
        _selectedCountryID = _countries[0].id;
      });
      categoryApi.getAllCategories().then((value) {
        setState(() {
          categoryList = value;
          selectedCategory = categoryList[0];
          // _selectedCountryID = categoryList[0].id;
          categoryApi
              .getAllProductForCategoryID(selectedCategory.id)
              .then((value) {
            setState(() {
              selectedProduct = categoryApi.productList[0];
              loading = false;
              loadingProduct = false;
            });
            print(selectedProduct.prodName);
          });
        });
        searchApi.getAllProdType().then((value) {
          setState(() {
            prodTypeList = value;

            selectedProdType = prodTypeList[0];
            // selectedTypeID = prodTypeList[0].id;
          });
          // for (int i = 0; i < prodType.length; i++) {
          //   setState(() {
          //     prodTypeList.add(new ProdTypeModel(
          //       id: prodType["TypeProd"][i]["id"],
          //       name: prodType["TypeProd"][i]["Name"],
          //     ));
          //     selectedProdType = prodType["TypeProd"][0]["Name"];
          //   });
          // }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print("category id:::::::::::::::::::::::::::::::" +
          //     selectedCategory.id +
          //     ", selected type id:::::::::::::::::::::::" +
          //     selectedProdType.id);
          // //_selectedCountryID (priceController.text)
          // searchApi
          //     .getSearchFilterResult(_selectedCountryID, selectedCategory.id,
          //         "", priceController.text, selectedProdType.id)
          //     .then((products) {
          //   if (products == "No Data Found") {
          //     Toast.show(products, context,
          //         duration: Toast.LENGTH_LONG,
          //         gravity: Toast.CENTER,
          //         backgroundColor: Colors.amber);
          //   } else {
          //     for (int i = 0; i < products.length; i++) {
          //       setState(() {
          //         cartList.add(new CartModel(
          //           prodName: products[i]["name"],
          //           prodDetails: products[i]["details"],
          //           prodImg: products[i]["img"],
          //           prodDate: DateTime.parse(products[i]["date"]),
          //           prodID: (products[i]["id"]),
          //           prodPrice: double.parse(products[i]["price"]),
          //           userID: products[i]["user_id"],
          //           catID: products[i]["cat_id"],
          //           listColor: products[i]["colors"]
          //               .toString()
          //               .substring(
          //                   1, products[i]["colors"].toString().length - 1)
          //               .replaceAll('"', "")
          //               .split(","),
          //           isFav: false,
          //         ));
          //       });
          //     }
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => new SearchResult(
          //               serachResult: cartList,
          //             )));
          //   }
          // });
        },
        backgroundColor: Colors.teal,
        child: Center(
          child: Text(
            "تم",
            style: TextStyle(color: Colors.white, fontSize: 17.0),
          ),
        ),
      ),
      appBar: commonUI.companyAppBar("Search With Filter"),
      body: (loading)
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
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // Text("السعر",style: TextStyle(color: Colors.teal),),

                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 35.0, right: 35.0, top: 35.0),
                    //   child: ExpandablePanel(
                    //     header: SizedBox(
                    //       width: 200.0,
                    //       child: Row(
                    //         children: [
                    //           Text(
                    //             "الحجز اونلاين",
                    //             style: TextStyle(color: Colors.teal[800]),
                    //           ),
                    //           SizedBox(
                    //             width: 10.0,
                    //           ),
                    //           Container(
                    //             height: 25.0,
                    //             width: 50.0,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.orange,
                    //                 borderRadius: BorderRadius.circular(5.0)),
                    //             child: Center(
                    //               child: Text(
                    //                 "جديد",
                    //                 style: TextStyle(color: Colors.white),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     // collapsed:Row(children: [
                    //     //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                    //     //   Text("مدارس متاح لها الحجز اونلاين")
                    //     // ],),
                    //     expanded: Row(
                    //       children: [
                    //         Checkbox(
                    //           value: true,
                    //           onChanged: (val) {},
                    //           activeColor: Colors.orange,
                    //         ),
                    //         Text("مدارس متاح لها الحجز اونلاين")
                    //       ],
                    //     ),
                    //     tapHeaderToExpand: true,
                    //     hasIcon: true,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 35.0, right: 35.0, top: 35.0),
                    //   child: ExpandablePanel(
                    //     header: Text(
                    //       "قسم المنتجات",
                    //       style: TextStyle(color: Colors.teal[800]),
                    //     ),
                    //     // collapsed:Row(children: [
                    //     //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                    //     //   Text("مدارس متاح لها الحجز اونلاين")
                    //     // ],),
                    //     expanded: Container(
                    //       height: 40.0,
                    //       width: MediaQuery.of(context).size.width - 80.0,
                    //       decoration: BoxDecoration(
                    //           border: Border.all(color: Colors.grey)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: DropdownButton<CategoryModel>(
                    //           isExpanded: true,
                    //           value: selectedCategory,
                    //           iconSize: 24,
                    //           elevation: 16,
                    //           style: TextStyle(color: Colors.orange),
                    //           underline: Container(
                    //             height: 2,
                    //             color: Colors.transparent,
                    //           ),
                    //           onTap: () {
                    //             setState(() {
                    //               loadingProduct = true;
                    //             });
                    //           },
                    //           onChanged: (newValue) {
                    //             setState(() {
                    //               selectedCategory = newValue;
                    //             });
                    //             categoryApi
                    //                 .getAllProductForCategoryID(
                    //                     selectedCategory.id)
                    //                 .then((value) {
                    //               setState(() {
                    //                 loadingProduct = false;
                    //               });
                    //             });
                    //           },
                    //           items: categoryList
                    //               .map<DropdownMenuItem<CategoryModel>>(
                    //                   (value) {
                    //             return DropdownMenuItem<CategoryModel>(
                    //               value: value,
                    //               child: Text(value.name),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ),
                    //     ),
                    //     tapHeaderToExpand: true,
                    //     hasIcon: true,
                    //   ),
                    // ),

                    Container(
                      height: MediaQuery.of(context).size.height - 250.0,
                      child: (loadingProduct)
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
                          : ListView(
                              children: [
                                SizedBox(height: 20.0,),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 35.0, right: 35.0, top: 35.0),
                                //   child: ExpandablePanel(
                                //     header: Text(
                                //       "المنتجات",
                                //       style: TextStyle(color: Colors.teal[800]),
                                //     ),
                                //     // collapsed:Row(children: [
                                //     //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                                //     //   Text("مدارس متاح لها الحجز اونلاين")
                                //     // ],),
                                //     expanded: Container(
                                //       height: 40.0,
                                //       width: MediaQuery.of(context).size.width -
                                //           80.0,
                                //       decoration: BoxDecoration(
                                //           border:
                                //               Border.all(color: Colors.grey)),
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: DropdownButton<CartModel>(
                                //           isExpanded: true,
                                //           value: selectedProduct,
                                //           iconSize: 24,
                                //           elevation: 16,
                                //           style:
                                //               TextStyle(color: Colors.orange),
                                //           underline: Container(
                                //             height: 2,
                                //             color: Colors.transparent,
                                //           ),
                                //           onTap: () {
                                //             setState(() {
                                //               loadingProduct = true;
                                //             });
                                //           },
                                //           onChanged: (newValue) {
                                //             setState(() {
                                //               selectedProduct = newValue;
                                //             });
                                //           },
                                //           items: categoryApi.productList
                                //               .map<DropdownMenuItem<CartModel>>(
                                //                   (value) {
                                //             return DropdownMenuItem<CartModel>(
                                //               value: value,
                                //               child: Text(value.prodName),
                                //             );
                                //           }).toList(),
                                //         ),
                                //       ),
                                //     ),
                                //     tapHeaderToExpand: true,
                                //     hasIcon: true,
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 35.0,
                                    right: 35.0,
                                  ),
                                  child: ExpandablePanel(
                                    header: Text(
                                      "اللون",
                                      style: TextStyle(color: Colors.teal[800]),
                                    ),
                                    // collapsed:Row(children: [
                                    //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                                    //   Text("مدارس متاح لها الحجز اونلاين")
                                    // ],),
                                    expanded: Center(
                                      child: CircleColorPicker(
                                        initialColor: Colors.blue,
                                        onChanged: (color) => print(color),
                                        size: const Size(240, 240),
                                        strokeWidth: 4,
                                        thumbSize: 36,
                                      ),
                                    ),
                                    tapHeaderToExpand: true,
                                    hasIcon: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0),
                                  child: ExpandablePanel(
                                    header: Text(
                                      "النوع",
                                      style: TextStyle(color: Colors.teal[800]),
                                    ),
                                    // collapsed:Row(children: [
                                    //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                                    //   Text("مدارس متاح لها الحجز اونلاين")
                                    // ],),
                                    expanded: Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width -
                                          80.0,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<ProdTypeModel>(
                                          isExpanded: true,
                                          value: selectedProdType,
                                          iconSize: 24,
                                          elevation: 16,
                                          style:
                                              TextStyle(color: Colors.orange),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.transparent,
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedProdType = newValue;
                                              selectedTypeID = newValue.id;
                                              print(
                                                  "selectedProdType::::::::::::" +
                                                      selectedProdType.id);
                                            });
                                          },
                                          items: prodTypeList.map<
                                              DropdownMenuItem<
                                                  ProdTypeModel>>((value) {
                                            return DropdownMenuItem<
                                                ProdTypeModel>(
                                              value: value,
                                              child: Text(value.name),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    tapHeaderToExpand: true,
                                    hasIcon: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0),
                                  child: ExpandablePanel(
                                    header: Text(
                                      "الخامة",
                                      style: TextStyle(color: Colors.teal[800]),
                                    ),
                                    // collapsed:Row(children: [
                                    //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                                    //   Text("مدارس متاح لها الحجز اونلاين")
                                    // ],),
                                    expanded: Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width -
                                          80.0,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value:
                                              commonVariables.selectedMaterial,
                                          iconSize: 24,
                                          elevation: 16,
                                          style:
                                              TextStyle(color: Colors.orange),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.transparent,
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              commonVariables.selectedMaterial =
                                                  newValue;
                                            });
                                          },
                                          items: commonVariables.material
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    tapHeaderToExpand: true,
                                    hasIcon: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0),
                                  child: ExpandablePanel(
                                    header: Text(
                                      "السعر",
                                      style: TextStyle(color: Colors.teal[800]),
                                    ),
                                    // collapsed:Row(children: [
                                    //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                                    //   Text("مدارس متاح لها الحجز اونلاين")
                                    // ],),
                                    expanded: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          controller: priceController,
                                          // style:  TextStyle(color:Colors.white),

                                          onChanged: (val) {
                                            // updateTitle();
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: " اكتب السعر",
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0)),

                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    style: BorderStyle.solid),

                                                // color:Colors.grey
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.orange),
                                              labelText: "السعر",
                                              labelStyle:
                                                  TextStyle(color: Colors.teal),
                                              // labelStyle: TextStyle(color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                  color: Colors.teal,
                                                ),

                                                // color:Colors.grey
                                              )),
                                        ),
                                      ),
                                    ),
                                    tapHeaderToExpand: true,
                                    hasIcon: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0),
                                  child: ExpandablePanel(
                                    header: Text(
                                      "المدينة",
                                      style: TextStyle(color: Colors.teal[800]),
                                    ),
                                    // collapsed:Row(children: [
                                    //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                                    //   Text("مدارس متاح لها الحجز اونلاين")
                                    // ],),
                                    expanded: Container(
                                      height: 35.0,
                                      width: MediaQuery.of(context).size.width -
                                          80.0,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<CountryModel>(
                                          isExpanded: true,
                                          value: selectedCountry,
                                          iconSize: 24,
                                          elevation: 16,
                                          style:
                                              TextStyle(color: Colors.orange),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.transparent,
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedCountry = newValue;
                                              _selectedCountryID = newValue.id;
                                            });
                                          },
                                          items: _countries.map<
                                                  DropdownMenuItem<
                                                      CountryModel>>(
                                              (CountryModel value) {
                                            return DropdownMenuItem<
                                                CountryModel>(
                                              value: value,
                                              child: Text(value.name),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    tapHeaderToExpand: true,
                                    hasIcon: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.0, right: 35.0, bottom: 35.0),
                                  child: ExpandablePanel(
                                    header: Text(
                                      "الحي",
                                      style: TextStyle(color: Colors.teal[800]),
                                    ),
                                    // collapsed:Row(children: [
                                    //   Checkbox(value: true, onChanged: (val){},activeColor: Colors.orange,),
                                    //   Text("مدارس متاح لها الحجز اونلاين")
                                    // ],),
                                    expanded: Container(
                                      height: 35.0,
                                      width: MediaQuery.of(context).size.width -
                                          80.0,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: "One",
                                          iconSize: 24,
                                          elevation: 16,
                                          style:
                                              TextStyle(color: Colors.orange),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.transparent,
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              // dropdownValue = newValue;
                                            });
                                          },
                                          items: <String>[
                                            'One',
                                            'Two',
                                            'Free',
                                            'Four'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    tapHeaderToExpand: true,
                                    hasIcon: true,
                                  ),
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
