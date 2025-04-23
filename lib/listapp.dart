import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'Item Adder App', home: HomePage()));
}

// ------------------ Home Page ------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> items = [];

  // Navigate to form and wait for result
  Future<void> goToAddItemPage() async {
    final newItem = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => AddItemPage()),
    );

    if (newItem != null && newItem.isNotEmpty) {
      setState(() {
        items.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Items')),
      body:
          items.isEmpty
              ? Center(child: Text("No items yet. Tap + to add one."))
              : ListView.builder(
                itemCount: items.length,
                itemBuilder:
                    (_, index) => ListTile(
                      leading: Icon(Icons.label),
                      title: Text(items[index]),
                    ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToAddItemPage,
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}

// ------------------ Form Page ------------------
class AddItemPage extends StatelessWidget {
  AddItemPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _itemController,
                decoration: InputDecoration(labelText: "Item Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an item name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Add Item"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, _itemController.text.trim());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
