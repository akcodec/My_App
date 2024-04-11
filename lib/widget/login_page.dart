import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app1/utils/My_Routes.dart';
import 'package:my_app1/widget/Home_page.dart';

class login extends StatefulWidget{
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String name="";
  bool changebutton=false;
  //for global

  // final _formkey=GlobalKey<FormState>();
  //
  // moveToHome(BuildContext context) async{
  //
  //  if(_formkey.currentState!.validate())
  //    {
  //      setState(() {
  //        changebutton=true;
  //      });
  //      await Future.delayed(Duration(seconds: 1));
  //      await Navigator.pushNamed(context, MyRoutes.homeRoute);
  //      setState(() {
  //        changebutton=false;
  //      });
  //    }
  //
  // }
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();


  void signAccount() async{
    String email=emailcontroller.text.trim();
    String password=passwordcontroller.text.trim();

    if(email=="" || password=="") {
      log("fill all the details");
    }

    else{
      try
      {
        UserCredential userCredential = await
        FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        // if(userCredential!=null){
        await Navigator.pushNamed(context, MyRoutes.homeRoute);
        // }
        log("user loged in");
      }
      on FirebaseAuthException catch(ex){

        log(ex.code.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context){
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          // key: _formkey,
          child: Column(
            children: [
              Image.asset("assets/images/hey.png",
                fit: BoxFit.cover,),

              SizedBox(height: 20,),

              Text("Welcome $name",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                   TextFormField(
                     controller:emailcontroller,
                      decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Enter Email",
                      ),
                     validator: (value){
                       if(value == null || value.isEmpty) {
                         return "Username must be entered";
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
                    ),


                  ],
                ),
              ),

              SizedBox(height: 40.0,),

              Material(
                borderRadius: BorderRadius.circular(changebutton?20:8),
                color: Colors.deepPurple,
                child: InkWell(
                  //ye simple on tap h jo hme kevl animation show krega laekin new page pe nhi leke jayega
                  // onTap: (){
                  //   // Navigator.pushNamed(context, MyRoutes.homeRoute);
                  //  setState(() {
                  //    changebutton=true;
                  //  });
                  // },
                  //splashColor: Colors.red,
                  //new page pe jaane ke liye ontap me await future.delayed add krna padeaga
                  onTap: () =>signAccount(),
                  //AnimatedContainer is same as Conatainer but here we can add Animation where duration is **compulsory
                  //lekin hme decoration or accha krna h to hm Ink widget use kr skte h Animated container ki jgh
                  //jisme durtion and alignment htana padega
                  //ink widget me hme click pr hm splash color ka effect lga skte h jjo ki InkWell ke saath kam krta h
                  child: AnimatedContainer(
                  // child:Ink(
                    duration:Duration(seconds: 1),
                    height: 50,
                    width: changebutton?50 :150,
                    alignment: Alignment.center,
                    // color: Colors.deepPurple,
                    //hme ab agr koi icon lagana h tap krte hi to yha pr condition
                    child:changebutton?Icon(Icons.done,color: Colors.white,): Center(child: Text("Login",style: TextStyle(color: Colors.white),)),
                  //   decoration: BoxDecoration(
                  //     // borderRadius: BorderRadius.circular(5),
                  //     // borderRadius: BorderRadius.circular(changebutton?20:8),
                  //     //if we use shape then we cannot use borderRadius otherwise it will give error
                  //     shape:changebutton? BoxShape.circle: BoxShape.rectangle,
                  //
                  //     color: Colors.deepPurple,
                  //
                  // ),

                  // ElevatedButton(
                  //   style: TextButton.styleFrom(minimumSize:Size(100, 50)),
                  //     onPressed: (){
                  //           Navigator.pushNamed(context, MyRoutes.homeRoute);
                  //     }, child: Text("Login",),)
                  ),
                ),
              )],
          ),
        ),
      ),
    
    );
  }
}