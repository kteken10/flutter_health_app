import 'package:flutter/material.dart';

class ResultAnalyse extends StatelessWidget {
  const ResultAnalyse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0), // Padding pour espacer l'icône du bord
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22, // Taille de l'avatar
              child: IconButton(
                icon: const Icon(Icons.download, color: Colors.black), // Icône de téléchargement
                onPressed: () {
                  // Action à réaliser lorsqu'on appuie sur l'icône
                  // Vous pouvez ajouter votre logique de téléchargement ici
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Téléchargement en cours...')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Ceci est une page .'),
      ),
    );
  }
}
