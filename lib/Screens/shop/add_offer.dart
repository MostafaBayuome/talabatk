import 'dart:io';
import 'dart:typed_data';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/offer.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddOffer extends StatefulWidget {
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {

  DateTime _startDate=DateTime.now();
  DateTime _endDate=DateTime.now().add(Duration(days: 7));
  List<Asset> images = List<Asset>();
  String image1="";
  Uint8List bytes;
  final myController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBarusers(context,AppLocalizations.of(context).translate('add_new_offer')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget> [
            Container(
              child: TextField(
                controller: myController,
                decoration:  InputDecoration(helperText: AppLocalizations.of(context).translate('offer_description')),
              )
            ),
            Container(margin: EdgeInsets.only(top:10.0),),
            Align(
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color:Color(int.parse(Global.primaryColor)),
                  child: Text( AppLocalizations.of(context).translate('choose_date'),style:TextStyle(
                      color: Colors.white,
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                  )),
                  onPressed: () async {
                   await displayDateRangePicker(context);
                  }),
            ),
            Container(margin: EdgeInsets.only(top:10.0),),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_startDate.toString().substring(0,10),style:TextStyle(
                        fontFamily: Global.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                    )),
                    Container(margin: EdgeInsets.only(left:10.0),),
                    Text(AppLocalizations.of(context).translate('to')),
                    Container(margin: EdgeInsets.only(left:10.0),),
                    Text(_endDate.toString().substring(0,10),style:TextStyle(
                        fontFamily: Global.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                    )),
              ],
            ),
            Container(margin: EdgeInsets.only(top:10.0),),
            Container(
                child: Center(
                    child: SizedBox.fromSize(
                      size: Size(60, 60), // button width and height
                      child: ClipOval(
                        child: Material(
                          color:  Color(int.parse(Global.primaryColor)), // button color
                          child: InkWell(
                            splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                            onTap: () {
                              _showPicker(context);
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add_a_photo,color: Colors.white,), // icon
                                Text(AppLocalizations.of(context).translate('upload_photo') , style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8
                                )), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                )),
            Container(margin: EdgeInsets.only(top:10.0),),
            Expanded(child: buildGridView()),
            Container(margin: EdgeInsets.only(top:10.0),),
            Container(
                child: Center(
                  child:  Global.visible_progress ?
                  CircularProgressIndicator() :
                  RaisedButton(
                        onPressed: () async {
                          setState(() {
                            Global.visible_progress=true;
                          });
                          String newDate=_startDate.toString().substring(0,10)+"T00:00";
                          String newEndDate=_endDate.toString().substring(0,10)+"T00:00";
                          if(images.length>0) {
                            image1=images[0].name.toString();
                            image1 = image1.replaceAll(".","-");
                            image1+=".png";
                            String uri =  await FlutterAbsolutePath.getAbsolutePath(images[0].identifier);
                            File file = File (uri);
                            Uint8List tempbyte = file.readAsBytesSync();
                            bytes=tempbyte;
                            Offer offer = new Offer(Global.loginUser.id,newDate,newEndDate,image1,myController.text,bytes);
                            Offer.addOffer("Offer/AddOffer", offer).then((value) {
                              setState(() {
                                Global.visible_progress=false;
                              });

                            });
                          }
                          else if(myController.text.length != null)
                            {
                              
                              Offer offer = new Offer(Global.loginUser.id,newDate,newEndDate,image1,myController.text,bytes);
                              Offer.addOffer("Offer/AddOffer", offer).then((value) {
                                setState(() {
                                  Global.visible_progress=false;
                                });
                                Utils.toastMessage("Offer Added");
                                Navigator.of(context).pop();
                              });
                            }


                      },
                      elevation: 2.0,
                      color: Color(int.parse(Global.primaryColor)),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Container(
                        padding:  EdgeInsets.all(10.0),
                        child: Text(AppLocalizations.of(context).translate('add_offer') ,
                            style: TextStyle(fontSize: 12)
                        ),
                      )
                  ),
                )),




          ],
        ),
      ),

    );
  }


  Future displayDateRangePicker(BuildContext context)async {

    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2022)
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate=picked[0];
        _endDate=picked[1];
      });
    }

  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext cont) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        loadAssets();
                        Navigator.of(context).pop();
                      }),

                  //get image from camera
                  /*
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        getImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ), */
                ],
              ),
            ),
          );
        }
    );
  }
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        //enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Talabatk",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#FFFFFF",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
  }
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 1,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(images[index].name);

        return FittedBox(
          fit:BoxFit.fill,
          child: AssetThumb(
            asset: asset,
            width: 700,
            height: 700,
            quality: 100,
          ),
        );
      }),
    );
  }
}
