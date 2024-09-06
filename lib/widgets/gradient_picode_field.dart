import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class GradientPinCodeField extends StatefulWidget {
  @override
  _GradientPinCodeFieldState createState() => _GradientPinCodeFieldState();
}

class _GradientPinCodeFieldState extends State<GradientPinCodeField> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradient PinCode Field'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PinCodeTextField(
            appContext: context,
            length: 4,
            controller: _codeController,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            cursorColor: Colors.black,
            enableActiveFill: true,
            autoFocus: true,
            textStyle: TextStyle(color: Colors.black),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 70,
              fieldWidth: 66,
              activeColor: Colors.transparent,  // We will customize it manually
              inactiveColor: Colors.transparent,
              selectedColor: Colors.transparent,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
            ),
            boxShadows: [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
            onChanged: (value) {},
            onCompleted: (value) {
              print('Completed: $value');
            },
            beforeTextPaste: (text) {
              return true;
            },
            // Create custom decoration for each pin field
            pastedTextStyle: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }

  // This method will create the gradient border around each field
  Widget buildGradientBorder(Widget child) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B1464), Color(0xFFCF2E2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: child,
      ),
    );
  }
}
