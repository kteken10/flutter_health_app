import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String imagePath; // Chemin de l'image à afficher
  final VoidCallback onTap; // Callback pour l'action de tap
  final double cardWidth; // Largeur de la carte
  final Color backgroundColor; // Couleur de fond de la carte
  final Color avatarBackgroundColor; // Couleur de fond de l'avatar

  const CardWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    required this.cardWidth,
    required this.backgroundColor, // Couleur de fond de la carte
    required this.avatarBackgroundColor, // Couleur de fond de l'avatar
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ajuste la taille du Column selon le contenu
        children: [
          SizedBox(
            width: cardWidth,
            height: 98, // Définir la largeur de la carte
            child: Card(
              color: backgroundColor, // Utiliser la couleur de fond dynamique pour la carte
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: avatarBackgroundColor, // Utiliser la couleur dynamique pour l'avatar
                  radius: 30, // Ajuste la taille du cercle
                  child: SizedBox(
                    width: 70, // Largeur de l'image
                    height: 70, // Hauteur de l'image
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain, // Ajuste l'image dans le SizedBox
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ],
      ),
    );
  }
}
