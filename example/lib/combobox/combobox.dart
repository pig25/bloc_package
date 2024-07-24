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
  String selectString2 = '1';
  ComBoBoxTestModel? selectTest1;
  List<ComBoBoxTestModel> test1 = [
    ComBoBoxTestModel(Colors.blue, 'blue'),
    ComBoBoxTestModel(Colors.red, 'red'),
    ComBoBoxTestModel(Colors.green, 'green')
  ];

  @override
  Widget build(BuildContext context) {
    final cstyle = Theme.of(context).textTheme.titleLarge;
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
                    comBoBoxItemEntry: List.generate(15, (index) {
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ComBoBox<String>(
                    selectItem: selectString2,
                    comBoBoxItemEntry: List.generate(15, (index) {
                      String data = '${index + 1}';
                      return ComBoBoxItemEntry<String>(data, data);
                    }),
                    onSelectItemChange: (String? value) {
                      print(value);
                      if (value != null) {
                        setState(() {
                          selectString2 = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ComBoBox<ComBoBoxTestModel>(
                    style: cstyle,
                    selectItem: selectTest1,
                    comBoBoxItemEntry: List.generate(test1.length, (index) {
                      String data = '${index + 1}';
                      return ComBoBoxItemEntry<ComBoBoxTestModel>(
                          test1[index], test1[index].name,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox.square(
                                dimension: cstyle?.fontSize,
                                child: ColoredBox(
                                  color: test1[index].color,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  test1[index].name,
                                  style: cstyle,
                                ),
                              )
                            ],
                          ));
                    }),
                    onSelectItemChange: (ComBoBoxTestModel? value) {
                      print(value);
                      if (value != null) {
                        setState(() {
                          selectTest1 = value;
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

class ComBoBoxTestModel {
  ComBoBoxTestModel(this.color, this.name);

  final Color color;
  final String name;
}
