import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ui/result_analyse.dart';
import '../ui/parameter_widget.dart';
import '../ui/lab_section.dart'; // Assurez-vous que ce fichier est importé

class DiseaseDetailScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description; // Ajouté pour la description de la maladie

  const DiseaseDetailScreen({
    required this.name,
    required this.imagePath,
    required this.description, // Ajouté pour la description de la maladie
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
  vsync: this,  // Add this line to fix the issue
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
        );
      },
    );

    Future.delayed(const Duration(seconds: 9), () {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultAnalyse(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 241, 245, 254),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 245, 254),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          widget.imagePath,
                          fit: BoxFit.cover,
                          width: 140,
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
                    widget.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description, // Utilisation de la description passée en paramètre
                    style: const TextStyle(
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
          LabSection(
            onTap: _showModal,
            controller: _controller,
            scaleAnimation: _scaleAnimation,
            colorAnimation: _colorAnimation,
          ),
          // Paramètres de santé avec effet de défilement
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
