// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_whatsaap/pages/mensagens.dart';
import 'package:my_whatsaap/services/form_cadastro.dart';
import 'package:my_whatsaap/utils/appRoutes.dart';

import 'pages/myhome_page.dart';
import 'services/login.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        secondaryHeaderColor: Color(0xff25D366),
        scaffoldBackgroundColor: Color(0xff075E54),
      ),
      //home: Login(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        RouteGenerator.ROTA_MENSAGEM: (context) => Mensagens(),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
