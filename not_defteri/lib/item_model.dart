import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemModel extends ChangeNotifier {
  List<Note> _notes = [];
  SharedPreferences? _prefs; // SharedPreferences nesnesini tanımlayın

  ItemModel() {
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    loadNotesFromSharedPreferences();
  }

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    saveNotesToSharedPreferences(); // Not eklediğinizde SharedPreferences'a kaydedin
    notifyListeners();
  }

  void updateNotes(List<Note> newNotes) {
    _notes = newNotes;
    notifyListeners();
  }


  void deleteNote(int index) {
    _notes.removeAt(index);
    saveNotesToSharedPreferences(); // Not sildiğinizde SharedPreferences'a kaydedin
    notifyListeners();
  }

  void loadNotesFromSharedPreferences() {
    // SharedPreferences'tan notları yükleyin
    List<String>? noteList = _prefs?.getStringList('notes');

    if (noteList != null) {
      _notes = noteList.map((noteString) {
        Map<String, dynamic> noteMap = jsonDecode(noteString);
        return Note(
          title: noteMap['title'],
          content: noteMap['content'],
        );
      }).toList();

      // Güncellenmiş notları ItemModel üzerinden yayınlayın
      updateNotes(_notes);
    }
  }

  void saveNotesToSharedPreferences() {
    // Notları SharedPreferences'a kaydedin
    List<String> noteList = _notes.map((note) {
      Map<String, dynamic> noteMap = {
        'title': note.title,
        'content': note.content,
      };
      return jsonEncode(noteMap);
    }).toList();

    _prefs?.setStringList('notes', noteList);

    // Güncellenmiş notları ItemModel üzerinden yayınlayın
    updateNotes(_notes);
  }
}

class Note {
  String title;
  String content;

  Note({required this.title, required this.content});
}
