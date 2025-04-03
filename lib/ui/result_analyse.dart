import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';  // Assure-toi d'importer audioplayers
import 'bar_chart_sample.dart';  // Assure-toi que le chemin est correct

class ResultAnalyse extends StatefulWidget {
  const ResultAnalyse({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResultAnalyseState createState() => _ResultAnalyseState();
}

class _ResultAnalyseState extends State<ResultAnalyse> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudio();
  }

  void _playAudio() async {
    await _audioPlayer.setSource(AssetSource('ia_robot_result.mp3'));
   
    _audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 245, 254),
        title: const Text('Result'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 22,
              child: IconButton(
                icon: const Icon(Icons.download, color: Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Téléchargement en cours...')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 241, 245, 254),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cercle au centre
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(240, 240),
                  painter: PartialCirclePainter(),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '95%',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),  // Espacement de 40 pixels entre les cercles
            // Graphique en barres sous le cercle
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),  // Ajoute une marge horizontale de 16
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const BarChartSample3(),  // Utiliser le widget du graphique
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class PartialCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    final double radius = size.width / 2;
    const double padding = 10;

    final Rect rect = Rect.fromCircle(center: size.center(Offset.zero), radius: radius - padding);
    const double startAngle = -0.5 * 3.14;
    const double sweepAngle = 2 * 3.14 * 0.75;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
