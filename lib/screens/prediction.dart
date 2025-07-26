import 'package:flutter/material.dart';
import '../ui/category_card_widget.dart';
import '../ui/disease_card.dart';
import '../screens/desease_detail_screen.dart';

class PredictionScreen extends StatefulWidget {
  final String patientEmail;
  final String patientName;
  final String doctorName;

  const PredictionScreen({
    super.key,
    required this.patientEmail,
    required this.patientName,
    required this.doctorName,
  });

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Metabolisme',
      'imagePath': 'assets/gluco-test.png',
      'diseases': [
        {
          'name': 'Diabete',
          'imagePath': 'assets/diabete.png',
          'description':
              'Le diabète est une maladie chronique qui affecte la manière dont le corps utilise le sucre sanguin (glucose).',
          'clinicalParameters': {
            'parameters': [
              {'name': 'Pregnancies', 'value': 0},
              {'name': 'Glucose', 'value': 0},
              {'name': 'BloodPressure', 'value': 0},
              {'name': 'SkinThickness', 'value': 0},
              {'name': 'Insulin', 'value': 0},
              {'name': 'BMI', 'value': 0.0},
              {'name': 'DiabetesPedigreeFunction', 'value': 0.0},
              {'name': 'Age', 'value': 0},
            ]
          }
        },
        {
          'name': 'Obésité',
          'imagePath': 'assets/obesite.png',
          'description':
              'L\'obésité est une maladie caractérisée par une accumulation excessive de graisse corporelle.',
          'clinicalParameters': {
            'parameters': [
              {'name': 'Poids', 'value': 0},
              {'name': 'Taille', 'value': 0},
              {'name': 'BMI', 'value': 0.0},
              {'name': 'Tour de taille', 'value': 0},
            ]
          }
        },
      ]
    },
    {
      'title': 'Cardio',
      'imagePath': 'assets/cardio.png',
      'diseases': [
        {
          'name': 'Hypertension',
          'imagePath': 'assets/hypertension.png',
          'description':
              'L\'hypertension artérielle est une pathologie cardiovasculaire définie par une pression artérielle trop élevée.',
          'clinicalParameters': {
            'parameters': [
              {'name': 'Pression systolique', 'value': 0},
              {'name': 'Pression diastolique', 'value': 0},
              {'name': 'Fréquence cardiaque', 'value': 0},
              {'name': 'Cholestérol total', 'value': 0},
            ]
          }
        },
      ]
    },
    {
      'title': 'Brain',
      'imagePath': 'assets/brain.png',
      'diseases': []
    },
    {
      'title': 'Infectious',
      'imagePath': 'assets/virus.png',
      'diseases': [
        {
          'name': 'Covid-19',
          'imagePath': 'assets/covid.png',
          'description':
              'Le Covid-19 est une maladie respiratoire causée par le virus SARS-CoV-2.',
          'clinicalParameters': {
            'parameters': [
              {'name': 'Température', 'value': 0.0},
              {'name': 'Toux', 'value': 'Non'},
              {'name': 'Essoufflement', 'value': 'Non'},
            ]
          }
        },
        {
          'name': 'HIV',
          'imagePath': 'assets/Hiv.png',
          'description':
              'Le VIH est un virus qui attaque le système immunitaire.',
          'clinicalParameters': {
            'parameters': [
              {'name': 'CD4 count', 'value': 0},
              {'name': 'Charge virale', 'value': 0},
            ]
          }
        },
      ]
    },
  ];

  int _selectedCategoryIndex = 0;
  bool _isLoading = false;

  void _onCategoryTapped(int index) {
    setState(() => _selectedCategoryIndex = index);
  }

  void _navigateToDiseaseDetail(Map<String, dynamic> disease) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiseaseDetailScreen(
          name: disease['name'],
          imagePath: disease['imagePath'],
          description: disease['description'],
          patientEmail: widget.patientEmail,
          patientName: widget.patientName,
          doctorName: widget.doctorName,
          clinicalParameters: disease['clinicalParameters'] ?? {'parameters': []},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = _categories[_selectedCategoryIndex];
    final selectedDiseases = selectedCategory['diseases'] as List;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F5FE),
        elevation: 0,
        title: const Text('Prediction'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF84B1FE)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.folder, color: Color(0xFF84B1FE)),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xFFF1F5FE),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section informations patient
                  _buildPatientInfoSection(),
                  const SizedBox(height: 16),
                  
                  // Section recherche
                  _buildSearchSection(),
                  const SizedBox(height: 20),
                  
                  // Section catégories
                  _buildCategoriesSection(),
                  const SizedBox(height: 10),
                  
                  // Indicateurs de catégorie
                  _buildCategoryIndicators(),
                  const SizedBox(height: 10),
                  
                  // Titre maladies
                  _buildDiseasesTitle(),
                  const SizedBox(height: 10),
                  
                  // Grille des maladies
                  _buildDiseasesGrid(selectedDiseases),
                ],
              ),
            ),
    );
  }

  Widget _buildPatientInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patient: ${widget.patientName}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
        ),
        Text(
          'Email: ${widget.patientEmail}',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search for a disease',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6E6E6E),
          ),
        ),
        Text(
          'to get an accurate prediction!',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Color.fromARGB(255, 132, 177, 254)),
            ),
            prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
            hintText: '...',
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 123,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return CategoryCardWidget(
                title: category['title'],
                imagePath: category['imagePath'],
                isSelected: _selectedCategoryIndex == index,
                onTap: () => _onCategoryTapped(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_categories.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _selectedCategoryIndex == index
                  ? const Color(0xFF3479F0)
                  : const Color(0xFFC3D7F8),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDiseasesTitle() {
    return const Text(
      'Disease',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4A4A4A),
      ),
    );
  }

  Widget _buildDiseasesGrid(List selectedDiseases) {
    return Expanded(
      child: GridView.builder(
        itemCount: selectedDiseases.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final disease = selectedDiseases[index];
          return DiseaseCardWidget(
            name: disease['name'],
            imagePath: disease['imagePath'],
            description: disease['description'],
            patientEmail: widget.patientEmail,
            patientName: widget.patientName,
            doctorName: widget.doctorName,
            clinicalParameters: disease['clinicalParameters'],
            onDetailPressed: () => _navigateToDiseaseDetail(disease),
          );
        },
      ),
    );
  }
}