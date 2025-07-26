import 'package:flutter/material.dart';

class ParameterWidget extends StatefulWidget {
  final IconData icon;
  final String parameterName;
  final String unit;
  final num initialValue;
  final ValueChanged<num> onChanged;

  const ParameterWidget({
    super.key,
    required this.icon,
    required this.parameterName,
    required this.unit,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<ParameterWidget> createState() => _ParameterWidgetState();
}

class _ParameterWidgetState extends State<ParameterWidget> {
  late num _value;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _controller = TextEditingController(text: _value.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue(num newValue) {
    setState(() {
      _value = newValue;
      _controller.text = _value.toStringAsFixed(_value is int ? 0 : 1);
    });
    widget.onChanged(_value);
  }

  void _increment() {
    if (_value is int) {
      _updateValue(_value + 1);
    } else {
      _updateValue((_value + 0.1).toDouble());
    }
  }

  void _decrement() {
    if (_value <= 0) return;
    if (_value is int) {
      _updateValue(_value - 1);
    } else {
      _updateValue((_value - 0.1).toDouble());
    }
  }

  Widget _buildValueField() {
    return SizedBox(
      width: 70,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        onChanged: (val) {
          if (widget.initialValue is int) {
            final parsed = int.tryParse(val);
            if (parsed != null) _updateValue(parsed);
          } else {
            final parsed = double.tryParse(val);
            if (parsed != null) _updateValue(parsed);
          }
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 229, 236, 248),
              radius: 22,
              child: Icon(
                widget.icon,
                color: const Color.fromARGB(255, 132, 177, 254),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.parameterName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.unit,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrement,
                  color: Colors.red,
                  iconSize: 20,
                  padding: const EdgeInsets.all(8),
                ),
                _buildValueField(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _increment,
                  color: Colors.green,
                  iconSize: 20,
                  padding: const EdgeInsets.all(8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
