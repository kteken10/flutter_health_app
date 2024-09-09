import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,  // Définir une hauteur fixe
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 200,  // Ajuster selon les valeurs maximales de tes données
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
      ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Preg';
        break;
      case 1:
        text = 'Glucose';
        break;
      case 2:
        text = 'BP';
        break;
      case 3:
        text = 'Skin';
        break;
      case 4:
        text = 'Insulin';
        break;
      case 5:
        text = 'BMI';
        break;
      case 6:
        text = 'DPF';
        break;
      case 7:
        text = 'Age';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: getTitles,
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

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 6,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 148,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 72,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 35,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: 0,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          toY: 33.6,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
    BarChartGroupData(
      x: 6,
      barRods: [
        BarChartRodData(
          toY: 0.627,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
    BarChartGroupData(
      x: 7,
      barRods: [
        BarChartRodData(
          toY: 50,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.zero,
        )
      ],
    ),
  ];

  // Methode pour afficher les valeurs au-dessus des barres
  Widget _buildBarLabel(double value, double y, Color color) {
    return Positioned(
      bottom: y + 10, // Ajuste la position de l'étiquette au-dessus de la barre
      child: Text(
        value.toString(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
