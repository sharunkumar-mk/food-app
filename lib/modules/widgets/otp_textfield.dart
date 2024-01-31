import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class OtpTextField extends StatefulWidget {
  const OtpTextField({super.key, required this.onOtpChanged});

  final Function(String) onOtpChanged;

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late List<TextEditingController> otpController;
  @override
  void initState() {
    otpController = List.generate(6, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 50,
          child: TextFormField(
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            controller: otpController[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              if (value.length == 1 && index < 5) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              String otpValue = otpController.map((e) => e.text).join();
              widget.onOtpChanged(otpValue);
            },
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: FoodAppColors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
