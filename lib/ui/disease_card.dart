import 'package:flutter/material.dart';
import '../screens/desease_detail_screen.dart';

class DiseaseCardWidget extends StatelessWidget {
  final String name;
  final String imagePath;

  const DiseaseCardWidget({
    required this.name,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiseaseDetailScreen(
              name: name,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding vertical
        child: Card(
          elevation: 4.0,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black54, // Couleur de fond noir avec opacité
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)), // Bordure arrondie en bas
                ),
                padding: const EdgeInsets.all(8.0),
                width: double.infinity, // Prendre toute la largeur disponible
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Couleur du texte blanc
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
