import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? placeholder;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? icon;
  final bool isPassword;
  final Color? iconColor;
  final Color? focusedBorderColor; // This will still control the focused border

  const InputField({
    super.key,
    required this.controller,
    required this.hint,
    this.placeholder,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.isPassword = false,
    this.iconColor,
    this.focusedBorderColor, // Initialize new property
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscure,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.hint,
          hintText: widget.placeholder ?? widget.hint,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          prefixIcon: widget.icon != null ? Icon(widget.icon, color: widget.iconColor) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: widget.iconColor ?? Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          )
              : null,
          // --- Styling for focused and unfocused states ---
          labelStyle: const TextStyle(color: Colors.black), // Label color when unfocused (default)
          floatingLabelStyle: const TextStyle(
            color: Colors.black, // Focused label color is explicitly BLACK
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 1), // Default unfocused border color is BLACK
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? Colors.black, // Focused border color (red from login/signup screen, or default black)
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 1), // Enabled but unfocused border color is BLACK
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}