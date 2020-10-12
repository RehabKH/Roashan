import 'package:flexible/flexible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:roashan/api/register.dart';
import 'package:roashan/models/companyModel.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:roashan/ui/companyDetails.dart';
import 'package:roashan/ui/productDetails.dart';

class AllCompanies extends StatefulWidget {
  @override
  _AllCompaniesState createState() => _AllCompaniesState();
}

class _AllCompaniesState extends State<AllCompanies> {
  CommonUI commonUI;
  RegisterApi registerApi = new RegisterApi();
  var companies;
  bool _loading = true;
  List<CompanyModel> companyList = new List<CompanyModel>();
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerApi.getAllCompanies().then((camp) {
      setState(() {
        _loading = false;
        companies = camp;
      });
      print("companies::::::::::::::::::::::::::" + companies.toString());
      for (int i = 0; i < companies.length; i++) {
        setState(() {
          companyList.add(CompanyModel(companies[i]["title"],
              companies[i]["details"], companies[i]["img"]));
        });
      }
      setState(() {
        _loading = false;
        // companies = camp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: commonUI.companyAppBar("جميع الشركات"),
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
            child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(height: 20.0),
        commonUI.searchRow(searchController),
        SizedBox(height: 20.0),

        ///////////////////////////////////////////////////////////////
        // (!commonUI.selectedSection)
        //     ? commonUI.searchRow(searchController)
        //     : Container(),

        Container(
          height: MediaQuery.of(context).size.height - 250.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: GridView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => new ProductDetails(companyList[index])));
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => new CompanyDetails(
                  //           companyItem: companyList[index],
                  //         )));
                },
                child: Container(
                    // height: 400.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Column(
                      children: <Widget>[
                        // SizedBox(height:10.0),
                        ScreenFlexibleWidget(
                            // 1. Wrap with `ScreenFlexibleWidget`

                     child: Builder(builder: (BuildContext context) {
                          return Container(
                              height: 80.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    
                                      image: NetworkImageWithRetry(
                                        
                                          "http://" +companyList[index].imgUrl??
                    "http://ros.vision.com.sa/userfiles/5e27052463fe8_name.png"),
                                      fit: BoxFit.contain)));
                        })),

                        SizedBox(height: 10.0),

                        Text(companyList[index].title)
                      ],
                    )),
              );
            },
            itemCount: companyList.length,
            //_allCompanies.length,
            // primary: false,
            padding: const EdgeInsets.only(left: 20, right: 20.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15.0,
              //for height of card
              childAspectRatio: 0.8,
              //for horizontal space
              mainAxisSpacing: 15.0,
            ),
          ),
//               child:    FutureBuilder<CompanyModel>(
//     future: registerApi.getAllCompanies(),
//     builder: (context, snapshot) {
//         return Container(
//                         // height: 400.0,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20.0)),
//                         child: Column(
//                           children: <Widget>[
//                             // SizedBox(height:10.0),
//                             ScreenFlexibleWidget(
//                                 // 1. Wrap with `ScreenFlexibleWidget`

//                                 child: Builder(builder: (BuildContext context) {
//                               return Container(
//                                   height: 80.0,
//                                   width: 80.0,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15.0),
//                                       image: DecorationImage(
//                                           image: NetworkImageWithRetry(
//                                               snapshot.data.imgUrl),
//                                           fit: BoxFit.cover)));
//                             })),

//                             SizedBox(height: 10.0),

//                             Text(snapshot.data.title)
//                           ],
//                         ),
//                   );
//     }
// ),
        ),
        commonUI.buildFooter()
      ],
    ));
  }
}
