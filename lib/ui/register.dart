import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roashan/api/register.dart';
import 'package:roashan/ui/homePage.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  RegisterApi registerApi = new RegisterApi();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        body: ListView(
          shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 10.0),
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amberAccent[400],
                      ),
                      child: Center(
                          child: Icon(Icons.arrow_forward,
                              size: 15.0, color: Colors.black)),
                    )
                  ],
                ),
              ),
            ),
            Form(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Image.asset("files/imgs/app-ui-ROS_012_05.png"),
                    SizedBox(height: 30.0),
                    _buildTextField(
                        "الاسم", nameController, TextInputType.text),
                    SizedBox(height: 10.0),
                    _buildTextField(
                        "الايميل", emailController, TextInputType.emailAddress),
                    SizedBox(height: 10.0),
                    _buildTextField("كلمة المرور", passController,
                        TextInputType.visiblePassword),
                    SizedBox(height: 10.0),
                    _buildTextField(
                        "رقم الجوال", phoneController, TextInputType.phone),
                    SizedBox(height: 10.0),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        registerApi
                            .signUp(nameController.text, emailController.text,
                                phoneController.text, passController.text)
                            .then((val) {
                          setState(() {
                            loading = false;
                          });
                          if (val == "success") {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => new HomePage()));
                          }
                          else{
                            Toast.show(val, context,duration: Toast.LENGTH_LONG,gravity: Toast.TOP,backgroundColor: Colors.amberAccent[400],textColor: Colors.black);
                          }
                        });
                      },
                      child: Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width - 60.0,
                          decoration: BoxDecoration(
                              color: Colors.amberAccent[400],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                              child: (loading)
                                  ? CircularProgressIndicator()
                                  : Text("تسجيل حساب جديد",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5),
                                      )))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      TextInputType textInputType) {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Theme(
          data: new ThemeData(
            primaryColor: Colors.amberAccent[400],
            primaryColorDark: Colors.amberAccent[400],
          ),
          child: TextFormField(
            keyboardType: textInputType,
            controller: controller,
            style: TextStyle(color: Colors.white),
            onChanged: (val) {
              // updateTitle();
            },
            decoration: InputDecoration(
                hintText: hint,
                labelText: hint,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),

                  borderSide: BorderSide(
                      color: Colors.grey[600].withOpacity(0.8),
                      style: BorderStyle.solid),

                  // color:Colors.grey
                ),
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),

                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),

                  // color:Colors.grey
                )),
          ),
        ),
      ),
    );
  }
}
