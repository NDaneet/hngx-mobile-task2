import 'package:flutter/material.dart';
import '../model/cv_model.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({super.key});

  @override
  State<EditingScreen> createState() => _EditingScreen();
}

class _EditingScreen extends State<EditingScreen> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
        CVModel.fieldsTitles.length,
        (index) => TextEditingController(
            text: CVModel.fieldsValues[CVModel.fieldsTitles[index]]));
  }

  @override
  void dispose() {
    for (var i = 0; i < CVModel.fieldsTitles.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 173, 153, 153),
          title: const Text(
            "Edit Fields",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black87
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[..._cardList(context)],
          ),
        ));
  }

  Widget _buildCard(context, fieldTitle, index) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 15.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: screenWidth,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fieldTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: TextField(
                  controller: _controllers[index],
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    _submitField(fieldTitle, index);
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 173, 153, 153)
                  ),
                    onPressed: () {
                      _submitField(fieldTitle, index);
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Done", style: TextStyle(color: Colors.black87),),
                  ),
                  const SizedBox(width: 10,),
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 173, 153, 153)
                  ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Cancel", style: TextStyle(color: Colors.black87),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitField(fieldTitle, index) {
    CVModel.fieldsValues[fieldTitle] = _controllers[index].text;
  }

  List<Widget> _cardList(context) {
    List<Widget> cards = [];
    for (var index = 0; index < CVModel.fieldsTitles.length; index++) {
      cards.add(_buildCard(context, CVModel.fieldsTitles[index], index));
    }
    return cards;
  }
}
