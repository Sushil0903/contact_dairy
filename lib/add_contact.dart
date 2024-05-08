import 'package:contact_dairy/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class addcontact extends StatefulWidget {
  int? index;
   addcontact({super.key,this.index});

  @override
  State<addcontact> createState() => _addcontactState();
}

class _addcontactState extends State<addcontact> {
  GlobalKey<FormState> fkey=GlobalKey();
  TextEditingController fnamecontrol=TextEditingController();
  TextEditingController lnamecontrol=TextEditingController();
  TextEditingController phonecontrol=TextEditingController();
  TextEditingController emailcontrol=TextEditingController();

  get xfile => null;

    @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(widget.index !=null)
      {
        var nameVal = Provider.of<contactprovider>(context,listen: false).contactlist[widget.index!];
        fnamecontrol.text = nameVal.fname ?? "";
        lnamecontrol.text = nameVal.lname ?? "";
        phonecontrol.text = nameVal.phonenumber ?? "";
        emailcontrol.text = nameVal.email ?? "";
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        title: Text(widget.index != null ? "Edit Contact" : "Add Contact"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                if(widget.index!=null)
                  {
                    Provider.of<contactprovider>(context,listen: false).editcontact(widget.index!, fnamecontrol.text, lnamecontrol.text,phonecontrol.text,emailcontrol.text);
                    Navigator.pop(context);
                  }
                else{
                  bool valid=fkey.currentState?.validate()??false;
                  if(valid)
                  {
                    Provider.of<contactprovider>(context,listen: false).addcontact(fnamecontrol.text, lnamecontrol.text, phonecontrol.text, emailcontrol.text);
                    Navigator.pop(context);
                  }
                }
              },
                child: Icon(Icons.check)),
          )
        ],
      ),
      body: Form(
        key: fkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              CircleAvatar(
                radius: 60,
              ),
              SizedBox(height: 10,),
              InkWell(
                  onTap: () async{
                  XFile? img= await ImagePicker().pickImage(source: ImageSource.camera);

                  },
                  child: Text("Add image")),
              SizedBox(height: 40,),
              Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.account_circle,size: 30,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextFormField(
                      controller: fnamecontrol,
                      decoration: InputDecoration(labelText: "First name",border: OutlineInputBorder()),
                      validator: (value) {
                        if(value!.isEmpty)
                          {
                            return "Plase enter name";
                          }
                      },
                      textInputAction: TextInputAction.next,
                    ),

                  ),
                  SizedBox(width: 15,),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 55,),
                  Expanded(
                    child: TextFormField(
                      controller: lnamecontrol,
                      decoration: InputDecoration(labelText: "Last name",border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,

                    ),
                  ),
                  SizedBox(width: 15,),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.phone,size: 30,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextFormField(
                      controller: phonecontrol,
                      decoration: InputDecoration(labelText: "Phone number",border: OutlineInputBorder()),
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return "Plase enter phone number";
                        }
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 15,),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.email_rounded,size: 30,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextFormField(
                      controller: emailcontrol,
                      decoration: InputDecoration(labelText: "Email",border: OutlineInputBorder()),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(width: 15,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
