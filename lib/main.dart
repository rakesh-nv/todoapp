import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/home_provider.dart';

import 'home.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        )
      ],
      child: Builder(
        builder: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ToDo App',
            home: Home(),
          );
        },
      ),
    );
  }
}
