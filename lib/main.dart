import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_scheduler_app/screens/task_list_screen.dart';
import 'package:task_scheduler_app/services/notification_service.dart';
import 'package:task_scheduler_app/models/task_data.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => TaskData(),
    child: MaterialApp(
      title: 'Task Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    ),
    );
  }
}