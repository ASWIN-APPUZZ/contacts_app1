// import 'package:contacts_app/src/views/pages/contact_page.dart';
// import 'package:contacts_app/src/views/pages/widgets/login_page.dart';
import 'package:contacts_app/src/views/pages/contact_page.dart';
import 'package:contacts_app/src/views/pages/new_contacts_page.dart';
// import 'package:contacts_app/src/views/pages/widgets/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewContactsPage(),
    );
  }
}
