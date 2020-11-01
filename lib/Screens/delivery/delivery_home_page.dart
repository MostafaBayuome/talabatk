import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';

import '../chat_page.dart';


class DeliveryHomePage extends StatefulWidget {
  @override
  _DeliveryHomePageState createState() => _DeliveryHomePageState();
}

class _DeliveryHomePageState extends State<DeliveryHomePage> {

  String _title="Delivery Home Page";
  List<Request> allCustomerRequest=[];
  List<Request> processingList=[];
  List<Request> deliveredList=[];

  @override
  Widget build(BuildContext context) {
    getAllRequests();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: Utils.appBarusers(context, _title),
        body:  TabBarView(
          children: [
            new Container(
              child: allRequests(Icons.motorcycle,'Processing',processingList),
            ),
            new Container(
              child: allRequests(Icons.done,'Delevired',deliveredList),
            ),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: new Icon(Icons.motorcycle),
            ),
            Tab(
              icon: new Icon(Icons.done),
            ),
          ],
          labelColor: Color(int.parse(Global.secondaryColor)),
          unselectedLabelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Color(int.parse(Global.primaryColor)),
        )
      ),
    );
  }

  allRequests(IconData icon,String title,List<Request> listItem) {

    return  ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: listItem.length,
      itemBuilder: (BuildContext context,int index){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child:  Container(
            width :MediaQuery.of(context).size.width,
            padding :EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 55.0,
                  height: 55.0,

                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Utils.title(55,55),
                  ),
                ),
                SizedBox(width: 8.0),
                Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Merchant ID: "+ listItem[index].merchant_id.toString(),textAlign: TextAlign.center, style: TextStyle(
                          fontFamily: Global.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        )),
                      ),
                      Container(
                        child: Text( "Request ID: "+ listItem[index].id.toString() ,textAlign: TextAlign.center, style: TextStyle(
                          fontFamily: Global.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,

                        )),
                      ),
                      Container(
                        child: Text(listItem[index].request_date.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(height: 3,),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(listItem[index].request_time.toString()  +"الوقت ", style: TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,

                          )),
                        ),
                      ),
                      SizedBox(height : 5),]
                ),
                if(listItem[index].state == 0 || listItem[index].state == 1)
                  Container(
                      width: 70.0,
                      height: 70.0,
                      alignment: Alignment.center,

                      padding: EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),

                      child: InkWell(

                        onTap: () {
                          //Send User to chat page
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>ChatPage( request: listItem[index] )
                          ));
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.chat,color: Colors.blue), // icon
                          ],
                        ),
                      )),
              ],
            ),),
        );
      },
    );
  }
  Future getAllRequests() {
    return  Future.delayed(const Duration(seconds: 5), () {
      Request.getRequestsAttachedToDeliveryMan().then((value)
      {
        setState(() {
          allCustomerRequest=value;
          arrangeRequestsWithState();
        });
      }
      );
    });
  }

  // 1 on delivery, 2 delivered
  void arrangeRequestsWithState() {

    processingList.clear();
    deliveredList.clear();

    for(int i=0;i<allCustomerRequest.length;i++)
    {
        if(allCustomerRequest[i].state==1)
        processingList.add(allCustomerRequest[i]);
       else if(allCustomerRequest[i].state==2)
        deliveredList.add(allCustomerRequest[i]);
    }
  }

}
