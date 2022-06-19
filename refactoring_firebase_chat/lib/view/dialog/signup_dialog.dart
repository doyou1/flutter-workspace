import 'package:flutter/material.dart';

class SignupDialog extends StatefulWidget {
  const SignupDialog({Key? key}) : super(key: key);

  @override
  State<SignupDialog> createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("SignupDialog"),
    );
  }
}
