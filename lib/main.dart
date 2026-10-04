import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patungan/Features/Auth/Service/auth_storage.dart';
import 'package:patungan/Routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authStorage = AuthStorage();
  final session = await authStorage.getSession();

  runApp(MyApp(router: await createAppRouter(session)));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Patungan',
      routerConfig: router,
    );
  }
}
