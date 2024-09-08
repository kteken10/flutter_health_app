import 'package:flutter/material.dart';
// Importer la liste des patients
import '../data/patient.dart';
import '../model/patient.dart';
import '../ui/Card.dart';
import '../ui/patient.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Patient> filteredPatients = []; // Liste des patients filtrés

  @override
  void initState() {
    super.initState();
    filteredPatients = patients; // Initialiser la liste des patients filtrés avec tous les patients
    _searchController.addListener(_filterPatients); // Ajouter un listener pour la recherche
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPatients); // Supprimer le listener lors de la suppression du widget
    _searchController.dispose();
    super.dispose();
  }

  void _filterPatients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredPatients = patients.where((patient) {
        return patient.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Pour éviter le problème de BottomOverflowed
      backgroundColor: const Color.fromARGB(255, 224, 232, 250), // Appliquer la couleur à tout l'arrière-plan
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 224, 232, 250),
        title: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 28,
          child: ClipOval(
            child: Image.asset(
              'assets/black-doc.png',
              width: 45,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 132, 177, 254)
),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 224, 232, 250), // Assurez-vous que le Container conserve également la couleur
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AI for Disease Prediction',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Expanded(
                    child: CustomCard(), // Utilisation du widget personnalisé ici
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Patients',
                    style: TextStyle(
                      color: Color.fromARGB(255, 132, 177, 254)
,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isSearching ? 200 : 0,
                    height: 40,
                    curve: Curves.easeInOut,
                    child: _isSearching
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                 focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)), // Bordures arrondies
                      borderSide: BorderSide(color: Color.fromARGB(255, 132, 177, 254)
), // Bordure bleue quand le champ est en focus
                    ),
                  
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)), // Bordures arrondies
                      borderSide: BorderSide(color: Colors.white), // Bordure blanche quand le champ n'est pas en focus
                    ),
                                hintText: '...',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              ),
                            ),
                          )
                        : null,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Color.fromARGB(255, 132, 177, 254)
),
                      onPressed: () {
                        setState(() {
                          _isSearching = !_isSearching;
                          if (!_isSearching) {
                            _searchController.clear();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150, // Hauteur des cartes, ajustez si nécessaire
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Défilement horizontal
                  child: Row(
                    children: filteredPatients.map((patient) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.65, // Chaque carte prend 65% de la largeur de l'écran
                        margin: const EdgeInsets.only(right: 10), // Espacement entre les cartes
                        child: PatientCard(
                          name: patient.name,
                          age: patient.age,
                          status: patient.status,
                          imageUrl: patient.imageUrl,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Vos autres éléments ici
            ],
          ),
        ),
      ),
    );
  }
}



