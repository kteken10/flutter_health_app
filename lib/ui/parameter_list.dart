import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'parameter_widget.dart'; // Assurez-vous que ce package est ajouté dans pubspec.yaml

class ParameterList extends StatelessWidget {
  const ParameterList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ParameterWidget(
          icon: Icons.donut_large,
          parameterName: 'Pregnancies',
          unit: 'times',
        ),
        ParameterWidget(
          icon: Icons.bloodtype,
          parameterName: 'Glucose',
          unit: 'mg/dL',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.temperatureHalf,
          parameterName: 'BloodPressure',
          unit: 'mm Hg',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.syringe,
          parameterName: 'SkinThickness',
          unit: 'mm',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.vial,
          parameterName: 'Insulin',
          unit: 'mu U/ml',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.weightScale,
          parameterName: 'BMI',
          unit: 'kg/m²',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.dna,
          parameterName: 'DiabetesPedigreeFunction',
          unit: '',
        ),
        ParameterWidget(
          icon: FontAwesomeIcons.cakeCandles,
          parameterName: 'Age',
          unit: 'years',
        ),
      ],
    );
  }
}
