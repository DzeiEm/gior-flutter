import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gior/firebase/auth.dart';
import 'package:gior/providers/events_pr.dart';
import 'package:gior/providers/gallery_images_pr.dart';
import 'package:gior/providers/procedures_pr.dart';
import 'package:gior/screens/add_image_screen.dart';
import 'package:gior/screens/image_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:gior/screens/add_procedure_admin.dart';
import 'package:gior/screens/calendar_screen.dart';
import 'package:gior/screens/chat_screen.dart';
import 'package:gior/screens/contacts_screen.dart';
import 'package:gior/screens/location_screen.dart';
import 'package:gior/screens/profile_screen.dart';
import 'package:gior/screens/deal_screen.dart';
import 'package:gior/screens/gallery_screen.dart';
import 'package:gior/screens/main%20_screens/home_screen.dart';
import 'package:gior/screens/login_screen.dart';
import 'package:gior/screens/procedure_details_screen.dart';
import 'package:gior/screens/main%20_screens/procedure_list_screen.dart';
import 'package:gior/screens/main%20_screens/settings.dart';
import 'package:gior/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Procedures()),
        ChangeNotifierProvider(
          create: (_) => Events(),
        ),
        ChangeNotifierProvider(create: (_) => ImagesProvider())
      ],
      child: MaterialApp(
        title: 'Gior',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<User>(
          future: auth.getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return SplashScreen();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else {
                  if (snapshot.data == null) {
                    return LoginScreen();
                  } else {
                    return PageView(children: [
                      HomePage(),
                      ProcedureListScreen(),
                      SettingsScreen()
                    ]);
                  }
                }
            }
          },
        ),
        routes: {
          ChatScreen.routeName: (ctx) => ChatScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          ContactScreen.routeName: (ctx) => ContactScreen(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),
          ProcedureDetailsScreen.routeName: (ctx) => ProcedureDetailsScreen(),
          AddProcedureScreen.routeName: (ctx) => AddProcedureScreen(),
          GalleryScreen.routeName: (ctx) => GalleryScreen(),
          LocationScreen.routeName: (ctx) => LocationScreen(),
          DealScreen.routeName: (ctx) => DealScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomePage.routeName: (ctx) => HomePage(),
          AddImageScreen.routeName: (ctx) => AddImageScreen(),
          ImageDetailsScreen.routeName: (ctx) => ImageDetailsScreen(),
        },
      ),
    );
  }
}
