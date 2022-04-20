import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/constants.dart';


class CardWidget extends StatelessWidget {
  final String menuTitle;
  final Icon menuIcon;

  CardWidget(this.menuTitle,this.menuIcon);

  _icon(Icon icon){
    return Container(
    child: icon,
    );
  }

  _titleLayout(String title){
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(Constants.padding),
          width: double.infinity,
          child: Text(
            title,textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 2,// Constants.cardElevation,
          shape: RoundedRectangleBorder(
            // side: BorderSide(
            //     color: Colors.white70, width: Constants.borderSideWidth),
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          child: Container(
            height: Constants.cardHeight,
            decoration: BoxDecoration(
              // border: Border.all(
              //     color: Colors.blue
              // ),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child:  _icon(menuIcon),
                ),
                Align(
                  alignment: Alignment.center,
                  child: _titleLayout(menuTitle),
                )
              ],
            ),
          ));
    }

}
