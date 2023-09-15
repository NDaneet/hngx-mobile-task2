import 'package:flutter/material.dart';
import 'editing_screen.dart';
import '../model/cv_model.dart';

class CVScreen extends StatefulWidget {
  const CVScreen({super.key});

  @override
  State<CVScreen> createState() => _CVScreenState();
}

class _CVScreenState extends State<CVScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            width: screenWidth,
            height: 150,
            color: const Color.fromARGB(255, 173, 153, 153),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    CVModel.fieldsValues["Name"],
                    style: const TextStyle(
                        fontSize: 29, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        
                        Text(
                          CVModel.fieldsValues["Slack Name"],
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const ImageIcon(AssetImage("assets/slack.png")),
                      ],
                    ),
                     const SizedBox(
                          height: 10,
                        ),
                    Row(
                      children: [
                        Text(
                          CVModel.fieldsValues["Github Name"],
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const ImageIcon(AssetImage("assets/github.png")),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            CVModel.fieldsValues["Bio"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                ..._additionalFieldsList(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 173, 153, 153)
                  ),
                  onPressed: () async {
                    final bool? returnedValue = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditingScreen(),
                      ),
                    );
                    if (returnedValue != null && returnedValue == true) {
                      setState(() {});
                    }
                  },
                  child: const Text("Edit CV", style: TextStyle(fontSize: 18, color: Colors.black87),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAdditionalField(fieldTitle, fieldContent) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          height: 10,
          thickness: 5,
        ),
        Text(
          fieldContent,
          style: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  List<Widget> _additionalFieldsList() {
    List<Widget> additionalFields = [];

    for (var index = 4; index < CVModel.fieldsTitles.length; index++) {
      additionalFields.add(_buildAdditionalField(CVModel.fieldsTitles[index],
          CVModel.fieldsValues[CVModel.fieldsTitles[index]]));
    }

    return additionalFields;
  }
}
