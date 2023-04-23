import 'dart:io';

import 'package:flutter/material.dart';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as _http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String? _dir;

  String _api = "https://daveat-study.github.io/";

  void _incrementCounter() async {
    print("_incrementCounter");
    
    try {
      // Get Application PATH
      _dir = (await getApplicationDocumentsDirectory()).path;
      print("_dir $_dir");

      // Start Download File
      await _downloadFile().then((value) async {
        
        print("value.readAsBytesSync() ${value.path} ");
        // Start Archive Downloaded File

        await _readFile(value);
      });
    } catch (e) {
      print("Error _incrementCounter $e");
    }
  }

  Future<File> _downloadFile() async {
    print("_downloadFile");
    _http.Response req;
    File file = File('$_dir/logo.zip');
    req = await _http.Client().get(Uri.parse("${_api}logo.zip"));
    try {
      print("start _downloadFile");

      print("req ${req.bodyBytes}");

      print("file ${file.path}");

    } catch (e) {

      print("Failed _downloadFile $e");
    }
    return await file.writeAsBytes(req.bodyBytes);
  }

  Future<void> readFileFromLocalDB() async {
    
    _dir = (await getApplicationDocumentsDirectory()).path;
    print("_dir $_dir");
    await _readFile(File("$_dir/logo.zip"), name: true);
  }

  Future<void> _readFile(File value, {bool? name = false}) async {

    Archive archive = ZipDecoder().decodeBytes(value.readAsBytesSync());

    // Loop Write File Into Local DB
    for (var file in archive) {

      // ${file.name}
      var filename = '$_dir/${name == true ? file.name : 'logo'}';

      if (file.isFile) {

        var outFile = File(filename);
        print("outFile $outFile");

        // Create Folder
        outFile = await outFile.create(recursive: true);

        print("outFile.path ${outFile.path}");

        print("file.content ${file.content}");
        // Write File's Content As Byte
        await outFile.writeAsBytes(file.content);

      }
      
    }
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
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            ElevatedButton(
              onPressed: () {
                _incrementCounter();
              }, 
              child: Text("Download File")
            ),

            ElevatedButton(
              onPressed: () async {
                await readFileFromLocalDB();
              }, 
              child: Text("Read File")
            )
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
