import 'package:flutter/material.dart';

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
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Ajout de padding autour de la carte
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Bordures arrondies pour l'image
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // L'image occupe tout l'espace disponible
                ),
              ),
            ),
            Positioned(
              bottom: 8.0, // Position du texte en bas de la carte
              left: 8.0,
              right: 8.0,
              child: Container(
                color: Colors.black54, // Fond semi-transparent pour améliorer la lisibilité
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texte en blanc pour le contraste
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
