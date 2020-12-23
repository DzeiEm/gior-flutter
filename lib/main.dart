import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gior/providers/auth.dart';
import 'package:gior/providers/events.dart';
import 'package:gior/providers/procedures.dart';
import 'package:provider/provider.dart';
import 'package:gior/screens/admin/add_procedure_admin.dart';
import 'package:gior/screens/calendar_screen.dart';
import 'package:gior/screens/contact_fld.dart/chat_screen.dart';
import 'package:gior/screens/contact_fld.dart/contacts_screen.dart';
import 'package:gior/screens/contact_fld.dart/location_screen.dart';
import 'package:gior/screens/contact_fld.dart/profile.dart';
import 'package:gior/screens/deal_screen.dart';
import 'package:gior/screens/gallery_screen.dart';
import 'package:gior/screens/home_screen.dart';
import 'package:gior/screens/login_screen.dart';
import 'package:gior/screens/procedure_details_screen.dart';
import 'package:gior/screens/procedure_list_screen.dart';
import 'package:gior/screens/settings.dart';
import 'package:gior/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Procedures()),
        ChangeNotifierProvider(
          create: (_) => Events(),
        ),
      ],
      child: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'Gior',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: FutureBuilder(
                future: Provider.of<Auth>(context).getUser(),
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
                ProcedureDetailsScreen.routeName: (ctx) =>
                    ProcedureDetailsScreen(),
                AddProcedureScreen.routeName: (ctx) => AddProcedureScreen(),
                GalleryScreen.routeName: (ctx) => GalleryScreen(),
                LocationScreen.routeName: (ctx) => LocationScreen(),
                DealScreen.routeName: (ctx) => DealScreen(),
                ProfileScreen.routeName: (ctx) => ProfileScreen(),
                LoginScreen.routeName: (ctx) => LoginScreen(),
                HomePage.routeName: (ctx) => HomePage(),
              },
            );
          }),
    );
  }
}
