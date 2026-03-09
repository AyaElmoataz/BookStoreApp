import 'package:book_store_app/constants/hive_constants.dart';
import 'package:book_store_app/firebase_options.dart';
import 'package:book_store_app/models/book.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initInjections() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());
  await Hive.openBox<Book>(HiveConstants.booksBox);
}
