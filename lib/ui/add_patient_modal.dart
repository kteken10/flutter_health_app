import 'package:flutter/material.dart';
import '../model/patient.dart';  // Assure-toi que la classe Patient est bien importée.

class AddPatientModal extends StatefulWidget {
  final Function(Patient) onPatientAdded;

  const AddPatientModal({Key? key, required this.onPatientAdded}) : super(key: key);

  @override
  _AddPatientModalState createState() => _AddPatientModalState();
}

class _AddPatientModalState extends State<AddPatientModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter un patient"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Nom du patient"),
          ),
          TextField(
            controller: _ageController,
            decoration: const InputDecoration(labelText: "Date de naissance"),
          ),
          TextField(
            controller: _statusController,
            decoration: const InputDecoration(labelText: "Statut"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();  // Ferme la modale si on annule
          },
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: () {
            // Créer un nouveau patient
            final newPatient = Patient(
              name: _nameController.text,
              age: _ageController.text,
              status: _statusController.text,
              imageUrl: 'assets/default-patient.png', // Utilise une image par défaut pour le patient
            );
            widget.onPatientAdded(newPatient);  // Ajoute le patient à la liste
            Navigator.of(context).pop();  // Ferme la modale après ajout
          },
          child: const Text("Ajouter"),
        ),
      ],
    );
  }
}
