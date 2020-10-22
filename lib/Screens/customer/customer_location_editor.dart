import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Talabatk/Entities/global.dart';
import 'dart:async';
import 'package:Talabatk/Entities/location.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'customer_home_page.dart';

class LocationEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();

}

class _State  extends State<LocationEditor>{

  String _locationName = null;
  String _locationNote=null;

  TextEditingController _locationNameController = new TextEditingController();
  TextEditingController _locationNoteController = new TextEditingController();
  Position _currentposition=null;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse(Global.primaryColor)),
          centerTitle: true,
          title:Text(Global.appName,
            style: TextStyle(
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 30
            ),),
          automaticallyImplyLeading: false,
        ),
      floatingActionButton:  Container(

        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor:Color(int.parse(Global.primaryColor)) ,
            child:IconButton(
              icon: Icon(Icons.location_on),

              onPressed: () {
                showAlertDialog(context);
              },
            )
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: Location.getByIdLocation("Location/GetByIdLocation"),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null)
              {
                return Container(
                  child: Center(
                    child: Text("Loading...."  ,style: TextStyle(
                        fontFamily: Global.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(int.parse(Global.primaryColor))
                    ),),
                  ),
                );
              }
            else{
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(

                    title:Center(
                      child: RaisedButton(

                            onPressed: () {

                            },
                            color: Color(int.parse(Global.primaryColor)),
                            elevation: 10.0,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                        child: Text(snapshot.data[index].title ,style: TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white
                        ),),
                      ),
                    ) ,

                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("تثبيت",style: TextStyle(
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Color(int.parse(Global.primaryColor))
      )),
      onPressed: () async {
        setState((){
          _locationName = _locationNameController.text;
          _locationNote = _locationNoteController.text;
        });
        if(_currentposition!=null && _locationName!=null)
          {
            // save new position post request
            // send user to CustomerHomePage()
            SharedPreferences prefs = await SharedPreferences.getInstance();
            int user_id=prefs.getInt('id');
            Location.addLocation("Location/AddLocation",user_id,_currentposition.latitude,_currentposition.longitude,_locationName,_locationNote).then((value){
              Utils.toastMessage("تم الاضافه");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CustomerHomePage()
              ));
            });


          }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: Center(
          child:Text("اضف مكانك الحالي" ,style: TextStyle(
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w800,
          fontSize: 15,
          color: Color(int.parse(Global.primaryColor))
      ))),


      content:Row(
        children: [

          IconButton(
            icon: Icon(Icons.location_on),
            color: Color(int.parse(Global.primaryColor)),
            onPressed: () {
              _currentposition = _getLocation() as Position;
            },
          ),
            Expanded(
            child: new TextField(
              controller: _locationNameController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'اسم المكان' , hintText: 'العمل',),
            ),
          ),
          Expanded(
            child: new TextField(
              controller: _locationNoteController,
              decoration: new InputDecoration(
                labelText: 'ملاحظاتك' , hintText: 'ملاحظات',),
            ),
          )



        ],
      ),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // get current location of user
  Future<Position> _getLocation() async{
    _currentposition = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(_currentposition);
    return _currentposition;
  }

}



