import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item_model.dart';
import 'new_note_page.dart';
import 'edit_note_page.dart';

class NoteHomePage extends StatefulWidget {
  @override
  _NoteHomePageState createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Home'),
        centerTitle: true,
      ),
      body: Consumer<ItemModel>(
        builder: (context, itemModel, child) {
          List<Note> notes = itemModel.notes;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  key: Key(notes[index].title),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    Provider.of<ItemModel>(context, listen: false)
                        .deleteNote(index);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNotePage(index),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(notes[index].title),
                        subtitle: Text(
                          notes[index].content,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewNotePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
