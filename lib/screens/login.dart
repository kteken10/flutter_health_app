import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// Classe représentant un utilisateur
class User {
  final String phoneNumber;
  final String password;

  User({required this.phoneNumber, required this.password});
}

// Liste de faux utilisateurs avec des numéros camerounais
List<User> fakeUsers = [
  User(phoneNumber: "+237612345678", password: "password123"),
  User(phoneNumber: "+237698765432", password: "password321"),
  User(phoneNumber: "+237677889900", password: "mypassword"),
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  String _password = '';
  bool _obscurePassword = true; // État pour afficher/masquer le mot de passe
  PhoneNumber number = PhoneNumber(isoCode: 'CM'); // Par défaut, isoCode pour le Cameroun

  // Fonction pour vérifier les informations de connexion
  bool _authenticate(String phoneNumber, String password) {
    for (var user in fakeUsers) {
      if (user.phoneNumber == phoneNumber && user.password == password) {
        return true; // L'utilisateur est trouvé
      }
    }
    return false; // Utilisateur non trouvé
  }

  // Fonction de connexion
  void _login() async {
    if (_formKey.currentState!.validate()) {
      if (_authenticate(_phoneNumber, _password)) {
        // Si les informations sont correctes, sauvegarde l'état de connexion
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/bottomNav');
      } else {
        // Si les informations ne sont pas correctes, affiche un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Numéro de téléphone ou mot de passe incorrect')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 245, 254), // Applique la couleur de fond à la page entière
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0), // Bordures circulaires globales
                  border: Border.all(color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber value) {
                      setState(() {
                        _phoneNumber = value.phoneNumber!;
                      });
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                    ),
                    initialValue: number,
                    inputDecoration: const InputDecoration(
                      labelText: 'Phone',
                        labelStyle:  TextStyle(color: Color.fromARGB(255, 132, 177, 254)),
                      border: InputBorder.none, // Supprime la bordure par défaut
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 132, 177, 254),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter phone Number';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0), // Bordures circulaires globales
                  border: Border.all(color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    obscureText: _obscurePassword,
                    onChanged: (value) => _password = value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 132, 177, 254)),
                      border: InputBorder.none, // Supprime la bordure par défaut
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Conteneur avec dégradé pour le bouton
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 132, 177, 254), // Couleur de départ
                      Color.fromARGB(255, 81, 122, 199), // Couleur de fin
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Assurez-vous que le fond est transparent pour voir le gradient
                    shadowColor: Colors.transparent, // Supprimer l'ombre
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Garder les bordures circulaires
                    ),
                  ),
                  child: const Text('Login',style: TextStyle(color: Colors.white),
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
