import 'package:flutter/cupertino.dart';

import 'contact_class.dart';

class contactprovider extends ChangeNotifier{
  List<Contactmodel> contactlist=[];



  void addcontact(String fname,String lname,String phonenumber,String email){

    contactlist.add(Contactmodel(fname: fname,lname: lname,phonenumber: phonenumber,email: email));
    notifyListeners();

  }

  void deletecontact(int index)
  {
      contactlist.removeAt(index);
      notifyListeners();
  }

  void editcontact(int index,String fname,String lname,String phonenumber,String email){
    contactlist[index]=Contactmodel(fname: fname,lname: lname,phonenumber: phonenumber,email: email);
    notifyListeners();

  }
}