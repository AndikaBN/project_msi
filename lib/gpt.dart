import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Input Data',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String inputData = textEditingController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(initialData: [inputData]),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  final List<String> initialData;

  ResultPage({required this.initialData});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    items.addAll(widget.initialData);
  }

  void addItem(String newItem) {
    setState(() {
      items.add(newItem);
    });
  }

  void updateItem(int index, String updatedItem) {
    setState(() {
      items[index] = updatedItem;
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextEditingController textEditingController =
                            TextEditingController(text: items[index]);

                        return AlertDialog(
                          title: Text('Edit Item'),
                          content: TextField(
                            controller: textEditingController,
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Save'),
                              onPressed: () {
                                updateItem(index, textEditingController.text);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Item'),
                          content: Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                deleteItem(index);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController textEditingController =
                  TextEditingController();

              return AlertDialog(
                title: Text('Add Item'),
                content: TextField(
                  controller: textEditingController,
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addItem(textEditingController.text);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
