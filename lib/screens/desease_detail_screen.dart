import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ui/result_analyse.dart';
import '../ui/parameter_widget.dart';
import '../ui/lab_section.dart';

class DiseaseDetailScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description;
  final String patientEmail;
  final String patientName;
  final String doctorName;
  final Map<String, dynamic> clinicalParameters; // Ajouté

  const DiseaseDetailScreen({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.patientEmail,
    required this.patientName,
    required this.doctorName,
    required this.clinicalParameters, // Ajouté
    super.key,
  });

  @override
  _DiseaseDetailScreenState createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isSending = false;
  final Map<String, dynamic> _enteredParameters = {}; // Pour stocker les valeurs saisies

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

    // Initialiser les paramètres avec des valeurs par défaut
    _initializeParameters();
  }

  void _initializeParameters() {
    // Initialiser les paramètres en fonction de la maladie
    switch (widget.name.toLowerCase()) {
      case 'diabete':
        _enteredParameters.addAll({
          'Pregnancies': 0,
          'Glucose': 0,
          'BloodPressure': 0,
          'SkinThickness': 0,
          'Insulin': 0,
          'BMI': 0.0,
          'DiabetesPedigreeFunction': 0.0,
          'Age': 0,
        });
        break;
      case 'hypertension':
        _enteredParameters.addAll({
          'Systolic Blood Pressure': 0,
          'Diastolic Blood Pressure': 0,
          'BMI': 0.0,
          'Total Cholesterol': 0,
          'Alcohol Consumption': 0,
          'Smoking': 0,
          'Physical Activity': 0,
          'Age': 0,
        });
        break;
      default:
        _enteredParameters.addAll({
          'General Parameter': 0,
        });
    }
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
          title: Text('Analyse pour ${widget.name}'),
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
          builder: (context) => ResultAnalyse(
            diseaseName: widget.name,
            patientEmail: widget.patientEmail,
            patientName: widget.patientName,
            doctorName: widget.doctorName,
            clinicalParameters: {
              'parameters': _enteredParameters.entries.map((e) => {
                'name': e.key,
                'value': e.value,
              }).toList(),
            },
          ),
        ),
      );
    });
  }

  // Méthode pour mettre à jour un paramètre
  void _updateParameter(String parameterName, dynamic value) {
    setState(() {
      _enteredParameters[parameterName] = value;
    });
  }

  // Méthode pour les paramètres du diabète
  Widget _buildDiabetesParameters() {
    return Column(
      children: [
        ParameterWidget(
          icon: Icons.donut_large,
          parameterName: 'Pregnancies',
          unit: 'times',
          initialValue: _enteredParameters['Pregnancies'],
          onChanged: (value) => _updateParameter('Pregnancies', value),
        ),
        ParameterWidget(
          icon: Icons.bloodtype,
          parameterName: 'Glucose',
          unit: 'mg/dL',
          initialValue: _enteredParameters['Glucose'],
          onChanged: (value) => _updateParameter('Glucose', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.temperatureHalf,
          parameterName: 'BloodPressure',
          unit: 'mm Hg',
          initialValue: _enteredParameters['BloodPressure'],
          onChanged: (value) => _updateParameter('BloodPressure', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.syringe,
          parameterName: 'SkinThickness',
          unit: 'mm',
          initialValue: _enteredParameters['SkinThickness'],
          onChanged: (value) => _updateParameter('SkinThickness', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.vial,
          parameterName: 'Insulin',
          unit: 'mu U/ml',
          initialValue: _enteredParameters['Insulin'],
          onChanged: (value) => _updateParameter('Insulin', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.weightScale,
          parameterName: 'BMI',
          unit: 'kg/m²',
          initialValue: _enteredParameters['BMI'],
          onChanged: (value) => _updateParameter('BMI', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.dna,
          parameterName: 'DiabetesPedigreeFunction',
          unit: '',
          initialValue: _enteredParameters['DiabetesPedigreeFunction'],
          onChanged: (value) => _updateParameter('DiabetesPedigreeFunction', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.cakeCandles,
          parameterName: 'Age',
          unit: 'years',
          initialValue: _enteredParameters['Age'],
          onChanged: (value) => _updateParameter('Age', value),
        ),
      ],
    );
  }

  // Méthode pour les paramètres de l'hypertension
  Widget _buildHypertensionParameters() {
    return Column(
      children: [
        ParameterWidget(
          icon: FontAwesomeIcons.heartPulse,
          parameterName: 'Systolic Blood Pressure',
          unit: 'mm Hg',
          initialValue: _enteredParameters['Systolic Blood Pressure'],
          onChanged: (value) => _updateParameter('Systolic Blood Pressure', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.heartPulse,
          parameterName: 'Diastolic Blood Pressure',
          unit: 'mm Hg',
          initialValue: _enteredParameters['Diastolic Blood Pressure'],
          onChanged: (value) => _updateParameter('Diastolic Blood Pressure', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.weightScale,
          parameterName: 'BMI',
          unit: 'kg/m²',
          initialValue: _enteredParameters['BMI'],
          onChanged: (value) => _updateParameter('BMI', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.drumstickBite,
          parameterName: 'Total Cholesterol',
          unit: 'mg/dL',
          initialValue: _enteredParameters['Total Cholesterol'],
          onChanged: (value) => _updateParameter('Total Cholesterol', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.wineBottle,
          parameterName: 'Alcohol Consumption',
          unit: 'drinks/week',
          initialValue: _enteredParameters['Alcohol Consumption'],
          onChanged: (value) => _updateParameter('Alcohol Consumption', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.smoking,
          parameterName: 'Smoking',
          unit: 'packs/year',
          initialValue: _enteredParameters['Smoking'],
          onChanged: (value) => _updateParameter('Smoking', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.running,
          parameterName: 'Physical Activity',
          unit: 'hours/week',
          initialValue: _enteredParameters['Physical Activity'],
          onChanged: (value) => _updateParameter('Physical Activity', value),
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.cakeCandles,
          parameterName: 'Age',
          unit: 'years',
          initialValue: _enteredParameters['Age'],
          onChanged: (value) => _updateParameter('Age', value),
        ),
      ],
    );
  }

  // Méthode par défaut pour les autres maladies
  Widget _buildDefaultParameters() {
    return Column(
      children: [
        ParameterWidget(
          icon: Icons.help_outline,
          parameterName: 'General Parameter',
          unit: '',
          initialValue: _enteredParameters['General Parameter'],
          onChanged: (value) => _updateParameter('General Parameter', value),
        ),
      ],
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
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isSending
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Image et description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              widget.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'À propos de ${widget.name}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Section laboratoire
                LabSection(
                  onTap: _showModal,
                  controller: _controller,
                  scaleAnimation: _scaleAnimation,
                  colorAnimation: _colorAnimation,
                ),
                // Paramètres spécifiques à la maladie
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: _buildDiseaseSpecificParameters(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildDiseaseSpecificParameters() {
    switch (widget.name.toLowerCase()) {
      case 'diabete':
        return _buildDiabetesParameters();
      case 'hypertension':
        return _buildHypertensionParameters();
      default:
        return _buildDefaultParameters();
    }
  }
}