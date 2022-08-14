// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_whatsaap/services/form_cadastro.dart';

import 'pages/myhome_page.dart';
import 'services/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
        //0xff25D366
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25D366)),
    debugShowCheckedModeBanner: false,
    home: Login(),
    // initialRoute: "/",
    // routes: {
    //   "/FormCadastro": (context) => const FormCadastro(),
    // },
  ));
}
