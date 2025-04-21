import 'package:flutter/material.dart';

void main() => runApp(PhoneBookApp());

class PhoneBookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneBook App',
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: HomePage(),
      routes: {
        '/add': (context) => AddContactPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class Contact {
  final String name;
  final String phone;

  Contact(this.name, this.phone);
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contacts = [
    Contact("Jimmy", "01-134211-060"),
    Contact("Maddy", "01-134211-063"),
    Contact("Moeez", "01-134211-104"),
    Contact("Warda", "01-134211-105"),
    Contact("Komal", "01-134211-038"),
  ];

  void addContact(Contact contact) {
    setState(() {
      contacts.add(contact);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Roll no here"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[200],
        child: Icon(Icons.add),
        onPressed: () async {
          final newContact = await Navigator.pushNamed(context, '/add');
          if (newContact != null && newContact is Contact) {
            addContact(newContact);
          }
        },
      ),
    );
  }
}
class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Add Contact"),
              onPressed: () {
                final contact = Contact(_nameController.text, _phoneController.text);
                Navigator.pop(context, contact);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Info")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/jamal.jpg'), // Add image in assets
            ),
            SizedBox(height: 20),
            Text("Jamal Fareed", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("01-134211-062@student.bahria.edu.pk"),
            Text("Roll No: 01-134211-062"),
          ],
        ),
      ),
    );
  }
}
