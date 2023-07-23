import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'readjson.dart';

// var AllInstructor ={Hand};




  List<String> addedInstructor = [];
  Map<String,Instructors> ?instructors;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  instructors = await JsonLoader.loadJsonData();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  List<String> inputList = [];

 
  void addToInputList(String input) {
    setState(() {
      inputList.add(input);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Instructor extends StatefulWidget{
  const Instructor({super.key});

  @override
  State<Instructor> createState() => _InstructorState();
}

class _InstructorState extends State<Instructor> {
  
  String SelectedValue = instructors!.keys.toList()[0];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Sign In"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [DropdownButton(
            value: SelectedValue,
            onChanged: (String? value){
            setState((){
              SelectedValue = value!;
            });
          },
            items: instructors!.keys.toList().map<DropdownMenuItem<String>>((String value){return DropdownMenuItem<String>(value: value,child: Text(value));}).toList(), 
          ), ElevatedButton(onPressed: (){if (!addedInstructor.contains(SelectedValue)) {addedInstructor.add(SelectedValue);print(addedInstructor);}}, child: Text("ADD"))],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class ScheduleLoads extends StatefulWidget{
  const ScheduleLoads({super.key});

  @override
  State<ScheduleLoads> createState() => _ScheduleLoadsState();

}

class _ScheduleLoadsState extends State<ScheduleLoads> {


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Schedule Loads"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(),
      ),
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
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Instructor();
        break;
      case 1:
        page = ScheduleLoads();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,  // ← Here.
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.login),
                    label: Text('Sign In'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.schedule),
                    label: Text('Schedule'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

