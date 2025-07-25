// lib/ui/PatientCard.dart
import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String age;
  final String status;
  final String imageUrl;

  const PatientCard({
    super.key,
    required this.name,
    required this.age,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Hauteur de la carte
      width: double.infinity,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8.0), // Marge entre les cartes
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Bordures arrondies
        ),
        elevation: 0, // Élévation pour un léger effet d'ombre
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Ajout d'une marge intérieure
          child: Row(
            children: [
              // Première colonne avec l'image dans un carré à fond orange
              SizedBox(
                width: 80, // Largeur du carré
                height: 80, // Hauteur du carré
                // color: Colors.orange, // Couleur de fond orange
                child: Padding(
                  padding: const EdgeInsets.all(5.0), // Marge intérieure pour réduire l'image
                  child: Image.asset(
                    imageUrl, // Utilisation de l'URL de l'image fournie
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16), // Espacement entre les colonnes
              // Deuxième colonne avec trois lignes de texte
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8), // Espacement entre les lignes
                    Text(
                      ' $age',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8), // Espacement entre les lignes
                    Text(
                      ' $status',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
