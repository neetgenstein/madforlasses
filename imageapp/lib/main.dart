import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

// ------------------ Model ------------------
class Item {
  final String name;
  final File? imageFile;

  Item({required this.name, this.imageFile});
}

// ------------------ Home Page ------------------
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> items = [];

  Future<void> _goToAddItemPage() async {
    final newItem = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (context) => AddItemPage()),
    );

    if (newItem != null) {
      setState(() {
        items.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Items with Images")),
      body:
          items.isEmpty
              ? Center(child: Text("No items yet. Tap + to add one."))
              : ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return ListTile(
                    leading:
                        item.imageFile != null
                            ? Image.network(
                              item.imageFile!.path,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                            : Icon(Icons.image_not_supported),
                    title: Text(item.name),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddItemPage,
        child: Icon(Icons.add),
        tooltip: 'Add Item',
      ),
    );
  }
}

// ------------------ Form Page ------------------
class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newItem = Item(
        name: _nameController.text.trim(),
        imageFile: _selectedImage,
      );
      Navigator.pop(context, newItem);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Item")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Item Name"),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter item name'
                            : null,
              ),
              SizedBox(height: 20),
              _selectedImage == null
                  ? Text("No image selected")
                  : Image.network(_selectedImage!.path, height: 150),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text("Pick Image"),
                onPressed: _pickImage,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text("Add Item")),
            ],
          ),
        ),
      ),
    );
  }
}
