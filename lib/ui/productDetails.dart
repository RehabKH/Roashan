import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:provider/provider.dart';
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/provider/cart.dart';
// import 'package:roashan/ui/cartPage.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:toast/toast.dart';

class ProductDetails extends StatefulWidget {
  final CartModel cartItem;
  ProductDetails({this.cartItem});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  CommonUI commonUI;
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    
    super.initState();
    print("selected item:::::::::::::::::::::::" + widget.cartItem.prodDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحة المنتج"),
        centerTitle: true,
        // actions: <Widget>[
        //   Padding(
        //     padding: EdgeInsets.only(right: 15.0, top: 5.0),
        //     child: InkWell(
        //       onTap: () {
        //         Navigator.of(context).push(
        //             MaterialPageRoute(builder: (context) => new CartPage()));
        //       },
        //       child: Consumer<Cart>(
        //         builder: (context, cart, widget) {
        //           return Badge(
        //             // badgeColor: Colors.red[200],
        //             badgeContent: Text(
        //               cart.cartListCount.toString(),
        //               style: TextStyle(color: Colors.white),
        //             ),
        //             child: Icon(Icons.shopping_cart),
        //           );
        //         },
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: buildProductBody(),
    );
  }

  Widget buildProductBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(shrinkWrap: true, children: <Widget>[
          SizedBox(height: 15.0),

          ///////////////////////////////////////////////////////////////
          commonUI.searchRow(searchController),
          // SizedBox(height: 15.0),
          // commonUI.buildCategoriesRow(),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150.0,
                width: 350.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // child: Image(
                  //     image: NetworkImageWithRetry(widget.cartItem.prodImg),
                  //     fit: BoxFit.cover),
                 child: Image.network("http://"+widget.cartItem.prodImg,fit: BoxFit.cover,)
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                  (widget.cartItem.prodPrice == null)
                      ? "0"
                      : widget.cartItem.prodPrice.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.cartItem.prodName,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          // SizedBox(height: 10.0),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text("وصف المنتج:",
                                style: GoogleFonts.actor(
                                    fontSize: 16.0, color: Colors.red)),
                            Text(widget.cartItem.prodDetails??"",
                                style: GoogleFonts.actor(fontSize: 16.0)),
                          ],
                        )))
              ],
            ),
          ),
          // SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                  child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text("اللون: \n",
                            style: GoogleFonts.aclonica(
                                fontSize: 17.0, color: Colors.red)),
                        Text(
                            (widget.cartItem.listColor == null || widget.cartItem.listColor.toString() =="null")
                                ? "":widget.cartItem.listColor.toString().substring(1,widget.cartItem.listColor.toString().length-1),
                                // : widget.cartItem.listColor
                                // .substring(
                                //     2, widget.cartItem.listColor.length - 3)
                                //     ??widget.cartItem.listColor,
                            style: GoogleFonts.aclonica(fontSize: 17.0)),
                      ],
                    )),
              ))
            ],
          ),

          SizedBox(height: 80.0),
          // Consumer<Cart>(
          //     // selector: (context, cartlist) => cartlist.getCartList,
          //     builder: (context, cartNotifier, widget1) {
          //   return Directionality(
          //     textDirection: TextDirection.rtl,
          //     child: Center(
          //       child: InkWell(
          //         onTap: () {
          //           cartNotifier.addToCart(widget.cartItem);

          //           Toast.show("product added successfully", context,
          //               duration: Toast.LENGTH_LONG,
          //               gravity: Toast.CENTER,
          //               backgroundColor: Colors.amber);
          //           print("current cart list: " +
          //               cartNotifier.cartList.length.toString());
          //           setState(() {
          //             // cartCount = cartNotifier.cartList.length;
          //           });
          //           // });
          //         },
          //         child: Container(
          //           height: 45.0,
          //           width: 230.0,
          //           decoration: BoxDecoration(color: Colors.amberAccent[400]),
          //           child: Center(
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 Text("أضف للسلة"),
          //                 SizedBox(width: 10.0),
          //                 Image(
          //                     height: 30.0,
          //                     width: 30.0,
          //                     image: AssetImage(
          //                         "files/imgs/app-ui-ROS888_03.png")),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   );
          // }),
          SizedBox(height: 60.0),
          commonUI.buildFooter()
        ]));
  }
}
