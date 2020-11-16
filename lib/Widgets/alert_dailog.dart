import 'package:Talabatk/Entities/rate.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/user_rate.dart';
import 'package:Talabatk/Widgets/utils.dart';
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
        height: 220,
        child: Column(
          children: [
            Container(
              width: 220,
              height: 80,
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
                          Global.selectedRateID=Global.rateList[index].id;

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
              height: 40,
              child: Text(Global.selectedRate , textAlign: TextAlign.center, style: TextStyle(
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
            ),
            Container(
              width:  200.0,
              height: 40,
              child: FlatButton(
                child:Text("ارسل"),
                onPressed: (){
                  if(Global.selectedRateID==0){

                  }
                  else{
                    User_rate.addUserRate(new User_rate(0, Global.loginUser.id, Global.selectedRequestID, Global.selectedRateID, "comment", "note")).then((value) => {
                      Utils.toastMessage("شكرا لتقييمك الطلب"),
                        Navigator.pop(context)
                    });
                  }
                },

                  ),
            ),
          ],
        ),
      ),
    );
  }
}
