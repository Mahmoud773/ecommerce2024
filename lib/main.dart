import 'package:amazon/res/components/custom_book_card.dart';
import 'package:amazon/res/components/waiting_screen.dart';
import 'package:amazon/services/Fcm_notifications_api.dart';
import 'package:amazon/shared_preferences/my_shared_Preferences.dart';
import 'package:amazon/views/appointments/booking.dart';
import 'package:amazon/views/appointments/date_time_picker.dart';
import 'package:amazon/views/home.dart';
import 'package:amazon/views/home_view.dart';
import 'package:amazon/views/loading_screen.dart';
import 'package:amazon/views/login_view.dart';
import 'package:amazon/views/new_home_screen.dart';
import 'package:amazon/views/new_login_screen.dart';
import 'package:amazon/views/patient/login_screen.dart';
import 'package:amazon/views/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'models/booking_date_time_converter.dart';


late SharedPreferences? _sharedPreferences;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   // final storage= await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifications();
  _sharedPreferences=await SharedPreferences.getInstance();
  // HydratedBlocOverrides.runZoned(() =>  runApp(const MyApp())    , storage:storage);
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: kIsWeb
  //       ? HydratedStorage.webStorageDirectory
  //       : await getTemporaryDirectory(),
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:PatientLoginScreen(sharedPreferences: _sharedPreferences,)
      // PatientLoginScreen(sharedPreferences: _sharedPreferences,)

      // StreamBuilder(stream: FirebaseAuth.instance.authStateChanges() ,
      //   builder: (ctx , snapshot){
      //   if(snapshot.connectionState == ConnectionState.waiting){
      //     return LoadingScreen();
      //   }
      //   if(snapshot.hasData ){
      //     return Home(sharedPreferences: _sharedPreferences,);
      //   }else
      //     return PatientLoginScreen(sharedPreferences: _sharedPreferences,);
      // },)


      // PatientLoginScreen(),
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // // onGenerateRoute: onGenerate,
      // initialRoute: AppRoutes.loginPageRoute,
      // home: GridPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
