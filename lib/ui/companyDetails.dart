import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:roashan/models/companyModel.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyDetails extends StatefulWidget {
  // String selectedCompanyName;
   final CompanyModel companyItem;
  CompanyDetails({this.companyItem});
  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  CommonUI _commonUI;
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    _commonUI = new CommonUI(context);
    return Scaffold(
        appBar: _commonUI.companyAppBar("اسم الشركة"),
        body: buildCompanyBody());
  }

  buildCompanyBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(shrinkWrap: true, children: <Widget>[
          SizedBox(height: 20.0),
          _commonUI.searchRow(searchController),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
                height: 30.0,
                width: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _commonUI.buildCategories(_commonUI.categoriesName[0]),
                    SizedBox(width: 10.0),
                    _commonUI.buildCategories(_commonUI.categoriesName[1]),
                    SizedBox(width: 10.0),
                    _commonUI.buildCategories(_commonUI.categoriesName[2]),
                    SizedBox(width: 10.0),
                    _commonUI.buildCategories(_commonUI.categoriesName[3]),
                    SizedBox(width: 10.0),
                  ],
                )),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100.0,
                width: 200.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(image: AssetImage("files/imgs/images.jpg"))

                    // fit: BoxFit.cov

                    ),
              ),
            ],
          ),
          Center(
              child: Text(widget.companyItem.title,
                  style: GoogleFonts.aBeeZee())),
          SizedBox(height: 20.0),
          _buildGridView(),
          _commonUI.buildFooter()
        ]));
  }

  Widget _buildGridView() {
    return Container(
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).size.height / 2 + 100.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              // height: 400.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Stack(
                children: <Widget>[
                  // SizedBox(height:10.0),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: AssetImage("files/imgs/images.jpg")))),
                  Positioned(
                      top: 100.0,
                      left: 40.0,
                      child: Container(
                        height: 30.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                            child: Text("\$ 459",
                                style: TextStyle(color: Colors.white))),
                      )),
                  Positioned(
                      top: 150.0,
                      left: 50.0,
                      child: Container(
                        width: 200.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite, color: Colors.red),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add, color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 180.0,
                      left: 85.0,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text("مثال على العنوان",
                              style: TextStyle(fontSize: 20.0)))),
                  Positioned(
                      top: 210.0,
                      left: 50.0,
                      width: 200,
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                              "مثال يكتب على الوصف هنا ويككتب مثال على الوصف والمنتج",
                              style: TextStyle(fontSize: 17.0)))),
                  Positioned(
                      top: 330.0,
                      left: MediaQuery.of(context).size.width / 4 - 40.0,
                      width: 50.0,
                      height: 40.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amberAccent[400],
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Center(
                            child:
                                Icon(Icons.arrow_forward, color: Colors.white)),
                      ))
                ],
              ));
        },
        itemCount: 5,
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
      ),
    );
  }
}
