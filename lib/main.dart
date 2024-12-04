import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';
import 'package:stavki_gp_app1/core/db_heandler.dart';


void main() async {
  await dotenv.load(fileName: ".env");

  final settings = ConnectionSettings(
    host: dotenv.env['DB_HOST']!,
    port: int.parse(dotenv.env['DB_PORT']!),
    user: dotenv.env['DB_USER']!,
    password: dotenv.env['DB_PASSWORD']!,
    db: dotenv.env['DB_NAME']!,
  );
  final dbHandler = DBHandler(settings);

  // Create
  await dbHandler.create('items', {'name': 'Item 1', 'value': '100'});

  // Read
  var results = await dbHandler.read('items');
  for (var row in results) {
    print('Name: ${row['name']}, Value: ${row['value']}');
  }

  // Update
  await dbHandler.update('items', {'value': '200'}, "name='Item 1'");

  // Delete
  await dbHandler.delete('items', "name='Item 1'");
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // int _counter = 0;

//   // void _incrementCounter() {
//   //   setState(() {
//   //     _counter++;
//   //   });
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//   //       title: Text(widget.title),
//   //     ),
//   //     body: Center(
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: <Widget>[
//   //           const Text(
//   //             'You have pushed the button this many times:',
//   //           ),
//   //           Text(
//   //             '$_counter',
//   //             style: Theme.of(context).textTheme.headlineMedium,
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     floatingActionButton: FloatingActionButton(
//   //       onPressed: _incrementCounter,
//   //       tooltip: 'Increment',
//   //       child: const Icon(Icons.add),
//   //     ), // This trailing comma makes auto-formatting nicer for build methods.
//   //   );
//   // }
// }
