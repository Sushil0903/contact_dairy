import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier{


  int thememode=0;

  ThemeMode gettheme(){
    if(thememode==0)
      {
        return ThemeMode.light;
      }
    else if(thememode==1)
      {
        return ThemeMode.dark;
      }
    else if(thememode==3){
      return ThemeMode.system;
    }
    else{
      return ThemeMode.system;
    }
    notifyListeners();
}

void changetheme(int type)
{
  thememode=type;
  notifyListeners();
}
}