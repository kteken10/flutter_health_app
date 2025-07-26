import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui/result_analyse.dart';
import '../ui/parameter_widget.dart';
import '../ui/lab_section.dart';

class DiseaseDetailScreen extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description;

  const DiseaseDetailScreen({
    required this.name,
    required this.imagePath,
    required this.description,
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
          builder: (context) => ResultAnalyse(diseaseName: widget.name),
        ),
      );
    });
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

  Widget _buildDiabetesParameters() {
    return const Column(
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
    );
  }

  Widget _buildHypertensionParameters() {
    return const Column(
      children: [
        ParameterWidget(
          icon: FontAwesomeIcons.heartPulse,
          parameterName: 'Pression artérielle systolique',
          unit: 'mm Hg',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.heartPulse,
          parameterName: 'Pression artérielle diastolique',
          unit: 'mm Hg',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.weightScale,
          parameterName: 'IMC',
          unit: 'kg/m²',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.drumstickBite,
          parameterName: 'Cholestérol total',
          unit: 'mg/dL',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.wineBottle,
          parameterName: 'Consommation d\'alcool',
          unit: 'verres/semaine',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.smoking,
          parameterName: 'Tabagisme',
          unit: 'paquets/année',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.running,
          parameterName: 'Activité physique',
          unit: 'heures/semaine',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.cakeCandles,
          parameterName: 'Âge',
          unit: 'ans',
        ),
      ],
    );
  }

  Widget _buildDefaultParameters() {
    return const Column(
      children: [
        ParameterWidget(
          icon: Icons.help_outline,
          parameterName: 'Paramètres généraux',
          unit: '',
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
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Color.fromARGB(255, 132, 177, 254)),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      body: Column(
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
}