import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onSelected,
    this.search = false,
    this.kOptions,
    this.isPasswordField = false,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
  });
  final bool search;
  final Function(String)? onSelected;
  final List<String>? kOptions;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final String label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return search
        ? Autocomplete(
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return ListTile(
                          title: Text(option),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: const OutlineInputBorder(),
                  labelText: label,
                ),
              );
            },
            onSelected: (option) {
              onSelected!(option);
            },
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return kOptions!.where((option) {
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
          )
        : isPasswordField
            ? PasswordField(
                label: label,
                controller: controller,
              )
            : AutofillGroup(
                child: TextFormField(
                  autofillHints: [
                    keyboardType == TextInputType.emailAddress
                        ? AutofillHints.username
                        : AutofillHints.name
                  ],
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    labelText: label,
                  ),
                ),
              );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key,
      required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text});
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: TextFormField(
        autofillHints: const [AutofillHints.password],
        controller: widget.controller,
        obscureText: obscure,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: const OutlineInputBorder(),
          labelText: widget.label,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
            icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
