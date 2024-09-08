import 'package:flutter/material.dart';

class ParameterWidget extends StatelessWidget {
  final IconData icon;
  final String parameterName;
  final String value;
  final String unit; // Ajout de l'unité

  const ParameterWidget({
    required this.icon,
    required this.parameterName,
    required this.value,
    required this.unit, // Initialisation de l'unité
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Espacement
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fond blanc
          borderRadius: BorderRadius.circular(10), // Bordures arrondies
          border: Border.all(color: Colors.grey, width: 1.5), // Bordure grise visible
        ),
        padding: const EdgeInsets.all(12.0), // Espacement intérieur
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre les colonnes
          children: [
            // Icône
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              child: Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
            ),
            // Nom du paramètre
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal pour le nom
                child: Text(
                  parameterName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            // Valeur du paramètre avec unité
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 4), // Petit espacement entre la valeur et l'unité
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
