import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  final String diseaseName;
  
  const DescriptionSection({
    super.key,
    required this.diseaseName,
  });

  @override
  Widget build(BuildContext context) {
    final diseaseInfo = _getDiseaseInfo(diseaseName);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'À propos de ${diseaseInfo['name']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              diseaseInfo['description']!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            if (diseaseInfo['symptoms'] != null) ...[
              _buildInfoSection('Symptômes courants', diseaseInfo['symptoms']!),
              const SizedBox(height: 12),
            ],
            if (diseaseInfo['prevention'] != null) ...[
              _buildInfoSection('Prévention', diseaseInfo['prevention']!),
              const SizedBox(height: 12),
            ],
            if (diseaseInfo['treatment'] != null) ...[
              _buildInfoSection('Traitement', diseaseInfo['treatment']!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 52, 121, 240),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Map<String, String> _getDiseaseInfo(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'diabete':
        return {
          'name': 'Diabète',
          'description': 'Le diabète est une maladie chronique caractérisée par un excès '
              'de sucre dans le sang (hyperglycémie). Il existe principalement deux types : '
              'le diabète de type 1 (insulinodépendant) et le diabète de type 2.',
          'symptoms': '• Soif intense\n• Urines abondantes\n• Fatigue anormale\n'
              '• Faim excessive\n• Cicatrisation lente\n• Infections fréquentes',
          'prevention': '• Alimentation équilibrée\n• Activité physique régulière\n'
              '• Contrôle du poids\n• Surveillance glycémique après 40 ans',
          'treatment': '• Régime alimentaire adapté\n• Activité physique\n'
              '• Antidiabétiques oraux ou insuline\n• Surveillance régulière',
        };
      case 'hypertension':
        return {
          'name': 'Hypertension',
          'description': 'L\'hypertension artérielle (HTA) est une pathologie cardiovasculaire '
              'définie par une pression artérielle trop élevée. Elle est un facteur de risque majeur '
              'pour les accidents vasculaires cérébraux et les infarctus.',
          'symptoms': '• Maux de tête\n• Vertiges\n• Bourdonnements d\'oreilles\n'
              '• Troubles visuels\n• Saignements de nez\n• Essoufflement',
          'prevention': '• Réduction de la consommation de sel\n• Activité physique régulière\n'
              '• Limitation de l\'alcool\n• Arrêt du tabac\n• Gestion du stress',
          'treatment': '• Médicaments antihypertenseurs\n• Régime pauvre en sel\n'
              '• Surveillance tensionnelle\n• Traitement des facteurs de risque associés',
        };
      default:
        return {
          'name': diseaseName,
          'description': 'Description générale de la maladie. Consultez un professionnel '
              'de santé pour des informations spécifiques à votre cas.',
        };
    }
  }
}