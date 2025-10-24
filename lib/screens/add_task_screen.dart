import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_scheduler_app/models/task.dart';
import 'package:task_scheduler_app/models/task_data.dart';
import 'package:task_scheduler_app/services/notification_service.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskName = '';
  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')), 
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Task Name',
              ),
              onChanged: (newText) {
                newTaskName = newText;
              },
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Selected Date and Time: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime)}'),
                ElevatedButton(
                  child: Text('Select Date and Time'),
                  onPressed: () {
                    _selectDateTime(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                Provider.of<TaskData>(context, listen: false).addTask(
                  Task(name: newTaskName, dateTime: selectedDateTime),
                );

                NotificationService().scheduleNotification(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: 'Task Reminder',
                    body: newTaskName,
                    scheduledNotificationDateTime: selectedDateTime
                );

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
