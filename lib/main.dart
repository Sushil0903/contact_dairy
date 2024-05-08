import 'package:contact_dairy/add_contact.dart';
import 'package:contact_dairy/detail_page.dart';
import 'package:contact_dairy/home_page.dart';
import 'package:contact_dairy/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_provider.dart';

void main()
{
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => contactprovider(),),
        ChangeNotifierProvider(create: (context) => Themeprovider(),),
      ],
      builder: (context, child) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: Provider.of<Themeprovider>(context).gettheme(),
          initialRoute: "/",
          routes: {
            "/":(context) => Homepage(),
            "add_contact":(context) => addcontact(),
            "detail_page":(context) => Detailpage(),
          },
        );
      },
    );
  }
}
