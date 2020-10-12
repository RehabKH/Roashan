import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/provider/cart.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:roashan/ui/productDetails.dart';

class ComparisionPage extends StatefulWidget {
  final List<CartModel> cartList;
  ComparisionPage({this.cartList});
  @override
  _ComparisionPageState createState() => _ComparisionPageState();
}

class _ComparisionPageState extends State<ComparisionPage> {
  CommonUI _commonUI;
  bool _loading = true;
  
  @override
  Widget build(BuildContext context) {
    _commonUI = new CommonUI(context);
    return Scaffold(
      appBar: _commonUI.companyAppBar("المقارنات"),
      body: buildComparisionBody(),
    );
  }

  buildComparisionBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
           children: <Widget>[
          SizedBox(height: 20.0),
          buildGridView(180.0),
          _commonUI.buildFooter()
        ]));
  }

  Widget buildGridView(double height) {
    return Consumer<Cart>(builder: (context, cart, child) {
      return Container(
        height: MediaQuery.of(context).size.height - height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(400.0)),
        child:
        //  (_loading)
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
             GridView.builder(
                itemBuilder: (BuildContext context, int index) {
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
                            child: Container(
                              height: 120.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(cart.cartList[index].prodImg),
                                      fit: BoxFit.cover)),
                            ),
                          ),
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
                                        (cart.cartList[index].prodPrice == null)
                                            ? "\$ " + "0"
                                            : "\$ " +
                                                cart.cartList[index]
                                                    .prodPrice
                                                    .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0))),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.favorite,
                                          color: Colors.red),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                              top: 120.0,
                              left: 30.0,
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(cart.cartList[index].prodName,
                                      style: TextStyle(fontSize: 14.0)))),
                          Positioned(
                              top: 140.0,
                              left: 15.0,
                              // width: 200,
                              right: 15.0,
                              // bottom: 20.0,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(cart.cartList[index].prodDetails,
                                    style: TextStyle(fontSize: 13.0)),
                              )),
                          Positioned(
                              top: 205.0,
                              left:
                                  MediaQuery.of(context).size.width / 4 - 40.0,
                              width: 50.0,
                              height: 40.0,
                              child: InkWell(
                                onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new ProductDetails()));
                                 
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
                itemCount: cart.cartList.length,
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
              ),
      );
    });
  }
}
