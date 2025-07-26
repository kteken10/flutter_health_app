import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample3 extends StatefulWidget {
  final String diseaseName;
  final Map<String, double>? customValues;

  const BarChartSample3({
    super.key,
    required this.diseaseName,
    this.customValues,
  });

  @override
  State<BarChartSample3> createState() => _BarChartSample3State();
}

class _BarChartSample3State extends State<BarChartSample3> {
  late List<BarChartGroupData> barGroups;
  late double maxY;

  @override
  void initState() {
    super.initState();
    _initializeChartData();
  }

  void _initializeChartData() {
    if (widget.diseaseName.toLowerCase() == 'hypertension') {
      // Données pour l'hypertension
      barGroups = [
        _buildBarGroup(0, 'Systolique', widget.customValues?['systolic'] ?? 120),
        _buildBarGroup(1, 'Diastolique', widget.customValues?['diastolic'] ?? 80),
        _buildBarGroup(2, 'Cholestérol', widget.customValues?['cholesterol'] ?? 180),
        _buildBarGroup(3, 'IMC', widget.customValues?['bmi'] ?? 25),
        _buildBarGroup(4, 'Âge', widget.customValues?['age'] ?? 45),
      ];
      maxY = 200;
    } else {
      // Données par défaut (diabète)
      barGroups = [
        _buildBarGroup(0, 'Glucose', widget.customValues?['glucose'] ?? 148),
        _buildBarGroup(1, 'Pression', widget.customValues?['bp'] ?? 72),
        _buildBarGroup(2, 'Insuline', widget.customValues?['insulin'] ?? 0),
        _buildBarGroup(3, 'IMC', widget.customValues?['bmi'] ?? 33.6),
        _buildBarGroup(4, 'Âge', widget.customValues?['age'] ?? 50),
      ];
      maxY = 200;
    }
  }

  BarChartGroupData _buildBarGroup(int x, String label, double value) {
    final color = _getColorForValue(label, value);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 22,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxY,
            color: Colors.grey[200],
          ),
        )
      ],
      showingTooltipIndicators: [0],
    );
  }

  Color _getColorForValue(String label, double value) {
    if (widget.diseaseName.toLowerCase() == 'hypertension') {
      if (label == 'Systolique') {
        return value >= 140 ? Colors.red : value >= 130 ? Colors.orange : Colors.blue;
      } else if (label == 'Diastolique') {
        return value >= 90 ? Colors.red : value >= 85 ? Colors.orange : Colors.blue;
      } else if (label == 'Cholestérol') {
        return value >= 240 ? Colors.red : value >= 200 ? Colors.orange : Colors.blue;
      } else if (label == 'IMC') {
        return value >= 30 ? Colors.red : value >= 25 ? Colors.orange : Colors.blue;
      }
    } else { // Diabète
      if (label == 'Glucose') {
        return value >= 126 ? Colors.red : value >= 100 ? Colors.orange : Colors.blue;
      } else if (label == 'Pression') {
        return value >= 80 ? Colors.red : value >= 75 ? Colors.orange : Colors.blue;
      }
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: _barTouchData,
        titlesData: _titlesData,
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
      ),
    );
  }

  BarTouchData get _barTouchData => BarTouchData(
    enabled: true,
    touchTooltipData: BarTouchTooltipData(
    
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        final label = _getLabel(group.x.toInt());
        return BarTooltipItem(
          '$label: ${rod.toY.toStringAsFixed(1)}\n',
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: _getRangeText(label, rod.toY),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    ),
  );

  String _getLabel(int index) {
    if (widget.diseaseName.toLowerCase() == 'hypertension') {
      switch (index) {
        case 0: return 'P. Systolique';
        case 1: return 'P. Diastolique';
        case 2: return 'Cholestérol';
        case 3: return 'IMC';
        case 4: return 'Âge';
        default: return '';
      }
    } else {
      switch (index) {
        case 0: return 'Glucose';
        case 1: return 'Pression';
        case 2: return 'Insuline';
        case 3: return 'IMC';
        case 4: return 'Âge';
        default: return '';
      }
    }
  }

  String _getRangeText(String label, double value) {
    if (widget.diseaseName.toLowerCase() == 'hypertension') {
      if (label.contains('Systolique')) {
        if (value >= 140) return '(Élevée)';
        if (value >= 130) return '(Normale haute)';
        return '(Normale)';
      } else if (label.contains('Diastolique')) {
        if (value >= 90) return '(Élevée)';
        if (value >= 85) return '(Normale haute)';
        return '(Normale)';
      }
    } else {
      if (label == 'Glucose') {
        if (value >= 126) return '(Élevé)';
        if (value >= 100) return '(Prédiabète)';
        return '(Normal)';
      }
    }
    return '';
  }

  FlTitlesData get _titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (value, meta) {
          final label = _getLabel(value.toInt());
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );
}