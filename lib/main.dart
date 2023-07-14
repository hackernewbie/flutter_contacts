import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

void main() {
  runApp(const FlutterContacts());
}

class FlutterContacts extends StatefulWidget {
  const FlutterContacts({super.key});

  @override
  State<FlutterContacts> createState() => _FlutterContactsState();
}

class _FlutterContactsState extends State<FlutterContacts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Contacts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const MainPage(),
    );
  }
}

final FlutterContactPicker _contactPicker = FlutterContactPicker();
Contact? _contact;
String? selectedNumber;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Contacts'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Click below to show contacts..',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Contact? contact = await _contactPicker.selectContact();

                    if (contact != null) {
                      setState(() {
                        _contact = contact;
                        List<String>? phoneNumbers = contact!.phoneNumbers;
                        selectedNumber = phoneNumbers?[0] ?? 'Nothing selected';
                      });
                    }
                  },
                  child: const Text('Show Contacts'),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Number: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(selectedNumber ?? 'No Number selected'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
