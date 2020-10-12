import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roashan/api/favoriteApi.dart';
// import 'package:provider/provider.dart';
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/provider/cart.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  final List<CartModel> cartList;
  final CartModel cartItem;
  FavouritePage({this.cartList, this.cartItem});
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  CommonUI commonUI;
  FavoriteApi favoriteApi = new FavoriteApi();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: commonUI.companyAppBar("المفضلة"),
      body: buildFavoriteBody(),
    );
  }

  buildFavoriteBody() {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return FutureBuilder<List<CartModel>>(
            future: favoriteApi.getFavoriteProducts(
                (int.parse(userID) <= 0 || int.parse(userID) == null)
                    ? 1
                    : int.parse(userID)),
            builder: (context, snapshot) {
              return Container(
                child: (!snapshot.hasData)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: MediaQuery.of(context).size.height,
                              child:
                                  ListView(shrinkWrap: true, children: <Widget>[
                                SizedBox(height: 20.0),
                                commonUI.buildGridView(
                                                180.0,
                                                snapshot.data,
                                                int.parse(userID),"المفضلة"
                                               ),
                                            
                                                commonUI.buildFooter()
                                // FutureBuilder<List<CartModel>>(
                                //     future: favoriteApi
                                //         .getFavoriteProducts(int.parse(userID)),
                                //     builder: (context, snapshot2) {
                                //       return Container(
                                //         height:MediaQuery.of(context).size.height -120.0,
                                //         child: ListView.builder(
                                //           itemCount: snapshot2.data.length,
                                //           itemBuilder: (context, index2) {
                                //             return (snapshot.data[index].prodID ==
                                //            snapshot2.data[index2].prodID )?commonUI.buildGridView(
                                //                 180.0,
                                //                 snapshot.data,
                                //                 int.parse(userID),
                                //                isFavorite: true):commonUI.buildGridView(
                                //                 180.0,
                                //                 snapshot.data,
                                //                 int.parse(userID),
                                //                 isFavorite:false);
                                //           },
                                //         ),
                                //       );
                                //     }),
                               
                              ]));
                        },
                      ),
              );
            });
      },
    );
  }

  String userID;
  Future<void> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString("userID");
    });
    print("user id: $userID");
  }
}
