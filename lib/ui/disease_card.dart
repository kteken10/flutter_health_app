import 'package:flutter/material.dart';
import '../screens/desease_detail_screen.dart';

class DiseaseCardWidget extends StatelessWidget {
  final String name;
  final String imagePath;
  final String description;
  final String patientEmail;
  final String patientName;
  final String doctorName;
  final Map<String, dynamic> clinicalParameters; // Nouveau paramètre ajouté
  final VoidCallback? onSendPressed;
  final VoidCallback? onDetailPressed;

  const DiseaseCardWidget({
    super.key,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.patientEmail,
    required this.patientName,
    required this.doctorName,
    required this.clinicalParameters, // Marqué comme requis
    this.onSendPressed,
    this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Zone cliquable pour les détails
          Expanded(
            child: InkWell(
              onTap: onDetailPressed ?? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DiseaseDetailScreen(
                      name: name,
                      imagePath: imagePath,
                      description: description,
                      patientEmail: patientEmail,
                      patientName: patientName,
                      doctorName: doctorName,
                      clinicalParameters: clinicalParameters, // Ajouté
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Nom de la maladie
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 132, 177, 254),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Bouton d'envoi (si fourni)
          if (onSendPressed != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: ElevatedButton(
                onPressed: onSendPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 74, 122, 255),
                  minimumSize: const Size(double.infinity, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Envoyer prédiction',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}