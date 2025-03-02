import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;
import '../db/database.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({super.key, this.note});

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(widget.note == null ? 'Новая заметка' : 'Редактирование')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Заголовок'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Содержание'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;

                if (widget.note == null) {
                  await db.addNote(NotesCompanion(
                    title: Value(_titleController.text),
                    content: Value(_contentController.text),
                  ));
                } else {
                  await db.updateNote(widget.note!.copyWith(
                    title: _titleController.text,
                    content: _contentController.text,
                  ));
                }
                if (!context.mounted) return;
                Navigator.pop(context, true);
              },
              child: Text('Сохранить'),
            )
          ],
        ),
      ),
    );
  }
}
