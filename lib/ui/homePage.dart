import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image/network.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:roashan/api/favoriteApi.dart';
import 'package:roashan/api/register.dart';
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/provider/cart.dart';
import 'package:roashan/provider/favoriteProvider.dart';
import 'package:roashan/ui/allCompanies.dart';
// import 'package:roashan/ui/cartPage.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:roashan/ui/comparisionPage.dart';
import 'package:roashan/ui/login.dart';
// import 'package:roashan/ui/notificationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = new TextEditingController();
  CommonUI commonUI;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RegisterApi registerApi = new RegisterApi();
  final String serverToken =
      'AAAAnpIkWSk:APA91bEPPV3p7xuZ1ZDE5m2me-dx3Vqep77TmV3aAv11Y1DmA35UNWoOAGk7f7viHmf3jgUKSI9QTZ2-mGMmV_TYQGn2aPQO5Xjv0GJkJYs5hP5KTbK1vRWBza3fF-B9HDDFNXdUt1ze';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  List<String> tokens = new List<String>();
  bool loading = true;
  FavoriteApi favoriteApi = new FavoriteApi();
  List<CartModel> cartList = new List<CartModel>();
  // Cart providerCart = new Cart();
  var categories, campanies;
  // String selectedCompanyName = "",
  //     selectedCompanyID = "",
  //     selectedCompanyImg = "",
  //     selectedCompanyDetails = "";

  List<CartModel> cartObj = new List<CartModel>();
  FavoriteProvider favoriteProvider = new FavoriteProvider();
  String selectedCat = "";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int cartCount = 0;
  var products;

  @override
  void initState() {
    super.initState();
    getUserData();

    // firebaseMessaging.getToken().then((value) {
    //   setState(() {
    //     tokens.add(value);
    //   });
    // print("current token&&&&&&&&&&&&&&&&&&" + tokens[0]);
    // });

    registerApi.getAllProducts().then((val1) {
      registerApi.getAllCategories().then((val2) {
        // print("cat result::::::::::::::::::::::::::$val2");
        // registerApi.getAllCompanies().then((camp) {
        setState(() {
          products = val1;
          categories = val2;
          // campanies = camp;
          print("Cart name:::::::::::::::::::::::::::::::::::::::::::" +
              products.toString());
        });
        for (int i = 0; i < products.length; i++) {
          if (products[i]["user_id"] == userID) {
            print("this item in favorite" + products[i]["user_id"]);
            setState(() {
              CartModel favoriteItem = new CartModel(
                prodName: products[i]["name"],
                prodDetails: products[i]["details"],
                prodImg: products[i]["img"],
                prodDate: DateTime.parse(products[i]["date"]),
                prodID: (products[i]["id"]),
                prodPrice: double.parse(products[i]["price"]),
                userID: products[i]["user_id"],
                catID: products[i]["cat_id"],
                listColor: products[i]["colors"]
                    .toString()
                    .substring(1, products[i]["colors"].toString().length - 1)
                    .replaceAll('"', "")
                    .split(","),
                isFav: false,
              );
              // cartList.add(favoriteItem);
              // favoriteProvider.addToFav(favoriteItem);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                   favoriteProvider =
                    Provider.of<FavoriteProvider>(context, listen: false);
                favoriteProvider.addToFav(favoriteItem);
                });
               
              });
            });
          }
          CartModel cartModel = new CartModel(
            prodName: products[i]["name"],
            prodDetails: products[i]["details"],
            prodImg: products[i]["img"],
            prodDate: DateTime.parse(products[i]["date"]),
            prodID: (products[i]["id"]),
            prodPrice: double.parse(products[i]["price"]),
            userID: products[i]["user_id"],
            catID: products[i]["cat_id"],
            listColor: products[i]["colors"]
                .toString()
                .substring(1, products[i]["colors"].toString().length - 1)
                .replaceAll('"', "")
                .split(","),
            isFav: false,
          );
          bool res = commonUI.isInsideFavorite(cartModel, int.parse(userID));
          print("current fav item :::::" + res.toString());
          setState(() {
            cartList.add(new CartModel(
              prodName: products[i]["name"],
              prodDetails: products[i]["details"],
              prodImg: products[i]["img"],
              prodDate: DateTime.parse(products[i]["date"]),
              prodID: (products[i]["id"]),
              prodPrice: double.parse(products[i]["price"]),
              userID: products[i]["user_id"],
              catID: products[i]["cat_id"],
              listColor: products[i]["colors"]
                  .toString()
                  .substring(1, products[i]["colors"].toString().length - 1)
                  .replaceAll('"', "")
                  .split(","),
              isFav: res,
            ));
          });
        }
        setState(() {
          loading = false;
        });
        // split list of color
        // for(int c =0;c< listColo)
        // });
      });
    });
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    localNotificationInitialize();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      commonUI = CommonUI(context);
    });
    // setState(() {
    //
    //   tokens.add(
    //       "edKfRBp4W2E:APA91bHtZlC0eWfJqxacSJNOFZCw3Tus__pe6HoWXJlizU5deQ0DlbZ2GkP7mFsWlJcBYE-Xtgls9z5XWUCP7CdwJF-ZcFqc-rMQlonJHms4HmSmEX6d-PrC6b1_EGpUQ9l5xsObDBTo");
    //   // print("token beforeLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL" + tokens[0]);
    // });
    // sendAndRetrieveMessage().then((value) async {
    //   print("token&&&&&&&&&&&&&&&&&&" + tokens[0]);
    //   await _showNotification();
    // });
    return WillPopScope(
      onWillPop: () {
        (!commonUI.selectedHome) ? _onWillPop() : _exitApp();
      },
      child: Consumer<Cart>(builder: (context, cart, child) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _buildHomeAppBar(),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: Container(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Container(
                          child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 50.0,
                            // top: 10.0,
                            child: Image(
                                height: 150.0,
                                width: 150.0,
                                fit: BoxFit.contain,
                                color: Colors.white.withOpacity(0.5),
                                image: AssetImage(
                                    "files/imgs/app-ui-ROS_012_05.png")),
                          ),
                          Positioned(
                              left: 10.0,
                              top: 10.0,
                              child: Text((name == null) ? 'user name' : name,
                                  style: GoogleFonts.abel(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ],
                      )),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent[400],
                      ),
                    ),
                    ListTile(
                      title: Text('جميع الشركات',
                          style: GoogleFonts.abel(
                              fontSize: 17.0, fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => new AllCompanies()));
                        // setState(() {
                        //   commonUI.selectedSection = false;
                        //   commonUI.selectedHome = false;
                        //   commonUI.selectedFavorite = false;
                        //   commonUI.selectedCompany = false;
                        //   commonUI.selectedComparision = false;
                        //   commonUI.selectedAllCompanies = true;
                        //   commonUI.selectedProduct = false;
                        //   commonUI.selectedNotification = false;
                        // });
                        // Navigator.of(context).pop();
                      },
                    ),
                    // ListTile(
                    //   title: Text('المقارنات',
                    //       style: GoogleFonts.abel(
                    //         fontSize: 17.0,
                    //         fontWeight: FontWeight.bold,
                    //       )),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => new ComparisionPage()));
                    //   },
                    // ),
                    // ListTile(
                    //   title: Text('الاشعارات',
                    //       style: GoogleFonts.abel(
                    //         fontSize: 17.0,
                    //         fontWeight: FontWeight.bold,
                    //       )),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => new NotificationPage()));
                    //   },
                    // ),
                    // ListTile(
                    //   title: Text('السلة',
                    //       style: GoogleFonts.abel(
                    //           fontSize: 17.0, fontWeight: FontWeight.bold)),
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => new CartPage()));
                    //   },
                    // ),
                    ListTile(
                      title: Text('تسجيل الخروج',
                          style: GoogleFonts.abel(
                              fontSize: 17.0, fontWeight: FontWeight.bold)),
                      onTap: () {
                        clearSharedPref();

                        // setState(() {
                        //   commonUI.selectedSection = false;
                        //   commonUI.selectedHome = false;
                        //   commonUI.selectedFavorite = false;
                        //   commonUI.selectedCompany = false;
                        //   commonUI.selectedComparision = false;
                        //   commonUI.selectedAllCompanies = false;
                        //   commonUI.selectedProduct = false;
                        //   commonUI.selectedNotification = false;
                        // });
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: (loading)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.amberAccent[400],
                        ),
                      ),
                    ],
                  )
                : Container(
                    // height: MediaQuery.of(context).size.height,
                    child: ListView(
                      // shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        commonUI.searchRow(searchController),
                        ///////////////////////////////////////////////////////////////
                        // (!commonUI.selectedSection)
                        //     ? commonUI.searchRow(searchController)
                        //     : Container(),
                        SizedBox(height: 20.0),
                        commonUI.buildGridView(
                            260.0, cartList, int.parse(userID), "home"),
                        //  SizedBox(height:10.0),
                        commonUI.buildFooter()
                      ],
                    ),
                  ));
      }),
    );
  }

  // Widget _buildChoosePage(IconData icon, String name) {
  //   return Column(
  //     children: <Widget>[
  //       SizedBox(height: 5.0),
  //       Icon(icon, color: Colors.black),
  //       SizedBox(height: 5.0),
  //       Text(name)
  //     ],
  //   );
  // }

  // Widget _buildGridView() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height - 330.0,
  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
  //     child: GridView.builder(
  //       itemBuilder: (BuildContext context, int index) {
  //         return Container(
  //             // height: 400.0,
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(20.0)),
  //             child: Stack(
  //               children: <Widget>[
  //                 // SizedBox(height:10.0),
  //                 Positioned(
  //                     top: 10.0,
  //                     child: Image.asset("files/imgs/images (1).jpg")),
  //                 Positioned(
  //                     top: 100.0,
  //                     left: 40.0,
  //                     child: Container(
  //                       height: 30.0,
  //                       width: 50.0,
  //                       decoration: BoxDecoration(
  //                           color: Colors.black,
  //                           borderRadius: BorderRadius.circular(5.0)),
  //                       child: Center(
  //                           child: Text("\$ 459",
  //                               style: TextStyle(color: Colors.white))),
  //                     )),
  //                 Positioned(
  //                     top: 150.0,
  //                     left: 50.0,
  //                     child: Container(
  //                       width: 200.0,
  //                       height: 30.0,
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(5.0)),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: <Widget>[
  //                           IconButton(
  //                             onPressed: () {},
  //                             icon: Icon(Icons.favorite, color: Colors.red),
  //                           ),
  //                           IconButton(
  //                             onPressed: () {},
  //                             icon: Icon(Icons.add, color: Colors.grey),
  //                           ),
  //                         ],
  //                       ),
  //                     )),
  //                 Positioned(
  //                     top: 180.0,
  //                     left: 85.0,
  //                     child: Directionality(
  //                         textDirection: TextDirection.rtl,
  //                         child: Text("مثال على العنوان",
  //                             style: TextStyle(fontSize: 20.0)))),
  //                 Positioned(
  //                     top: 210.0,
  //                     left: 50.0,
  //                     width: 200,
  //                     child: Directionality(
  //                         textDirection: TextDirection.rtl,
  //                         child: Text(
  //                             "مثال يكتب على الوصف هنا ويككتب مثال على الوصف والمنتج",
  //                             style: TextStyle(fontSize: 17.0)))),
  //                 Positioned(
  //                     top: 330.0,
  //                     left: MediaQuery.of(context).size.width / 4 - 40.0,
  //                     width: 50.0,
  //                     height: 40.0,
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         color: Colors.amberAccent[400],
  //                         borderRadius: BorderRadius.circular(7.0),
  //                       ),
  //                       child: Center(
  //                           child:
  //                               Icon(Icons.arrow_forward, color: Colors.white)),
  //                     ))
  //               ],
  //             ));
  //       },
  //       itemCount: 5,
  //       //_allCompanies.length,
  //       // primary: false,
  //       padding: const EdgeInsets.only(left: 20, right: 20.0),
  //       gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 5.0,
  //         //for height of card
  //         childAspectRatio: 0.9,
  //         //for horizontal space
  //         mainAxisSpacing: 6.0,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCategories(String name) {
  //   return Center(
  //     child: Container(
  //         color: Colors.amberAccent[400],
  //         child: Padding(
  //           padding: const EdgeInsets.all(3.0),
  //           child: Row(
  //             children: <Widget>[
  //               Icon(Icons.keyboard_arrow_down, color: Colors.black),
  //               SizedBox(width: 10.0),
  //               Text(
  //                 name,
  //               )
  //             ],
  //           ),
  //         )),
  //   );
  // }

  ///////////////////////////////selections body
  Widget _builsSelectionBody() {
    return Container(
      height: MediaQuery.of(context).size.height - 220.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              registerApi
                  .getProductsWithCat(categories[index]["id"])
                  .then((val) {
                setState(() {
                  commonUI.selectedSection = false;
                  commonUI.selectedHome = true;
                  commonUI.selectedFavorite = false;
                  commonUI.selectedCompany = false;
                  commonUI.selectedComparision = false;
                  commonUI.selectedAllCompanies = false;
                  commonUI.selectedProduct = false;
                  commonUI.selectedNotification = false;
                });
              });
              // setState(() {
              //   selectedCat = categories[index]["id"];
              // });
            },
            child: Container(
                // height: 400.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    // SizedBox(height:10.0),
                    Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: categories[index]["img"],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: 10.0),

                    Text(categories[index]["name"])
                  ],
                )),
          );
        },
        itemCount: categories.length,
        //_allCompanies.length,
        // primary: false,
        padding: const EdgeInsets.only(left: 20, right: 20.0),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          //for height of card
          childAspectRatio: 1.1,
          //for horizontal space
          mainAxisSpacing: 15.0,
        ),
      ),
    );
  }

  Widget _buildHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.amberAccent[400],
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          // height: 15.0,
          // width:15.0,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          child: new IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.amberAccent[400],
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
      ),
      title: Image(
        image: AssetImage("files/imgs/app-ui-ROS_012_05.png"),
        height: 40.0,
        width: 40.0,
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Image.asset("files/imgs/app-ui-ROS_012_07.png",
              height: 20.0, width: 20.0),
        ),
      ],
    );
  }

  //////////////////////////////// home appbar
  //  Widget _buildHomeAppBar(){
  //   return AppBar(
  //               backgroundColor: Colors.amberAccent[400],
  //               leading: Padding(
  //                 padding: const EdgeInsets.only(left: 10.0),
  //                 child: Container(
  //                   height: 40.0,
  //                   width: 40.0,
  //                   decoration: BoxDecoration(
  //                       shape: BoxShape.circle, color: Colors.black),
  //                   child: new IconButton(
  //                     icon: Icon(
  //                       Icons.menu,
  //                       color: Colors.amberAccent[400],
  //                     ),
  //                     onPressed: () {},
  //                   ),
  //                 ),
  //               ),
  //               title:Text("الرئيسية"),
  //               centerTitle: true,
  //               actions: <Widget>[
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 10.0),
  //                   child: Image.asset("files/imgs/app-ui-ROS_012_07.png",
  //                       height: 20.0, width: 20.0),
  //                 ),
  //               ],
  //             );
  // }
  ///////////////////////////////////grid view of all companies

  //////////////////////////////////////specify company

  String type, name, email, mobile, imgPath, userID;
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      type = prefs.getString("type");
      name = prefs.getString("name");
      email = prefs.getString("email");
      mobile = prefs.getString("mobile");
      imgPath = prefs.getString("img");
      userID = prefs.getString("userID");
    });
  }

  Future<void> clearSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => new LoginPage()));
  }

  _onWillPop() {
    if (!commonUI.selectedHome) {
      setState(() {
        commonUI.selectedSection = false;
        commonUI.selectedHome = true;
        commonUI.selectedFavorite = false;
        commonUI.selectedCompany = false;
        commonUI.selectedComparision = false;
        commonUI.selectedAllCompanies = false;
        commonUI.selectedProduct = false;
        commonUI.selectedNotification = false;
      });
    }
  }

  Future<bool> _exitApp() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure'),
                Text('you want to exit'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Logout'),
              onPressed: () {
                // FirebaseAuth.instance.signOut();
                exit(0);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> new ))
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    // setState(() {
    //   messages
    //       .add(Message(title: titleController.text, body: bodyController.text));
    // });

    await flutterLocalNotificationsPlugin.show(
        0, "welcome from title", "welcome from body", platformChannelSpecifics,
        payload: 'item x');
  }

  ////////////////send notification
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    print("token:::::::::::::::::::::::::::::::::::::::::" + tokens[0]);
    // _firebaseMessaging.subscribeToTopic("all");
    for (int i = 0; i < tokens.length; i++) {
      await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "hello from notification body",
              'title': "hello from notification title"
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': tokens[i],
          },
        ),
      );
    }
  }

  void localNotificationInitialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings(
        'icon1'); // <- default icon name is @mipmap/ic_launcher
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      // selectNotificationSubject.add(payload);
    });
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }
}
