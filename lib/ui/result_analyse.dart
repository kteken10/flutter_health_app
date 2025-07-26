import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../service/email_service.dart';
import 'bar_chart_sample.dart';

class ResultAnalyse extends StatefulWidget {
  final String diseaseName;
  final double predictionScore;
  final String patientEmail;
  final String patientName;
  final String doctorName;
  final Map<String, dynamic> clinicalParameters;

  const ResultAnalyse({
    super.key,
    required this.diseaseName,
    required this.patientEmail,
    required this.patientName,
    required this.doctorName,
    required this.clinicalParameters,
    this.predictionScore = 0.95,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ResultAnalyseState createState() => _ResultAnalyseState();
}

class _ResultAnalyseState extends State<ResultAnalyse> {
  late AudioPlayer _audioPlayer;
  late Color _resultColor;
  late String _resultMessage;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudio();
    _setResultStyles();
  }

  void _setResultStyles() {
    if (widget.predictionScore >= 0.7) {
      _resultColor = const Color.fromARGB(255, 220, 53, 69);
      _resultMessage = 'Risque élevé de ${widget.diseaseName}';
    } else if (widget.predictionScore >= 0.4) {
      _resultColor = const Color.fromARGB(255, 255, 193, 7);
      _resultMessage = 'Risque modéré de ${widget.diseaseName}';
    } else {
      _resultColor = const Color.fromARGB(255, 40, 167, 69);
      _resultMessage = 'Faible risque de ${widget.diseaseName}';
    }
  }

 Future<void> _sendResults() async {
  setState(() => _isSending = true);
  
  try {
    final emailService = EmailService(
      smtpServer: 'smtp.gmail.com',
        smtpUsername: 'tchokoutef@gmail.com',
        smtpPassword: 'wqex wwni azjo fqnw',
        senderEmail: 'tchokoutef@gmail.com',
        senderName: 'Clinique Médicale AI',
    );

    await emailService.sendPredictionResults(
      recipientEmail: widget.patientEmail,
      patientName: widget.patientName,
      diseaseName: widget.diseaseName,
      diseaseDescription: 'Description de la maladie...',
      doctorName: widget.doctorName,
      additionalNotes: _getRecommendationText(),
      predictionScore: widget.predictionScore,
      clinicalParameters: _formatClinicalParameters(),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Résultats envoyés avec succès'),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de l\'envoi: $e'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _isSending = false);
    }
  }
}

String _formatClinicalParameters() {
  final buffer = StringBuffer();
  buffer.writeln('Paramètres cliniques:');
  for (var param in widget.clinicalParameters['parameters']) {
    buffer.writeln('${param['name']}: ${param['value'].toString()}');
  }
  return buffer.toString();
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
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isSending ? null : _sendResults,
            tooltip: 'Envoyer les résultats',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportResults,
          ),
        ],
      ),
      body: _isSending
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  _buildMainResultSection(),
                  const SizedBox(height: 20),
                  _buildClinicalParametersCard(),
                  const SizedBox(height: 20),
                  _buildRecommendationsCard(),
                  const SizedBox(height: 20),
                
                  _buildActionButtons(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildMainResultSection() {
    return Column(
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
      ],
    );
  }
Widget _buildClinicalParametersCard() {
  // Vérifie si les paramètres sont vides
  if (widget.clinicalParameters['parameters'] == null || 
      widget.clinicalParameters['parameters'].isEmpty) {
    return const SizedBox.shrink();
  }

  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Paramètres Cliniques',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 132, 177, 254),
          ),
        ),
        const SizedBox(height: 12),
        ...widget.clinicalParameters['parameters'].map<Widget>((param) {
          // Conversion sécurisée des valeurs en String
          final paramName = param['name']?.toString() ?? 'N/A';
          final paramValue = param['value']?.toString() ?? 'N/A';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  paramName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  paramValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    ),
  );
}
  Widget _buildRecommendationsCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
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
      child: Column(
        children: [
          const Text(
            'Recommandations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 132, 177, 254),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _getRecommendationText(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }



  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(FontAwesomeIcons.envelope),
              label: const Text('Envoyer au patient'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 132, 177, 254),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isSending ? null : _sendResults,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(FontAwesomeIcons.calendarCheck),
              label: const Text('Planifier suivi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 132, 177, 254),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 132, 177, 254),
                  ),
                ),
              ),
              onPressed: _scheduleFollowUp,
            ),
          ),
        ],
      ),
    );
  }

  void _exportResults() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export des résultats en cours...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _scheduleFollowUp() {
    // Implémentez la logique de planification ici
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Planifier un suivi'),
        content: const Text('Fonctionnalité de planification à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
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