import 'package:flutter/material.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Screens/user_request_page.dart';

class RequestsLayout extends StatelessWidget {
  String title="الطلبات تحت التنفيذ";
   BuildContext currContext=null;
  @override
  Widget build(BuildContext context) {
    currContext=context;
    // TODO: implement build
    return new MaterialApp(
      color: Colors.yellow,

      home: DefaultTabController(
        length: 4,
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: Color(int.parse(Global.primaryColor)),
            centerTitle: true,
            title:Text(title,
              style: TextStyle(
                  fontFamily: Global.fontFamily,
                  fontWeight: FontWeight.w900,
                  fontSize: 25
              ),),
            automaticallyImplyLeading: false,
          ),
          body: TabBarView(
            children: [
              new Container(
                color: Colors.yellow,
                 child: WaitedRequests(Icons.timer,'Waited'),
              ),
              new Container(
                color: Colors.orange,
                child: WaitedRequests(Icons.network_wifi,'Processing'),
              ),
              new Container(

                color: Colors.lightGreen,
                child: WaitedRequests(Icons.done,'Delevired'),
                  ),
              new Container(
                color: Colors.red,
                child: WaitedRequests(Icons.add_call,'Rejected'),
              ),
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.timer),
              ),
              Tab(
                icon: new Icon(Icons.network_wifi),
              ),
              Tab(
                icon: new Icon(Icons.done),
              ),
              Tab(icon: new Icon(Icons.add_call),)
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.red,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }

  WaitedRequests(IconData icon,String title) {

  return  ListView(

        children: <Widget>[

          Container(

              child:  InkWell
                (
                onTap:(){
                  Navigator.of(currContext).push(MaterialPageRoute(
                      builder: (context) =>UserRequest()
                  ));
                },
                child:Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        //mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          ListTile(
                            title: Text('Order number : 0111123455'),
                            subtitle: Text('User Description  need 1 litre milk 10 eggs etc ......... plus new things will be added  plus new things will be added  '),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center ,
                            children: <Widget>[
                              FlatButton(
                                child: IconButton(
                                  tooltip:'waited',
                                  icon: Icon(icon),
                                  color: Colors.red,

                                  onPressed: () {
                                    // here we send location of user
                                  },
                                ),
                              ),
                              Text(title)
                            ],
                          )

                        ],
                      ),
                    ) ) ,
              )
          ) ,
          Container(
              
              child:  Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text('Order No : 01149056691'),
                          subtitle: Text('User Description  i need to buy milk 100 orange asadas  ......... plus new things will be added  plus new things will be added  '),
                        ),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: IconButton(
                                tooltip:'waited',
                                icon: Icon(icon),
                                color: Colors.red,

                                onPressed: () {
                                  // here we send location of user
                                },
                              ),
                            ),
                            Text(title)
                          ],
                        )

                      ],
                    ),
                  ) )
          )
        ]
    );
  }
}