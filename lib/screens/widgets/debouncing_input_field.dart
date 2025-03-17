import 'dart:async';

import 'package:flutter/material.dart';

class DebouncingInputField extends StatefulWidget {
  const DebouncingInputField({
    required this.onChangeText,
    this.hintText,
    this.labelText,
    this.errorText,
    this.initialValue,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.margin,
    this.keyboardInput,
    this.maxLines = 1,
    this.controller,
    this.inputDecoration,
    this.fillColor,
    this.isEnabled = true,
    this.alwaysShowLabel = true,
    super.key,
  });

  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? initialValue;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextInputType? keyboardInput;
  final int? maxLines;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final Color? fillColor;
  final bool isEnabled;
  final bool alwaysShowLabel;
  final ValueChanged<String> onChangeText;

  @override
  State<DebouncingInputField> createState() => _DebouncingInputFieldState();
}

class _DebouncingInputFieldState extends State<DebouncingInputField> {
  Timer? _debounceTimer;

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) => widget.onChangeText(query);

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String sourceSansPro = "Henry Sans Pro";

    /// Declare a base style Family
    const TextStyle sourceSansProStyles = TextStyle(
      fontFamily: sourceSansPro,
      color: Colors.black,
    );

    final bodyStyles = sourceSansProStyles.copyWith(fontWeight: FontWeight.w400);

    return IgnorePointer(
      ignoring: !widget.isEnabled,
      child: TextFormField(
        enabled: widget.isEnabled,
        controller: widget.controller,
        keyboardType: widget.keyboardInput ?? TextInputType.multiline,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        initialValue: widget.initialValue,
        decoration: widget.inputDecoration ??
            InputDecoration(
              labelText: widget.labelText,
              labelStyle: bodyStyles.copyWith(
                  color: widget.errorText != null ? Colors.redAccent : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              hintText: ' ${widget.hintText ?? ''}',
              errorText: widget.errorText,
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.red,
                ),
              ),
              floatingLabelBehavior: widget.alwaysShowLabel ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              fillColor: widget.fillColor ?? Colors.white,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
        onChanged: (text) => _onSearchChanged(text),
      ),
    );
  }
}
