import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context, listen: false);

    TextEditingController nameController = TextEditingController(text: counter.name);
    TextEditingController locationController = TextEditingController(text: counter.homeLocation);

    return WillPopScope(
      onWillPop: () async {
        counter.selectedIndex = 0; // Set index to Home
        return true; // Allow back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Edit Name'),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Home Location'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  counter.saveName(nameController.text);
                  counter.saveHomeLocation(locationController.text);
                  counter.selectedIndex = 0;
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

