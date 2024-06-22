import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/contact.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final List<dynamic> data = jsonDecode(response);
    _contacts = data.map((json) => Contact.fromJson(json)).toList();
    notifyListeners();
  }

  void updateContact(Contact contact) {
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _contacts[index] = contact;
      notifyListeners();
    }
  }
}
