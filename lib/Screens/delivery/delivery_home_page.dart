import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';


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
        return Container(
          child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Material(
                  color: Colors.white,
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Color(int.parse(Global.primaryColor)),
                  child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].user_id.toString(), style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].id.toString(), style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].request_date.toString(), style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].request_time.toString()  +"الوقت ", style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].details, style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        SizedBox(height: 10,),
                        FittedBox(
                          child: FloatingActionButton(
                              backgroundColor:Color(int.parse(Global.primaryColor)) ,
                              child:IconButton(
                                icon: Icon(Icons.location_on),
                                onPressed: () {

                                },
                              )
                          ),
                        ),
                      ]
                  ),
                ),)),
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
