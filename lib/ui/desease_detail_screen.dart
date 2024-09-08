import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Assurez-vous que ce package est ajouté dans pubspec.yaml

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
              icon: const Icon(Icons.menu, color: Color.fromARGB(255, 132, 177, 254)),
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
        crossAxisAlignment: CrossAxisAlignment.stretch, // Étendre la carte à toute la largeur disponible
        children: [
          const SizedBox(height: 10), // Espace en haut pour éloigner l'image de l'AppBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal
            child: SizedBox(
              height: 300, // Hauteur spécifique de la carte
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Bordures arrondies
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding vertical de 8
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity, // Prendre toute la largeur disponible de la carte
                          height: 270,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal pour la description
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0), // Bordures arrondies
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2), // Déplacement de l'ombre
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description de la maladie',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ici, vous pouvez ajouter une description détaillée de la maladie. Cette section peut inclure des informations sur les symptômes, les causes, les traitements, etc.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal pour la ligne
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre les éléments
              children: [
                Text(
                  'Your Condition',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22,
                  child: Icon(
                    FontAwesomeIcons.flask, // Icône de fiole ou laboratoire
                    color: Color.fromARGB(255, 132, 177, 254),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
