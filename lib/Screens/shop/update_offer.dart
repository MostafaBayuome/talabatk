import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/offer.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class UpdateOffer extends StatefulWidget {

  Offer offer;
  UpdateOffer({Key key, @required this.offer}) : super(key: key);

  @override
  _UpdateOfferState createState() => _UpdateOfferState(offer);
}

class _UpdateOfferState extends State<UpdateOffer> {


  String arrbytes;
  Uint8List arrBytes;

  DateTime _startDate= DateTime.now();
  DateTime _endDate  =  DateTime.now().add(Duration(days: 7));
  List<Asset> images = List<Asset>();
  Uint8List bytes;

  final myController = TextEditingController();
  Offer offer;
  _UpdateOfferState(this.offer);


  @override
  void initState() {
    Request.drawImageFromServer(offer.imageUrl).then((value) {
      setState(() {
        if(value!=null)
          arrbytes= value;
        arrBytes =base64.decode(arrbytes);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _title= AppLocalizations.of(context).translate('update_offers');
    return Scaffold(
      appBar:  Utils.appBarusers(context,_title),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
            children: [

              Expanded(
                child: ListView(
                  children: <Widget> [
                    Row(
                      children: [
                        Text('Old offer: ',style: Utils.fontBold,),
                        SizedBox(width: 10,),
                        Text(offer.description),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('New offer:',style: Utils.fontBold,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            controller: myController,
                            decoration:  InputDecoration(helperText: AppLocalizations.of(context).translate('offer_description')),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Old time  ',style: Utils.fontBold,),
                        SizedBox(width: 10,),
                        Text(offer.date.substring(0,10),style:TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                        )),
                        SizedBox(width: 10,),
                        Text(AppLocalizations.of(context).translate('to')),
                        SizedBox(width: 10,),
                        Text(offer.dateExpired.substring(0,10),style:TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                        )),
                      ],
                     ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('New time',style: Utils.fontBold,),
                        SizedBox(width: 10,),
                        Text(_startDate.toString().substring(0,10),style:TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                        )),
                        SizedBox(width: 10,),
                        Text(AppLocalizations.of(context).translate('to')),
                        SizedBox(width: 10,),
                        Text(_endDate.toString().substring(0,10),style:TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                        )),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Upload new Image:",style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 10,),
                        Container(
                            child: Center(
                                child: SizedBox.fromSize(
                                  size: Size(50, 50), // button width and height
                                  child: ClipOval(
                                    child: Material(
                                      color:   Colors.white, // button color
                                      child: InkWell(
                                        splashColor: Colors.white, // splash color
                                        onTap: () {
                                          _showPicker(context);
                                        }, // button pressed
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.add_a_photo,color: Color(int.parse(Global.primaryColor)),), // icon
                                         // text
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            )),
                      ],
                    ),
                    SizedBox(height: 10,),
                    images.length == 0 ? Container() :
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(

                        children: [
                          Text("New Image",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          FittedBox(
                            fit:BoxFit.cover,
                            child: AssetThumb(
                              asset: images[0],
                              width: 250,
                              height: 250,
                              quality: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        arrBytes == null ? Container() :
                        Text("Old Image:",style: TextStyle(fontWeight: FontWeight.bold)),
                        arrBytes == null ? Container() :
                        Container(
                          height: 250,
                          width: 250,
                          child:Image.memory(arrBytes),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: RaisedButton(onPressed: () async {
                  String image1="";
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
                  }

                    Offer offer=new Offer(Global.loginUser.id,newDate,newEndDate,image1,myController.text,bytes );
                    Offer.updateOffer(offer).then((value) {
                      Utils.toastMessage("Offer Updated Successfully");
                         setState(() {
                      Global.visible_progress=false;
                       });

                  });
                  },
                  color:Color(int.parse(Global.primaryColor)),
                  child: Text("Update Offer",style: TextStyle(color: Colors.white),),
                ),
              ),

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




}
