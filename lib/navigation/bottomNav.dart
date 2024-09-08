// lib/bottomNav.dart
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediscanai/screens/home.dart';
import 'package:mediscanai/screens/history_tracking.dart';
import 'package:mediscanai/screens/prediction.dart';
import 'package:mediscanai/screens/settings_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

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
                    title: const Text('Acceuil'),
                    activeColor: Color.fromARGB(255, 23, 92, 210)
,
                  ),
                  BottomBarItem(
                    icon: SvgPicture.asset(
                      'assets/brain.svg',
                      height: 24,
                      width: 24,
                    ),
                    title: const Text('Prédictions'),
                     activeColor: Color.fromARGB(255, 23, 92, 210)
,
                  ),
                  BottomBarItem(
                    icon: SvgPicture.asset(
                      'assets/history.svg',
                      height: 24,
                      width: 24,
                    ),
                    title: const Text('Historique'),
                    activeColor: Color.fromARGB(255, 23, 92, 210)
,
                  ),
                  const BottomBarItem(
                    icon: Icon(Icons.settings),
                    title: Text('Settings'),
                   activeColor: Color.fromARGB(255, 23, 92, 210)
,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor:  const Color.fromARGB(255, 132, 177, 254)
,
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
}
