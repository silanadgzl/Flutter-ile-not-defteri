import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item_model.dart';

class EditNotePage extends StatefulWidget {
  final int index;

  EditNotePage(this.index);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ItemModel itemModel = Provider.of<ItemModel>(context, listen: false);
    _titleController.text = itemModel.notes[widget.index].title;
    _contentController.text = itemModel.notes[widget.index].content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notu Düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: 'Başlık',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                labelText: 'İçerik',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String editedTitle = _titleController.text;
                String editedContent = _contentController.text;

                if (editedTitle.isNotEmpty || editedContent.isNotEmpty) {
                  ItemModel itemModel =
                  Provider.of<ItemModel>(context, listen: false);
                  itemModel.notes[widget.index].title = editedTitle;
                  itemModel.notes[widget.index].content = editedContent;
                  itemModel.notifyListeners();
                  Navigator.pop(context);
                }
              },

              child: Text(
                'Kaydet',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
