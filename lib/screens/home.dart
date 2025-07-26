import 'package:flutter/material.dart';
import '../data/patients_list.dart';
import '../model/patient.dart';
import '../ui/card.dart';
import '../ui/patient.dart';
import '../ui/add_patient_modal.dart';
import 'prediction.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Patient> filteredPatients = [];
  final String doctorName = "Dr. Smith";

  @override
  void initState() {
    super.initState();
    filteredPatients = patients;
    _searchController.addListener(_filterPatients);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPatients);
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

  void _showAddPatientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddPatientModal(
        onPatientAdded: (newPatient) {
          setState(() {
            patients.add(newPatient);
            filteredPatients = patients;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('${newPatient.name} a été ajouté avec succès'),
                ],
              ),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color.fromARGB(255, 76, 175, 80),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          );
        },
        doctorName: doctorName,
      ),
    );
  }

  void _navigateToPredictionScreen(BuildContext context, Patient patient) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PredictionScreen(
          patientEmail: patient.status, // email du patient
          patientName: patient.name,
          doctorName: doctorName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 241, 245, 254),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 245, 254),
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
              icon: const Icon(Icons.notifications, color: Color.fromARGB(255, 132, 177, 254)),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 132, 177, 254),
        onPressed: () => _showAddPatientDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 241, 245, 254),
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
                    child: CustomCard(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Patients',
                    style: TextStyle(
                      color: Color.fromARGB(255, 132, 177, 254),
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
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: Color.fromARGB(255, 132, 177, 254)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Search by name...',
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
                      icon: const Icon(Icons.search, color: Color.fromARGB(255, 132, 177, 254)),
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
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filteredPatients.map((patient) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        margin: const EdgeInsets.only(right: 10),
                        child: PatientCard(
                          name: patient.name,
                          age: patient.age,
                          status: patient.status,
                          imageUrl: patient.imageUrl,
                          onTap: () => _navigateToPredictionScreen(context, patient),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}