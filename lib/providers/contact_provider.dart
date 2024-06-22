import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/contact.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];

  List<Contact> get contacts => _filteredContacts;

  Future<void> loadContacts() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final List<dynamic> data = jsonDecode(response);
    _contacts = data.map((json) => Contact.fromJson(json)).toList();
    _filteredContacts = _contacts;
    notifyListeners();
  }

  void updateContact(Contact contact) {
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _contacts[index] = contact;
      notifyListeners();
    }
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    _filteredContacts = _contacts;
    notifyListeners();
  }

  void searchContacts(String query) {
    if (query.isEmpty) {
      _filteredContacts = _contacts;
    } else {
      _filteredContacts = _contacts.where((contact) {
        final fullName =
            '${contact.firstName} ${contact.lastName}'.toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
