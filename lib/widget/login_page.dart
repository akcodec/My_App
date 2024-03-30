import 'package:flutter/material.dart';

class login extends StatelessWidget{
  var name;
  @override
  Widget build(BuildContext context){
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset("assets/images/login.png",
            fit: BoxFit.cover,),

          SizedBox(height: 20,),

          Text("Welcome",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
               TextFormField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    labelText: "Enter Username",
                  ),
               ),
            
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Enter Password",
                  ),
                  obscureText:true,
            
                ),


              ],
            ),
          ),

          SizedBox(height: 20.0,),

          ElevatedButton(
            style: TextButton.styleFrom(
              // primary: Colors.blue[2000],

            ),
              onPressed: (){

              }, child: Text("Login",),)
        ],
      ),

    );
  }
}