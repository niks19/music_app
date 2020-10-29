import 'package:flutter/material.dart';
import 'package:test1/colors.dart';

class Controls extends StatelessWidget {
   final bool isPlaying; 
   Controls({this.isPlaying});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Buttons(icons: Icons.skip_previous,),
          isPlaying ? Buttons(icons: Icons.play_arrow_sharp,):Buttons(icons: Icons.pause_circle_filled_sharp,),
          Buttons(icons: Icons.skip_next_sharp,),
        ],
      ),
    );
  }
  
}
class Buttons extends StatelessWidget {
  final IconData icons;
  const Buttons({this.icons});

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 60,
      width: 60,

      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,boxShadow:  [
      BoxShadow(color: darkPrimaryColor.withOpacity(0.5),
        offset: Offset(5,10),
        spreadRadius: 3,
        blurRadius: 10
    ),
    BoxShadow(color: Colors.white,offset: Offset(-3,-4),spreadRadius: -2,blurRadius: 20
    )
    ],),
    child: Stack(
      children:<Widget> [
          Center(child: Container(
            margin: EdgeInsets.all(6),

            decoration: BoxDecoration(color: Colors.grey,shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: darkPrimaryColor.withOpacity(0.5),
                  offset: Offset(5,10),
                  spreadRadius: 3,
                  blurRadius: 10
              ),
              BoxShadow(color: Colors.white,offset: Offset(-3,-4),spreadRadius: -2,blurRadius: 20
              )
            ]
            ),
          ),),
          Center(child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: primaryColor,shape: BoxShape.circle),
            child: Center(child: Icon(icons,size: 30,color: darkPrimaryColor,)),
          ),),
      ],
    ),
    );
  }
}