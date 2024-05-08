import 'package:contact_dairy/contact_provider.dart';
import 'package:contact_dairy/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int T=2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        title: Text("Contacts"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap:() {
                  if (T == 0) {
                    T = 1;
                  } else if (T == 1) {
                    T = 2;
                  } else {
                    T = 0;
                  }
                  Provider.of<Themeprovider>(context,listen: false).changetheme(T);
                  Provider.of<Themeprovider>(context,listen: false).gettheme();

                },
                child: T==0?Icon(Icons.sunny):Icon(Icons.nights_stay_rounded)),
          ),

        ],
      ),
        body: Consumer<contactprovider>(
          builder: (BuildContext context, contactprovider value, Widget? child) => ListView.builder(
            itemCount: value.contactlist.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "detail_page",arguments: index);
                    },
                    child: Container(
                      height: 80,
                      child: Row(
                        children: [
                          SizedBox(width: 15,),
                          Icon(Icons.account_circle,size: 60,),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Text("${value.contactlist[index].fname} ${value.contactlist[index].lname}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              Text("+91 ${value.contactlist[index].phonenumber}"),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("tel:${value.contactlist[index].phonenumber}"));
                            },
                              child: Icon(Icons.phone,color: Colors.green,size: 32,)),
                          SizedBox(width: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              );

          },),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.pushNamed(context, "add_contact");
        },child: Icon(Icons.add_call),),
    );
  }
}
