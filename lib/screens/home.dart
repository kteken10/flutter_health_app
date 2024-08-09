// lib/home.dart
import 'package:flutter/material.dart';

import '../ui/Card.dart';


class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 245, 254),
        title: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 28,
          child: ClipOval(
            child: Image.asset(
              'assets/black-doc.png',
              width: 45,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 118, 76, 243)),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 241, 245, 254),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI for Disease Prediction',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Expanded(
                      child: CustomCard(), // Utilisation du widget personnalisé ici
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Patients',
                      style: TextStyle(
                        color:Color.fromARGB(255, 118, 76, 243),
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _isSearching ? 200 : 0,
                      height: 40,
                      curve: Curves.easeInOut,
                      child: _isSearching
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Ajout de la marge horizontale
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: '...',
                                  fillColor: Colors.white, // Couleur de fond du champ de saisie
                                  filled: true, // Activer le remplissage
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15), // Bordures arrondies
                                    borderSide: BorderSide.none, // Supprimer la bordure
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            )
                          : null,
                    ),
                    // Icône de recherche avec cercle blanc
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22, // Ajustez cette valeur pour la taille du cercle
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Color.fromARGB(255, 118, 76, 243)),
                        onPressed: () {
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                        },
                      ),
                    ),
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
