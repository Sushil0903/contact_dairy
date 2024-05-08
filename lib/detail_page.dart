import 'package:contact_dairy/add_contact.dart';
import 'package:contact_dairy/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailpage extends StatefulWidget {

  Detailpage({super.key,});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {

  @override
  Widget build(BuildContext context) {
    var index=ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 5,
        shadowColor: Colors.white,
        actions: [
          InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                   return addcontact(index: index,);
                 },));
              },
              child: Icon(Icons.edit)),
          SizedBox(width: 10,),
        InkWell(
          onTap: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Delete contact?"),
                content: Text("This contact will be removed from all your sybnced devices. Contacts synced with Google Contacts will be moved to the Bin."),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                          child: Text("Cancle",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: () {
                          Provider.of<contactprovider>(context,listen: false).deletecontact(index);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                          child: Text("Delete",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18))),
                      SizedBox(width: 15,),
                    ],
                  )
                ],
              );
            },);

          },
            child: Icon(Icons.delete)),
          SizedBox(width: 10,),
        ],
      ),
      body: Consumer<contactprovider>(
        builder: (BuildContext context, contactprovider value, Widget? child) =>
            Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Spacer(),
                Icon(
                  Icons.account_circle,
                  size: 150,
                ),
                Spacer(),
              ],
            ),
            Text(
              "${value.contactlist[index].fname} ${value.contactlist[index ?? 0].lname}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text("+91 ${value.contactlist[index ?? 0].phonenumber}",style: TextStyle(fontSize: 18),),
            SizedBox(height: 30,),
            Divider(),
            SizedBox(height: 20,),
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("tel:${value.contactlist[index ?? 0].phonenumber}"));
                  },
                  child: Container(
                    height: 45,
                      width: 45,
                      child: Icon(Icons.phone,color: Colors.white,),
                    decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("sms:${value.contactlist[index ?? 0].phonenumber}"));
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    child: Icon(Icons.message,color: Colors.white,),
                    decoration: BoxDecoration(color: Colors.orangeAccent,borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("mailto:${value.contactlist[index ?? 0].email}"));
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    child: Icon(Icons.mail,color: Colors.white,),
                    decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Share.share("${value.contactlist[index ?? 0].fname} ${value.contactlist[index ?? 0].lname}\n ${value.contactlist[index ?? 0].phonenumber}");
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    child: Icon(Icons.share,color: Colors.white,),
                    decoration: BoxDecoration(color: Colors.deepOrange,borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20,),
            Divider(),
          ],
        ),
      ),
    );
  }
}
