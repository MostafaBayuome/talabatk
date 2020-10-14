import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/request.dart';
import 'package:talabatk_flutter/Entities/user.dart';
import 'package:talabatk_flutter/Widgets/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chat_page.dart';


class UserRequest extends StatefulWidget
{
  User shop;
  UserRequest({Key key, @required this.shop}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_State(shop);
}

class _State extends State<UserRequest>{
  _State(this.shop);
  File image;
  final picker = ImagePicker();
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  User shop;
  final detailsTextController = TextEditingController();
  String image1="",image2="";

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
              appBar:AppBar(
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
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(

                children: [
                  Center(
                    child: Text("تفاصيل الطلب",
                      style: TextStyle(
                        color: Color(int.parse(Global.primaryColor)),
                        fontFamily: Global.fontFamily,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),),
                  ),
                  Container(

                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        borderOnForeground: true,
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            maxLines: 10,
                            decoration: InputDecoration.collapsed(hintText: ""),
                            controller: detailsTextController,
                          ),
                        ),
                      ) ),
                  SizedBox(height: 10),
                  Expanded(
                    child: buildGridView(),
                   ),
                  Container(
                    width: 80,
                    height: 80,
                    child:  Center(
                      child: image == null
                          ? Text('')
                          : Image.file(image),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                    children: [
                      Container(
                          child: Center(
                            child: SizedBox.fromSize(
                              size: Size(80, 80), // button width and height
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
                                        Text("اتصال"  , style: TextStyle(
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
                              size: Size(80, 80), // button width and height
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
                                        Text("   رفع صوره", style: TextStyle(
                                          color: Colors.white,
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
                  SizedBox(height: 50),
                  Container(
                      child: Center(
                        child:  Global.visible_progress ?
                                   CircularProgressIndicator() :
                                   RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              Global.visible_progress=true;
                                            });
                                      if(images.length>0)
                                        {
                                            image1=images[0].name.toString();
                                          if(images.length>1)
                                            image2=images[1].name.toString();
                                        }
                                      Request.addRequest("Request/AddRequest",Global.loginUser.id,shop.id,Global.userLocationIdDeliever,"","",detailsTextController.text.toString(),image1,image2).then((value) {
                                        setState(() {
                                          Global.visible_progress=false;
                                        });
                                      Utils.toastMessage('لقد تم ارسال طلبك');
                                      });
                                    },
                                    elevation: 2.0,
                                    color: Color(int.parse(Global.primaryColor)),
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Text('طلب اوردر',
                                          style: TextStyle(fontSize: 20)
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
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
       // enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }


    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
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
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        getImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
          );
        }
    );
  }
  //Select an Image via gallery or camera
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


}
