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

  Future<void> sendPatientWelcomeEmail({
    required String recipientEmail,
    required String patientName,
    required String patientId,
    required String doctorName,
  }) async {
    try {
      final smtpServer = SmtpServer(
        _smtpServer,
        username: _smtpUsername,
        password: _smtpPassword,
        port: _smtpPort,
        ssl: false,
        allowInsecure: true,
      );

      final message = Message()
        ..from = Address(_senderEmail, _senderName)
        ..recipients.add(recipientEmail)
        ..subject = 'Welcome to AI Tchokoute Medical Clinic'
        ..html = _buildWelcomeEmailHtml(
          patientName: patientName,
          patientId: patientId,
          doctorName: doctorName,
        );

      await send(message, smtpServer);
    } catch (e) {
      print('Error sending email: $e');
      rethrow;
    }
  }

  String _buildWelcomeEmailHtml({
    required String patientName,
    required String patientId,
    required String doctorName,
  }) {
    return """
    <html>
      <head>
        <style>
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
          h2 {
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
          }
          .header {
            background-color: #84b1fe;
            padding: 15px;
            color: white;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h2>AI Medical Clinic</h2>
          </div>
          
          <h3>Hello $patientName,</h3>
          <p>Your medical record has been <strong>successfully created</strong> in our system.</p>

          <h3>📋 Your Medical Information:</h3>
          <ul>
            <li><strong>Full Name:</strong> $patientName</li>
            <li><strong>Patient ID:</strong> $patientId</li>
            <li><strong>Primary Physician:</strong> Dr. $doctorName</li>
          </ul>

          <p style="margin-top: 20px;">
            🏥 <em>You can now access your patient portal to track appointments and test results.</em>
          </p>

          <div class="footer">
            Sincerely,<br/>
            The Medical Team<br/>
            AI Medical Clinic
          </div>
        </div>
      </body>
    </html>
    """;
  }
}