import 'package:checklist/util/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.amber,
      content:  Container(
          height: 120,
        child: Column(children: [
          // user input with save and cancel button
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
              hintText: "Hey! Sarthak Add Your Tasks Here",
            ),

          ),
          // save button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               MyButton(text: "Save Kar Le", onPressed: onSave),
               const SizedBox(width: 8),
               MyButton(text: "cancel it", onPressed: onCancel),
             ],
            ),
          // cancel button
        ],),
      ),
    );
  }
}
