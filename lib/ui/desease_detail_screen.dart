import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'parameter_widget.dart'; // Assurez-vous que ce package est ajouté dans pubspec.yaml

class DiseaseDetailScreen extends StatefulWidget {
  final String name;
  final String imagePath;

  const DiseaseDetailScreen({
    required this.name,
    required this.imagePath,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DiseaseDetailScreenState createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Analyse en cours'),
          content: SizedBox(
            width: double.maxFinite,
            child: Image.asset('assets/ia_robot.gif'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la modale
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 241, 245, 254),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 245, 254),
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
          widget.name,
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
        children: [
          // Image de la maladie
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal
            child: SizedBox(
              height: 200,
              width: double.infinity, // Hauteur spécifique de la carte
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
                          widget.imagePath,
                          fit: BoxFit.cover,
                          width: 140, // Prendre toute la largeur disponible de la carte
                          height: 176,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Description de la maladie
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
          // Ligne de laboratoire avec icône d'analyse animée au milieu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal pour la ligne
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu
              children: [
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Laboratory',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _showModal, // Afficher la modale au clic
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return ScaleTransition(
                        scale: _scaleAnimation,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 22,
                          child: Icon(
                            FontAwesomeIcons.heartPulse, // Icône d'analyse
                            color: _colorAnimation.value,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
          ),
          // Paramètres de santé avec effet de défilement
          Expanded(
            child: Container(
              height: 200, // Hauteur définie pour la zone défilable
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement autour de la zone défilable
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    ParameterWidget(
                      icon: Icons.donut_large, // Icône pour Pregnancies
                      parameterName: 'Pregnancies',
                      unit: 'times',
                    ),
                    ParameterWidget(
                      icon: Icons.bloodtype, // Icône pour Glucose
                      parameterName: 'Glucose',
                      unit: 'mg/dL',
                    ),
                    ParameterWidget(
                      icon: FontAwesomeIcons.temperatureHalf, // Icône pour BloodPressure
                      parameterName: 'BloodPressure',
                      unit: 'mm Hg',
                    ),
                    ParameterWidget(
                      icon: FontAwesomeIcons.syringe, // Icône pour SkinThickness
                      parameterName: 'SkinThickness',
                      unit: 'mm',
                    ),
                    ParameterWidget(
                      icon: FontAwesomeIcons.vial, // Icône pour Insulin
                      parameterName: 'Insulin',
                      unit: 'mu U/ml',
                    ),
                    ParameterWidget(
                      icon: FontAwesomeIcons.weightScale, // Icône pour BMI
                      parameterName: 'BMI',
                      unit: 'kg/m²',
                    ),
                    ParameterWidget(
                      icon: FontAwesomeIcons.dna, // Icône pour DiabetesPedigreeFunction
                      parameterName: 'DiabetesPedigreeFunction',
                      unit: '',
                    ),
                    ParameterWidget(
                      icon: FontAwesomeIcons.cakeCandles, // Icône pour Age
                      parameterName: 'Age',
                      unit: 'years',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
