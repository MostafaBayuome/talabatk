import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';



class use_policy extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<use_policy>  {

  // true signup => SHOP  false => CUSTOMER
  @override
  void initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(

                child:Hero(
                    tag:'title',
                    child: Utils.title(50, 50)),
              ),
           Container(
             height: 500,
             width: 350,
             child:  ListView(
                 scrollDirection: Axis.horizontal,
                 children: <Widget>[
             Row(
             children: <Widget>[

               Container(
                 width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen1.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width:7 ,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen2.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 7,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen3.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 7,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen4.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width:7 ,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen5.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen1.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen1.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen1.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/screen1.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),
            ] ),
           ])
          ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: RaisedButton(

                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () async {
                    /*
                    try{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setInt('FirstEnter',1);
                    }
                    catch (Excepetion)
                    {}
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>Login()
                    ));
                    */
                  },
                  color: Color(int.parse(Global.primaryColor)),
                  child: Text(
                   'Next',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                ),
              )
            ],

          ),
        ),

      ),
    );
  }

}