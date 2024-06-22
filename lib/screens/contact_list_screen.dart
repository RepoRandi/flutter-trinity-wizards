import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizards/themes/color.dart';
import '../providers/contact_provider.dart';
import 'add_contact_screen.dart';
import 'edit_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search, color: orange),
          onPressed: () {
            showSearch(context: context, delegate: ContactSearch());
          },
        ),
        centerTitle: true,
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: orange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddContactScreen()),
              );
            },
          ),
        ],
        elevation: 2.0,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<ContactProvider>(context, listen: false).loadContacts(),
        child: Consumer<ContactProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 26.0, top: 26.0, right: 26.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: provider.contacts.length,
                itemBuilder: (context, index) {
                  final contact = provider.contacts[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditContactScreen(contact: contact),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 25),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundColor: orange,
                          ),
                          const SizedBox(height: 10.0),
                          Text('${contact.firstName} ${contact.lastName}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContactSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, provider, child) {
        final results = provider.contacts.where((contact) {
          return contact.firstName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              contact.lastName.toLowerCase().contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final contact = results[index];
            return ListTile(
              title: Text('${contact.firstName} ${contact.lastName}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditContactScreen(contact: contact),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, provider, child) {
        final results = provider.contacts.where((contact) {
          return contact.firstName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              contact.lastName.toLowerCase().contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final contact = results[index];
            return ListTile(
              title: Text('${contact.firstName} ${contact.lastName}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditContactScreen(contact: contact),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
