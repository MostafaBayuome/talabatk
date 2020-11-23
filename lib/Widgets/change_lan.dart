import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    String _title= AppLocalizations.of(context).translate('settings');
    return Scaffold(
        appBar: Utils.appBarusers(context,_title),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(margin: EdgeInsets.only(top:20.0),),
                Center(
                  child: Text( AppLocalizations.of(context).translate('change_language')  ,style: TextStyle(
                    fontFamily: Global.fontFamily,
                    fontWeight: FontWeight.w400,),),
                ),
                Container(margin: EdgeInsets.only(top:5.0),),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Color(int.parse(Global.primaryColor)),
                        onPressed: () {
                          appLanguage.changeLanguage(Locale("en"));
                        },
                        child: Text('English',  style: TextStyle(
                            color: Colors.white,
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        )),
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Color(int.parse(Global.primaryColor)),
                        onPressed: () {
                          appLanguage.changeLanguage(Locale("ar"));
                        },
                        child: Text('عربي' , style: TextStyle(
                            color: Colors.white,
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        )),
                      ) ,
                    ],
                  ) ,
                )
              ],
            )));
  }


}
