import 'package:Talabatk/Entities/rate.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDailog extends StatefulWidget {
  List<Rate>_rateList=[];
  Alert_Dailog(){
   _rateList=Global.rateList;
  }

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDailog> {
  Color _c = Colors.redAccent;
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(' تقييم الطلب ', style : TextStyle(
          color: Color(int.parse(Global.primaryColor)),
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 17),
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Container(
              width: 220,
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Global.rateList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  String selectedRate2=Global.selectedRate;
                  return SizedBox(
                    width: 35,
                    height: 35,
                    child:FlatButton(

                      onPressed: () {

                        for(int i=0;i<Global.rateList.length;i++) {
                          if(i<=index){
                            Global.rateList[i].selected = Colors.yellow;
                          }
                          else {Global.rateList[i].selected = Colors.black;}

                        }


                        setState(() {

                          selectedRate2=Global.rateList[index].title_ar;
                          Global.selectedRate=selectedRate2;
                        });
                      },
                      child:SizedBox(width: 30,height: 30, child: Icon(
                        Icons.star,color:  Global.rateList[index].selected,
                      )),
                    ),
                  );

                },

              ),
            ),
            Container(
              width:  200.0,
              height: 50,
              child: Text(Global.selectedRate , textAlign: TextAlign.center, style: TextStyle(
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
