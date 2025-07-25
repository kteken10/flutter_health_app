import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediscanai/screens/home.dart';
import 'package:mediscanai/screens/history_tracking.dart';
import 'package:mediscanai/screens/prediction.dart';
import 'package:mediscanai/screens/settings_screen.dart';
import 'package:mediscanai/model/patient.dart';
import 'package:mediscanai/data/patients_list.dart';
import 'package:mediscanai/ui/add_patient_modal.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final String doctorName = "Dr. Smith"; // Nom du médecin par défaut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              FirstScreen(),
              PredictionScreen(),
              HistoryTrackingScreen(),
              SettingsScreen(),
            ],
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: BottomBar(
                backgroundColor: Colors.transparent,
                selectedIndex: _currentPage,
                onTap: (int index) {
                  _pageController.jumpToPage(index);
                  setState(() => _currentPage = index);
                },
                items: <BottomBarItem>[
                  BottomBarItem(
                    icon: SvgPicture.asset(
                      'assets/home.svg',
                      height: 20,
                      width: 20,
                    ),
                    title: const Text('Accueil'),
                    activeColor: const Color.fromARGB(255, 23, 92, 210),
                  ),
                  BottomBarItem(
                    icon: SvgPicture.asset(
                      'assets/brain.svg',
                      height: 24,
                      width: 24,
                    ),
                    title: const Text('Prédictions'),
                    activeColor: const Color.fromARGB(255, 23, 92, 210),
                  ),
                  BottomBarItem(
                    icon: SvgPicture.asset(
                      'assets/history.svg',
                      height: 24,
                      width: 24,
                    ),
                    title: const Text('Historique'),
                    activeColor: const Color.fromARGB(255, 23, 92, 210),
                  ),
                  const BottomBarItem(
                    icon: Icon(Icons.settings),
                    title: Text('Paramètres'),
                    activeColor: Color.fromARGB(255, 23, 92, 210),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddPatientModal(
                onPatientAdded: (Patient newPatient) {
                  setState(() {
                    patients.add(newPatient);
                  });
                  // Notification de succès
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white),
                          const SizedBox(width: 8),
                          Text('${newPatient.name} ajouté avec succès'),
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
                doctorName: doctorName, // Passage du nom du médecin
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 132, 177, 254),
        foregroundColor: Colors.white,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: const Padding(
        padding: EdgeInsets.only(bottom: 110.0),
        child: SizedBox.shrink(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}