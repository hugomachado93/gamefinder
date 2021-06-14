import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final IconData icon;
  final String hint;
  final bool obscure;

  InputField(this.icon, this.hint, this.obscure);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        
      ),
    );

  }
  
}