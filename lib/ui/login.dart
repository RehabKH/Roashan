import 'package:flutter/material.dart';
import 'package:roashan/api/register.dart';
import 'package:roashan/ui/homePage.dart';
import 'package:roashan/ui/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkBoxValue = false;
  RegisterApi registerApi = new RegisterApi();
  bool loading = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool loadingLogin = false;
  bool invisiblePass = false;

  switchInvisiblePass() {
    setState(() {
      invisiblePass = !invisiblePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        backgroundColor: Colors.black26,
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // SizedBox(height:40.0),
            Form(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Image.asset("files/imgs/app-ui-ROS_012_05.png"),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 10.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.amberAccent[400],
                            primaryColorDark: Colors.amberAccent[400],
                          ),
                          child: TextFormField(
                            // style:  TextStyle(color:Colors.white),

                            onChanged: (val) {
                              // updateTitle();
                            },
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "الايميل",
                                labelText: "الايميل",
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
                                      color: Colors.white,
                                      style: BorderStyle.solid),

                                  // color:Colors.grey
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.amberAccent[400],
                            primaryColorDark: Colors.amberAccent[400],
                          ),
                          child: TextFormField(
                            obscureText: !invisiblePass,
                            onChanged: (val) {
                              // updateTitle();
                            },
                            controller: passController,
                            
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(icon: Icon((!invisiblePass)?Icons.visibility_off:Icons.visibility),
                                onPressed: switchInvisiblePass,
                                ),
                                // enabled: !invisiblePass,
                                hintText: "كلمة المرور",
                                labelText: "كلمة المرور",
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
                                      color: Colors.white,
                                      style: BorderStyle.solid),

                                  // color:Colors.grey
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // ,SizedBox(height:10.0),
                          SizedBox(
                            width: 100,
                            child: Row(
                              children: <Widget>[
                                new Checkbox(

                                    // hoverColor: Colors.amberAccent[400],
                                    focusColor: Colors.amberAccent[400],
                                    // tristate: true,
                                    // autofocus: true,
                                    
                                    value: checkBoxValue,
                                    activeColor: Colors.amberAccent[400],
                                    checkColor: Colors.black,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        checkBoxValue = newValue;
                                      });
                                    }),
                                Text("تزكرني",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Text(
                            "نسيت كلمة السر ؟",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        registerApi
                            .login(emailController.text, passController.text)
                            .then((val) {
                          if (val == "success") {
                            setState(() {
                              loading = false;
                            });

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => new HomePage()));
                          } else {
                            Toast.show(val, context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.TOP,
                                backgroundColor: Colors.amberAccent[400],
                                textColor: Colors.black);
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
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Text("سجل دخول",
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5),
                                    ))),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ـــــــــــــ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          " او ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "ـــــــــــــ",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                          // border:BoxBorder.
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            " سجل الدخول عن طريق الفيس بوك",
                            style: TextStyle(color: Colors.white),
                          ),
                          // Icon(Icons.)
                          Text("|",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.grey)),
                          Text(
                            "سجل الدخول عن طريق جوجل ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new RegisterPage()));
                        },
                        child: Text(
                          "تسجيل حساب جديد",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
