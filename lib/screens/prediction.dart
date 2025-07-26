import 'package:flutter/material.dart';
import '../ui/category_card_widget.dart';
import '../ui/disease_card.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
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
          'description': 'Le diabète est une maladie chronique qui affecte la manière dont le corps utilise le sucre sanguin (glucose).',
        },
        {
          'name': 'Obesite',
          'imagePath': 'assets/obesite.png',
          'description': 'L\'obésité est une maladie caractérisée par une accumulation excessive de graisse corporelle.',
        },
      ]
    },
    {
      'title': 'Cardio',
      'imagePath': 'assets/cardio.png',
      'diseases': [
        {
          'name': 'Hypertension',
          'imagePath': 'assets/hypertension.png', // Assurez-vous d'avoir cette image dans vos assets
          'description': 'L\'hypertension artérielle est une pathologie cardiovasculaire définie par une pression artérielle trop élevée.',
        },
        // Vous pouvez ajouter d'autres maladies cardio-vasculaires ici
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
          'description': 'Le Covid-19 est une maladie respiratoire causée par le virus SARS-CoV-2.',
        },
        {
          'name': 'HIV',
          'imagePath': 'assets/Hiv.png',
          'description': 'Le VIH est un virus qui attaque le système immunitaire.',
        },
      ]
    },
  ];

  int _selectedCategoryIndex = 0;

  void _onCategoryTapped(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 245, 254),
        title: const Text('Prediction'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.folder, color: Color.fromARGB(255, 132, 177, 254)),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 241, 245, 254),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search for a disease',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6E6E6E),
                ),
              ),
              const Text(
                'to get an accurate prediction!',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 132, 177, 254)),
                  ),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                  hintText: '...',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CategoryCardWidget(
                        title: _categories[index]['title'],
                        imagePath: _categories[index]['imagePath'],
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () => _onCategoryTapped(index),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_categories.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      width: 5.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _selectedCategoryIndex == index
                            ? const Color.fromARGB(255, 52, 121, 240)
                            : const Color.fromARGB(255, 195, 215, 248),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              const Text(
                'Disease',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _categories[_selectedCategoryIndex]['diseases'].length,
                  itemBuilder: (context, index) {
                    final disease = _categories[_selectedCategoryIndex]['diseases'][index];
                    return DiseaseCardWidget(
                      name: disease['name'],
                      imagePath: disease['imagePath'],
                      description: disease['description'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}