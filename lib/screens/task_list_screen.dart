import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_scheduler_app/models/task.dart';
import 'package:task_scheduler_app/models/task_data.dart';
import 'package:task_scheduler_app/screens/add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Scheduler'),
      ),
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return ListView.builder(
            itemCount: taskData.tasks.length,
            itemBuilder: (context, index) {
              final task = taskData.tasks[index];
              return ListTile(
                title: Text(task.name),
                subtitle: Text('${task.dateTime}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskData.deleteTask(task);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
      ),
    );
  }
}
