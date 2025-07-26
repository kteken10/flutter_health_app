import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'bar_chart_sample.dart';

class ResultAnalyse extends StatefulWidget {
  final String diseaseName;
  final double predictionScore;

  const ResultAnalyse({
    super.key,
    required this.diseaseName,
    this.predictionScore = 0.95, // Valeur par défaut à 95%
  });

  @override
  _ResultAnalyseState createState() => _ResultAnalyseState();
}

class _ResultAnalyseState extends State<ResultAnalyse> {
  late AudioPlayer _audioPlayer;
  late Color _resultColor;
  late String _resultMessage;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudio();
    _setResultStyles();
  }

  void _setResultStyles() {
    if (widget.predictionScore >= 0.7) {
      _resultColor = const Color.fromARGB(255, 220, 53, 69); // Rouge pour risque élevé
      _resultMessage = 'Risque élevé de ${widget.diseaseName}';
    } else if (widget.predictionScore >= 0.4) {
      _resultColor = const Color.fromARGB(255, 255, 193, 7); // Jaune pour risque modéré
      _resultMessage = 'Risque modéré de ${widget.diseaseName}';
    } else {
      _resultColor = const Color.fromARGB(255, 40, 167, 69); // Vert pour faible risque
      _resultMessage = 'Faible risque de ${widget.diseaseName}';
    }
  }

  void _playAudio() async {
    try {
      await _audioPlayer.setSource(AssetSource('ia_robot_result.mp3'));
      _audioPlayer.resume();
    } catch (e) {
      debugPrint('Erreur de lecture audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 245, 254),
        title: Text('Résultats pour ${widget.diseaseName}'),
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
                    SnackBar(
                      content: const Text('Export des résultats en cours...'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
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
            // Section résultat principal
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(240, 240),
                      painter: PartialCirclePainter(
                        percentage: widget.predictionScore,
                        color: _resultColor,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(widget.predictionScore * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _resultMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: _resultColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Recommandations basées sur le résultat
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    _getRecommendationText(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Graphique des facteurs de risque
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Facteurs de risque',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: BarChartSample3(diseaseName: widget.diseaseName),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRecommendationText() {
    if (widget.predictionScore >= 0.7) {
      return widget.diseaseName.toLowerCase() == 'hypertension'
          ? 'Consultez un cardiologue rapidement. Surveillez votre tension artérielle quotidiennement.'
          : 'Consultez un spécialiste rapidement. Un traitement précoce est recommandé.';
    } else if (widget.predictionScore >= 0.4) {
      return widget.diseaseName.toLowerCase() == 'hypertension'
          ? 'Surveillance recommandée. Adoptez un régime pauvre en sel et faites de l\'exercice régulièrement.'
          : 'Surveillance recommandée. Des examens complémentaires pourraient être utiles.';
    } else {
      return widget.diseaseName.toLowerCase() == 'hypertension'
          ? 'Continuez vos bonnes habitudes. Maintenez une alimentation équilibrée et une activité physique régulière.'
          : 'Résultats rassurants. Continuez à adopter un mode de vie sain.';
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class PartialCirclePainter extends CustomPainter {
  final double percentage;
  final Color color;

  PartialCirclePainter({
    required this.percentage,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    const double padding = 10;

    final Rect rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: radius - padding,
    );

    const double startAngle = -0.5 * 3.14;
    final double sweepAngle = 2 * 3.14 * percentage;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}