import 'package:flutter/material.dart';

enum InputType { email, phoneNumber, text, password }

class GlobalTextField extends StatefulWidget {
  const GlobalTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.inputType,
    required this.textEditingController,
  }) : super(key: key);

  final String label;
  final String hint;
  final InputType inputType;
  final TextEditingController textEditingController;

  @override
  _GlobalTextFieldState createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  FocusNode _focusNode = FocusNode();
  bool _isPasswordVisible = false;
  String? _errorMessage;
  bool firstFocus = true;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode.addListener(_handleFocusChange);
  // }

  // void _handleFocusChange() {
  //   if (!_focusNode.hasFocus) {
  //     _validate(widget.textEditingController.text);
  //   }
  // }

  String? validateInput(String? value) {
    switch (widget.inputType) {
      case InputType.email:
        return _validateEmail(value ?? "");
      case InputType.password:
        return _validatePassword(value ?? "");
      case InputType.phoneNumber:
        return _validatePhoneNumber(value ?? "");

      default:
        return _validateText(value ?? "");
    }
  }

  String? _validateEmail(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? _validatePhoneNumber(String value) {
    if (value.isEmpty || !RegExp(r'^\+?([0-9]{10,12})$').hasMatch(value)) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  String? _validateText(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  @override
  void dispose() {
    widget.textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void validateField(String value) {
    final currentState = _fieldKey.currentState;
    currentState?.validate();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      controller: widget.textEditingController,
      focusNode: _focusNode,
      onChanged: (value) {
        validateField(value);
      },
      validator: validateInput,
      obscureText:
          widget.inputType == InputType.password && !_isPasswordVisible,
      decoration: InputDecoration(
        label: Text(widget.label),
        hintText: widget.hint,
        errorText: _errorMessage,
        suffixIcon: widget.inputType == InputType.password
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
