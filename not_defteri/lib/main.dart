import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item_model.dart';
import 'note_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemModel()),
      ],
      child: MaterialApp(
        title: 'Not Defteri Uygulaması',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: FutureBuilder<void>(
          // SharedPreferences'ı yüklemek için FutureBuilder kullanın
          future: initSharedPreferences(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return NoteHomePage();
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Future<void> initSharedPreferences() async {
  // SharedPreferences'ı başlatın ve verileri yükleyin
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Burada SharedPreferences'tan verileri çekebilir ve ItemModel sınıfını güncelleyebilirsiniz.
}
