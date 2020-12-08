import 'dart:io';
import 'dart:typed_data';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:url_launcher/url_launcher.dart';


class UserRequest extends StatefulWidget {
  User shop;
  UserRequest({Key key, @required this.shop}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>_State(shop);
}

class _State extends State<UserRequest>{
  _State(this.shop);
  final picker = ImagePicker();
  List<Asset> images = List<Asset>();
  List <File> fileImageArray = [];
  List  <Uint8List> arrbytes =[];
  User shop;
  final detailsTextController = TextEditingController();
  String image1="",image2="";

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar:Utils.appBarusers(context,AppLocalizations.of(context).translate('request') ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [

                  Center(
                    child: Text(AppLocalizations.of(context).translate('request_info') ,
                      style: TextStyle(
                        fontFamily: Global.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          borderOnForeground: true,
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration.collapsed(hintText: ""),
                              controller: detailsTextController,
                            ),
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: buildGridView(),
                   ),
                  Expanded(
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,//Center Row contents horizontally,
                      children: [
                        Container(
                            child: Center(
                              child: SizedBox.fromSize(
                                size: Size(70, 70), // button width and height
                                child: ClipOval(
                                  child: Material(
                                    color:  Color(int.parse(Global.primaryColor)), // button color
                                    child: InkWell(
                                      splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                                      onTap: () {
                                        launch('tel://${shop.mobileNumber}');
                                      }, // button pressed
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.call,color: Colors.white,), // icon
                                          Text(AppLocalizations.of(context).translate('call')  , style: TextStyle(
                                          color: Colors.white,
                                     ),), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            )),
                        SizedBox(width: 20),
                        Container(
                            child: Center(
                              child: SizedBox.fromSize(
                                size: Size(70, 70), // button width and height
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
                                            fontSize: 10
                                          )), // text
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            )),
                      ],
                    ),
                  ),
                  Container(
                      child: Center(
                        child:  Global.visible_progress ?
                                   CircularProgressIndicator() :
                                   RaisedButton(
                                          onPressed: () async {
                                            setState(() {
                                              Global.visible_progress=true;
                                            });
                                      if(images.length>0) {
                                            image1=images[0].name.toString();
                                            image1 = image1.replaceAll(".","-");
                                            image1+=".png";
                                          if(images.length>1) {
                                              image2=images[1].name.toString();
                                              image2 = image2.replaceAll(".","-");
                                              image2+=".png";
                                            }
                                          for(int i=0;i<images.length;i++)
                                            {
                                              File file = File ( await FlutterAbsolutePath.getAbsolutePath(images[i].identifier));
                                              Uint8List tempbyte = file.readAsBytesSync();
                                              String temp= tempbyte.toString();
                                              print(temp);
                                              arrbytes.add(tempbyte);
                                            }
                                        }
                                      if(detailsTextController.text.toString().length!=0 || images.length != 0 ){
                                        try{
                                          if(arrbytes.length == 2 ){
                                            Request.addRequest("Request/AddRequest",Global.loginUser.id,shop.id,Global.userLocationIdDeliever,"","",detailsTextController.text.toString(),image1,image2,arrbytes[0],arrbytes[1]).then((value) {
                                              setState(() {
                                                Global.visible_progress=false;
                                              });
                                              Utils.toastMessage(AppLocalizations.of(context).translate('request_have_been_sent') );
                                            });
                                          }// 1 image doesn't work
                                          else
                                          {
                                            Request.addRequest1("Request/AddRequest",Global.loginUser.id,shop.id,Global.userLocationIdDeliever,"","",detailsTextController.text.toString(),"","",null,null).then((value) {
                                              setState(() {
                                                Global.visible_progress=false;
                                              });
                                              Utils.toastMessage(AppLocalizations.of(context).translate('request_have_been_sent') );
                                            });
                                          }
                                        }catch(Exception)
                                            {
                                              setState(() {
                                                Global.visible_progress=false;
                                              });
                                            }
                                      }else{
                                        Utils.toastMessage(AppLocalizations.of(context).translate('fill_the_request') );
                                        setState(() {
                                          Global.visible_progress=false;
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
                                      child: Text(AppLocalizations.of(context).translate('request_order') ,
                                          style: TextStyle(fontSize: 15)
                                      ),
                                    )
                                ),
                              )),

                ],
              ),
            ),
          );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
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
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
           maxImages: 2,
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


}
