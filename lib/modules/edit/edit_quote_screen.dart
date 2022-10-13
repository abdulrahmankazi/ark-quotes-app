import 'package:flutter/material.dart';

import 'edit_quote_controller.dart';

class EditQuoteScreen extends StatelessWidget {
  EditQuoteScreen({Key? key}) : super(key: key);
  final editQuoteController = EditQuoteController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}
