import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CreditAmountSlider extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final double initialValue;
  final int creditAmount;
  final ValueChanged<double> onChange;
  final String amountText;
  final String descriptionText;

  const CreditAmountSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.creditAmount,
    required this.onChange,
    required this.amountText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Center(
            child: SleekCircularSlider(
              min: minValue,
              max: maxValue,
              initialValue: initialValue,
              appearance: CircularSliderAppearance(
                animationEnabled: true,
                size: 250,
                startAngle: 270,
                angleRange: 360,
                customColors: CustomSliderColors(
                  dynamicGradient: true,
                  trackColor: Colors.orange.shade100,
                  progressBarColor: Colors.orange.shade500.withOpacity(0.9),
                  dotColor: Colors.orangeAccent,
                ),
                customWidths: CustomSliderWidths(
                  trackWidth: 13,
                  progressBarWidth: 15,
                  handlerSize: 15,
                ),
              ),
              onChange: (value) {
                onChange(value);
              },
              innerWidget: (value) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "credit amount",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${creditAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    textAlign: TextAlign.center,
                    descriptionText,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            amountText,
            style: const TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
