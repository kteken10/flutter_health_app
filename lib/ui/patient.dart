// lib/ui/EmptyCard.dart
import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Hauteur de la carte
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8.0), // Marge entre les cartes
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Bordures arrondies
        ),
        elevation: 2.0, // Élévation pour un léger effet d'ombre
        child: Center(
          child: Text(
            'Carte Vide',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
