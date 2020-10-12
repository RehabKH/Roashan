import 'package:flutter/material.dart';
import 'package:roashan/ui/commonUI.dart';
import 'package:google_fonts/google_fonts.dart';
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  CommonUI commonUI;

  @override
  Widget build(BuildContext context) {
    commonUI = new CommonUI(context);
    return Scaffold(
      appBar: commonUI.companyAppBar("الاشعارات"),
      body: buildNotificationBody(),
    );
  }
  
  Widget buildNotificationBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              height: MediaQuery.of(context).size.height - 170.0,
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0.0,
                    // shape: ,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage("files/imgs/download.jpg"),
                                backgroundColor: Colors.transparent,
                              ),
                              title: Text('عنوان الاشعار',
                                  style: GoogleFonts.abel(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text("مثال على النص هنا",
                                  style: GoogleFonts.abel(
                                      fontWeight: FontWeight.bold)),
                              trailing: Text("5:12\n المزيد",
                                  style: GoogleFonts.abel(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                              onTap: () {},
                            ),
                          ),
                          // buildFooter()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            commonUI.buildFooter()
          ],
        ));

    //  buildFooter()
  }

}
