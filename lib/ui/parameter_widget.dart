import 'package:flutter/material.dart';

class ParameterWidget extends StatefulWidget {
  final IconData icon;
  final String parameterName;
  final String unit;

  const ParameterWidget({
    required this.icon,
    required this.parameterName,
    required this.unit,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ParameterWidgetState createState() => _ParameterWidgetState();
}

class _ParameterWidgetState extends State<ParameterWidget> {
  // Stockage de la valeur actuelle
  int _value = 0;

  // Méthode pour incrémenter la valeur
  void _increment() {
    setState(() {
      _value++;
    });
  }

  // Méthode pour décrémenter la valeur
  void _decrement() {
    setState(() {
      if (_value > 0) _value--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 8.0), // Espacement
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fond blanc
          borderRadius: BorderRadius.circular(10), // Bordures arrondies
          
        ),
        padding: const EdgeInsets.all(12.0), // Espacement intérieur
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacement entre les colonnes
          children: [
            // Icône
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 229, 236, 248),
              radius: 22,
              child: Icon(
                widget.icon,
                color: const Color.fromARGB(255, 132, 177, 254),
                size: 24,
              ),
            ),
            // Nom du paramètre avec unité en dessous
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Espacement horizontal pour le nom
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
                  children: [
                    Text(
                      widget.parameterName,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4), // Petit espacement entre le nom et l'unité
                    Text(
                      widget.unit,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Incrémentation et TextField
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrement,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 50, // Largeur du champ pour entrer la valeur
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(text: _value.toString()),
                    onChanged: (val) {
                      setState(() {
                        _value = int.tryParse(val) ?? 0;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _increment,
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
