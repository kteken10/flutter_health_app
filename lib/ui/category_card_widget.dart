import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  final String title;
  final String imagePath; // Chemin de l'image à afficher
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCardWidget({
    super.key,
    required this.title,
    required this.imagePath, // Ajout du chemin de l'image
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 120, // Largeur de la carte
        child: Card(
          color: isSelected ? const Color(0xFFD6E4FF) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ajuste la taille du Column selon le contenu
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE0F7FA), // Couleur de fond de l'avatar
                  radius: 30,
                  child: SizedBox(
                    width: 70, // Largeur de l'image
                    height:90, // Hauteur de l'image
                    child: Image.asset(
                      imagePath, // Affichage de l'image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Espace entre l'image et le titre
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF4A4A4A),
                  ),
                  textAlign: TextAlign.center, // Centrer le texte
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
