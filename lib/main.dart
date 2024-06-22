import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/contact_provider.dart';
import 'screens/contact_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactProvider()..loadContacts(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contact Manager',
        home: ContactListScreen(),
      ),
    );
  }
}
