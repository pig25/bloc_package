import 'package:bloc_package/combobox/model/combobox.dart';
import 'package:bloc_package/combobox/page/combobox.dart';
import 'package:flutter/material.dart';

class ComBoBoxView extends StatefulWidget {
  const ComBoBoxView({super.key});

  @override
  State<StatefulWidget> createState() => _ComBoBoxView();
}

class _ComBoBoxView extends State<ComBoBoxView> {
  int selectInt = 1;
  String selectString = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComBoBox'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ComBoBox<int>(
                selectItem: selectInt,
                comBoBoxItemEntry: List.generate(10, (index) {
                  int data = index + 1;
                  return ComBoBoxItemEntry<int>(data, '$data');
                }),
                onSelectItemChange: (int? value) {
                  print(value);
                  if (value != null) {
                    setState(() {
                      selectInt = value;
                    });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ComBoBox<String>(
                    selectItem: selectString,
                    comBoBoxItemEntry: List.generate(10, (index) {
                      String data = '${index + 1}';
                      return ComBoBoxItemEntry<String>(data, data);
                    }),
                    onSelectItemChange: (String? value) {
                      print(value);
                      if (value != null) {
                        setState(() {
                          selectString = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
