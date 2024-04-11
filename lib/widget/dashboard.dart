import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app1/utils/My_Routes.dart';

class dashboard extends StatefulWidget{
  @override
  State<dashboard> createState() => _loginState();
}

class _loginState extends State<dashboard> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController cpasswordcontroller=TextEditingController();

  void createAccount() async{
    String email=emailcontroller.text.trim();
    String password=passwordcontroller.text.trim();
    String cpassword=cpasswordcontroller.text.trim();
    if(email=="" || password==""|| cpassword=="") {
      log("fill all the details");
    }
    else if(password != cpassword)
    {
      log("password should same");
    }
    else{
      try
      {
        UserCredential userCredential = await
        FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        // if(userCredential!=null){
          await Navigator.pushNamed(context, MyRoutes.loginRoute);
        // }
        log("user created");
      }
      on FirebaseAuthException catch(ex){

        log(ex.code.toString());
      }
    }

  }

  String name="";
  bool changebutton=false;
  //for global
  final _formkey=GlobalKey<FormState>();

  // moveToHome(BuildContext context) async{
  //
  //   if(_formkey.currentState!.validate())
  //   {
  //     setState(() {
  //       changebutton=true;
  //     });
  //     await Future.delayed(Duration(seconds: 1));
  //     await Navigator.pushNamed(context, MyRoutes.loginRoute);
  //     setState(() {
  //       changebutton=false;
  //     });
  //   }
  //
  // }

  @override
  Widget build(BuildContext context){
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Image.asset("assets/images/hey.png",
                fit: BoxFit.cover,),

              SizedBox(height: 20,),

              Text("Signup",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: "Username",
                        labelText: "Enter Username",
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty) {
                          return "Username must be entered";
                        }
                        return null;
                      },
                      // onChanged: (value){
                      //   name=value;
                      //   //set state ko call krne pr hi welcome ke saath name judega kuki ye refresh kreaga site ke iss part ko
                      //   setState(() {
                      //
                      //   });
                      // },

                    ),

                    TextFormField(
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Enter Password",
                      ),
                      obscureText:true,
                      validator: (value){
                        if(value == null || value.isEmpty) {
                          return "Enter your password";
                        }
                        else if(value.length<6)
                        {
                          return "length should be 6 atleast";
                        }
                        return null;
                      },

                      onChanged: (value){
                        name=value;
                        //set state ko call krne pr hi welcome ke saath name judega kuki ye refresh kreaga site ke iss part ko
                        setState(() {

                        });
                      },
                    ),


                    TextFormField(
                      controller: cpasswordcontroller,
                      decoration: InputDecoration(
                        hintText: "Re-Enter-Password",
                        labelText: "Re-Enter-Password",
                      ),
                      obscureText:true,
                      validator: (value){
                        if(value == null || value.isEmpty) {
                          return "Enter your password";
                        }
                        else if(value.length<6)
                        {
                          return "length should be 6 atleast";
                        }
                        else if(name!=value)
                          {
                            return "password did not Match";
                          }
                        return null;
                      },
                    ),


                  ],
                ),
              ),

              SizedBox(height: 40.0,),

             CupertinoButton(
               onPressed: (){
                 createAccount();
               },
               color: Colors.deepPurple,
               child: Text("submit"),
             ),
             ]

             // / Material(
              //   borderRadius: BorderRadius.circular(changebutton?20:8),
              //   color: Colors.deepPurple,
              //   child: InkWell(
              //     //ye simple on tap h jo hme kevl animation show krega laekin new page pe nhi leke jayega
              //     // onTap: (){
              //     //   // Navigator.pushNamed(context, MyRoutes.homeRoute);
              //     //  setState(() {
              //     //    changebutton=true;
              //     //  });
              //     // },
              //     //splashColor: Colors.red,
              //     //new page pe jaane ke liye ontap me await future.delayed add krna padeaga
              //     // onTap: () =>moveToHome(context),
              //     onTap:()=>createAccount(),
              //     //AnimatedContainer is same as Conatainer but here we can add Animation where duration is **compulsory
              //     //lekin hme decoration or accha krna h to hm Ink widget use kr skte h Animated container ki jgh
              //     //jisme durtion and alignment htana padega
              //     //ink widget me hme click pr hm splash color ka effect lga skte h jjo ki InkWell ke saath kam krta h
              //     child: AnimatedContainer(
              //       // child:Ink(
              //       duration:Duration(seconds: 1),
              //       height: 50,
              //       width: changebutton?50 :150,
              //       alignment: Alignment.center,
              //       // color: Colors.deepPurple,
              //       //hme ab agr koi icon lagana h tap krte hi to yha pr condition
              //       child:changebutton?Icon(Icons.done,color: Colors.white,): Center(child: Text("Submit",style: TextStyle(color: Colors.white),)),
              //       //   decoration: BoxDecoration(
              //       //     // borderRadius: BorderRadius.circular(5),
              //       //     // borderRadius: BorderRadius.circular(changebutton?20:8),
              //       //     //if we use shape then we cannot use borderRadius otherwise it will give error
              //       //     shape:changebutton? BoxShape.circle: BoxShape.rectangle,
              //       //
              //       //     color: Colors.deepPurple,
              //       //
              //       // ),
              //
              //       // ElevatedButton(
              //       //   style: TextButton.styleFrom(minimumSize:Size(100, 50)),
              //       //     onPressed: (){
              //       //           Navigator.pushNamed(context, MyRoutes.homeRoute);
              //       //     }, child: Text("Login",),)
              //     ),
              //   ),
              // )],
          ),
        ),
      ),

    );
  }
}