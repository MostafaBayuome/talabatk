import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/location.dart';
import 'package:Talabatk/Entities/offer.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:Talabatk/Entities/app_localizations.dart';

class AllOffers extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AllOffers> {


  @override
  Widget build(BuildContext context) {
    String _title= AppLocalizations.of(context).translate('all_offers');
    return Scaffold(
      appBar: Utils.appBarusers(context,_title),
      body: Container(
        child: FutureBuilder(
          future: Offer.getOfferByShopId(Global.loginUser.id),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null)  {
              return Container(
                child: Center(
                    child: CircularProgressIndicator()
                ),
              );
            }
            else{
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                        child: Row(
                          children: [

                            Expanded(
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
                                child: Text(snapshot.data[index].description ,style: TextStyle(
                                    fontFamily: Global.fontFamily,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white
                                ),),
                              ),
                            ),
                            SizedBox(width: 10,),
                            SizedBox.fromSize(
                              size: Size(40, 40), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color:  Colors.redAccent, // button color
                                  child: InkWell(
                                    splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                                    onTap: () {

                                    }, // button pressed
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.delete,color: Colors.white,size: 15,), // icon
                                        Text(AppLocalizations.of(context).translate('delete')  , style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),), // text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  );

                },
              );
            }
          },
        ),
      ),
    );
  }
}