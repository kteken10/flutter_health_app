import 'package:flutter/material.dart';

class DiseaseDetailScreen extends StatelessWidget {
  final String name;
  final String imagePath;

  const DiseaseDetailScreen({
    required this.name,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 232, 250),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 224, 232, 250),
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Ajout d'un padding pour l'espacement
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop(); // Action de retour
              },
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                // Action du menu
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch, // Etendre les éléments à toute la largeur disponible
        children: [
          const SizedBox(height: 40), // Espace en haut pour éloigner l'image de l'AppBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Bordures arrondies
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity, // Prendre toute la largeur disponible
                  height: 200,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
