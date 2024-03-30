import "package:flutter/material.dart";

class classTwo extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        height: 200,
        width: 300,
        color: Colors.brown,
        child:Center(
          child: Text("class2"),
        ) ,
      ),
    );
  }
}