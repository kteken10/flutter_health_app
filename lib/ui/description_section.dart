import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  final String diseaseName;
  
  const DescriptionSection({
    super.key,
    required this.diseaseName,
  });

  @override
  Widget build(BuildContext context) {
    final diseaseInfo = _getDiseaseInfo(diseaseName);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About ${diseaseInfo['name']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              diseaseInfo['description']!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            if (diseaseInfo['symptoms'] != null) ...[
              _buildInfoSection('Common Symptoms', diseaseInfo['symptoms']!),
              const SizedBox(height: 12),
            ],
            if (diseaseInfo['prevention'] != null) ...[
              _buildInfoSection('Prevention', diseaseInfo['prevention']!),
              const SizedBox(height: 12),
            ],
            if (diseaseInfo['treatment'] != null) ...[
              _buildInfoSection('Treatment', diseaseInfo['treatment']!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 52, 121, 240),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Map<String, String> _getDiseaseInfo(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'diabetes':
        return {
          'name': 'Diabetes',
          'description': 'Diabetes is a chronic disease characterized by high blood sugar levels (hyperglycemia). '
              'There are two main types: type 1 diabetes (insulin-dependent) and type 2 diabetes.',
          'symptoms': '• Excessive thirst\n• Frequent urination\n• Unexplained fatigue\n'
              '• Increased hunger\n• Slow wound healing\n• Recurrent infections',
          'prevention': '• Balanced diet\n• Regular physical activity\n'
              '• Weight management\n• Blood sugar monitoring after age 40',
          'treatment': '• Dietary management\n• Physical exercise\n'
              '• Oral antidiabetics or insulin\n• Regular monitoring',
        };
      case 'hypertension':
        return {
          'name': 'Hypertension',
          'description': 'Hypertension (high blood pressure) is a cardiovascular condition defined by abnormally '
              'high blood pressure. It is a major risk factor for strokes and heart attacks.',
          'symptoms': '• Headaches\n• Dizziness\n• Tinnitus (ringing in ears)\n'
              '• Vision problems\n• Nosebleeds\n• Shortness of breath',
          'prevention': '• Reduced salt intake\n• Regular exercise\n'
              '• Limited alcohol consumption\n• Smoking cessation\n• Stress management',
          'treatment': '• Antihypertensive medications\n• Low-sodium diet\n'
              '• Blood pressure monitoring\n• Management of associated risk factors',
        };
      default:
        return {
          'name': diseaseName,
          'description': 'General disease description. Please consult a healthcare professional '
              'for information specific to your case.',
        };
    }
  }
}