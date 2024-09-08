import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 224, 232, 250),
        title: const Text('Settings'),
      ),
     body: Container(
        color: const Color.fromARGB(255, 224, 232, 250)
, // Définir la couleur de fond ici
        width: double.infinity, // Occupe toute la largeur
        height: double.infinity, // Occupe toute la hauteur
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setting',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Ajoutez des widgets supplémentaires ici pour afficher les données réelles
              ],
            ),
          ),
        ),
      ),
    );
  }
}
