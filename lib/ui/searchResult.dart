import 'package:flutter/material.dart';
import 'package:roashan/models/cartModel.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResult extends StatefulWidget {
  final List<CartModel> serachResult;
  SearchResult({this.serachResult});
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  CommonUI commonUI;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    print(widget.serachResult.length.toString());
    getUserID().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Result",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:(loading)
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
          height: MediaQuery.of(context).size.height - 150.0,
          child: commonUI.buildGridView(
              100.0, widget.serachResult, int.parse(userID), "search")),
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
