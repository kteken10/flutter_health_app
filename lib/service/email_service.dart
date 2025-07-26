import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  final String _smtpServer;
  final String _smtpUsername;
  final String _smtpPassword;
  final int _smtpPort;
  final String _senderEmail;
  final String _senderName;

  EmailService({
    required String smtpServer,
    required String smtpUsername,
    required String smtpPassword,
    int smtpPort = 587,
    String senderEmail = 'tchokoutef@gmail.com',
    String senderName = 'AI Medical Clinic',
  })  : _smtpServer = smtpServer,
        _smtpUsername = smtpUsername,
        _smtpPassword = smtpPassword,
        _smtpPort = smtpPort,
        _senderEmail = senderEmail,
        _senderName = senderName;

  // Configuration du serveur SMTP
  SmtpServer _getSmtpServer() {
    return SmtpServer(
      _smtpServer,
      username: _smtpUsername,
      password: _smtpPassword,
      port: _smtpPort,
      ssl: false,
      allowInsecure: true,
    );
  }

  // 1. Email de bienvenue au patient
  Future<void> sendPatientWelcomeEmail({
    required String recipientEmail,
    required String patientName,
    required String patientId,
    required String doctorName,
  }) async {
    try {
      final smtpServer = _getSmtpServer();
      final message = Message()
        ..from = Address(_senderEmail, _senderName)
        ..recipients.add(recipientEmail)
        ..subject = 'Bienvenue à la Clinique Médicale AI Tchokoute'
        ..html = _buildWelcomeEmailHtml(
          patientName: patientName,
          patientId: patientId,
          doctorName: doctorName,
        );

      await send(message, smtpServer);
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'email de bienvenue: $e');
      rethrow;
    }
  }

  // 2. Email de résultats de prédiction
  Future<void> sendPredictionResults({
    required String recipientEmail,
    required String patientName,
    required String diseaseName,
    required String diseaseDescription,
    required String doctorName,
    String? additionalNotes,
    double? predictionScore,
    required String clinicalParameters,
  }) async {
    try {
      final smtpServer = _getSmtpServer();
      final message = Message()
        ..from = Address(_senderEmail, _senderName)
        ..recipients.add(recipientEmail)
        ..subject = 'Vos Résultats de Prédiction: $diseaseName'
        ..html = _buildPredictionEmailHtml(
          patientName: patientName,
          diseaseName: diseaseName,
          diseaseDescription: diseaseDescription,
          doctorName: doctorName,
          additionalNotes: additionalNotes,
          predictionScore: predictionScore,
          clinicalParameters: clinicalParameters,
        );

      await send(message, smtpServer);
    } catch (e) {
      print('Erreur lors de l\'envoi des résultats de prédiction: $e');
      rethrow;
    }
  }

  // Construction du HTML pour l'email de bienvenue
  String _buildWelcomeEmailHtml({
    required String patientName,
    required String patientId,
    required String doctorName,
  }) {
    return """
    <html>
      <head>
        <style>
          ${_getCommonStyles()}
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h2>Clinique Médicale AI Tchokoute</h2>
          </div>
          
          <h3>Bonjour $patientName,</h3>
          <p>Votre dossier médical a été <strong>créé avec succès</strong> dans notre système.</p>

          <h3>📋 Vos Informations Médicales :</h3>
          <ul>
            <li><strong>Nom Complet :</strong> $patientName</li>
            <li><strong>ID Patient :</strong> $patientId</li>
            <li><strong>Médecin Traitant :</strong> Dr. $doctorName</li>
          </ul>

          <p style="margin-top: 20px;">
            🏥 <em>Vous pouvez maintenant accéder à votre espace patient pour suivre vos rendez-vous et résultats.</em>
          </p>

          <div class="footer">
            Cordialement,<br/>
            L'Équipe Médicale<br/>
            Clinique Médicale AI Tchokoute
          </div>
        </div>
      </body>
    </html>
    """;
  }

  // Construction du HTML pour l'email de prédiction
  String _buildPredictionEmailHtml({
    required String patientName,
    required String diseaseName,
    required String diseaseDescription,
    required String doctorName,
    String? additionalNotes,
    double? predictionScore,
    required String clinicalParameters,
  }) {
    String severitySection = '';
    if (predictionScore != null) {
      final severityColor = predictionScore >= 0.7
          ? '#dc3545'
          : predictionScore >= 0.4
              ? '#ffc107'
              : '#28a745';
      final severityText = predictionScore >= 0.7
          ? 'Risque Élevé'
          : predictionScore >= 0.4
              ? 'Risque Modéré'
              : 'Faible Risque';

      severitySection = """
        <div class="severity-indicator">
          <span class="severity-badge" style="background-color: $severityColor">$severityText</span>
          <span class="prediction-score">${(predictionScore * 100).toStringAsFixed(0)}% de probabilité</span>
        </div>
      """;
    }

    // Construction de la section des paramètres cliniques
    final parametersList = clinicalParameters.split('\n')
      .where((line) => line.trim().isNotEmpty)
      .map((line) => '<li>$line</li>')
      .join('');

    return """
    <html>
      <head>
        <style>
          ${_getCommonStyles()}
          .prediction-card {
            background-color: #f8f9fa;
            border-left: 4px solid #84b1fe;
            padding: 15px;
            margin: 15px 0;
            border-radius: 4px;
          }
          .severity-indicator {
            margin-bottom: 15px;
          }
          .severity-badge {
            display: inline-block;
            padding: 5px 10px;
            color: white;
            border-radius: 12px;
            font-size: 14px;
            font-weight: bold;
            margin-right: 10px;
          }
          .prediction-score {
            font-size: 16px;
            font-weight: bold;
          }
          .action-items {
            background-color: #e8f5e9;
            padding: 15px;
            border-radius: 4px;
            margin-top: 15px;
          }
          .next-steps {
            margin-top: 20px;
          }
          .clinical-params {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
          }
          .clinical-params ul {
            list-style-type: none;
            padding: 0;
          }
          .clinical-params li {
            padding: 5px 0;
            border-bottom: 1px solid #dee2e6;
          }
          .clinical-params li:last-child {
            border-bottom: none;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h2>Résultats de Prédiction Médicale</h2>
          </div>
          
          <h3>Cher(e) $patientName,</h3>
          <p>Voici les résultats de votre analyse prédictive :</p>

          <div class="prediction-card">
            <h3>🔍 Prédiction : $diseaseName</h3>
            $severitySection
            <p>$diseaseDescription</p>
          </div>

          <div class="clinical-params">
            <h4>📊 Paramètres Cliniques :</h4>
            <ul>
              $parametersList
            </ul>
          </div>

          ${additionalNotes != null ? '<div class="action-items"><h4>📝 Notes du Médecin :</h4><p>$additionalNotes</p></div>' : ''}

          <div class="next-steps">
            <h4>Prochaines Étapes :</h4>
            <ul>
              <li>Prenez rendez-vous pour un suivi avec Dr. $doctorName</li>
              <li>Effectuez les examens recommandés</li>
              <li>Surveillez vos symptômes</li>
            </ul>
          </div>

          <p style="margin-top: 20px;">
            <em>Note : Cette analyse prédictive doit être confirmée par un professionnel de santé.</em>
          </p>

          <div class="footer">
            Cordialement,<br/>
            Dr. $doctorName<br/>
            Clinique Médicale AI Tchokoute<br/>
            <small>Ceci est un message automatisé - merci de ne pas y répondre directement</small>
          </div>
        </div>
      </body>
    </html>
    """;
  }

  // Styles CSS communs
  String _getCommonStyles() {
    return """
      body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        color: #333;
        padding: 20px;
      }
      .container {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        max-width: 600px;
        margin: auto;
      }
      h2, h3, h4 {
        color: #2c3e50;
      }
      ul {
        list-style: none;
        padding: 0;
      }
      ul li {
        padding: 8px 0;
      }
      strong {
        color: #2980b9;
      }
      .footer {
        margin-top: 20px;
        font-size: 14px;
        color: #777;
        border-top: 1px solid #eee;
        padding-top: 10px;
      }
      .header {
        background-color: #84b1fe;
        padding: 15px;
        color: white;
        border-radius: 5px;
        text-align: center;
        margin-bottom: 20px;
      }
    """;
  }
}