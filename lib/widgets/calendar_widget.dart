import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/task_provider.dart' as task_provider; // Importa con prefijo
import 'widgets/task_list_page.dart'; // Importa TaskListPage

class CalendarWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(task_provider.taskListProvider);

    return Container(
      child: CalendarCarousel<Task>(
        // T es Task, que implementa EventInterface
        onDayPressed: (DateTime date, List<Task> events) {
          // Muestra una lista de tareas para la fecha seleccionada
          // Filtra las tareas por fecha
          final tasksForDate = taskList
              .where((task) =>
                  task.dueDate.year == date.year &&
                  task.dueDate.month == date.month &&
                  task.dueDate.day == date.day)
              .toList();

          // Navega a una nueva página o muestra un widget para mostrar las tareas
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskListPage(tasks: tasksForDate),
            ),
          );
        },
        markedDatesMap: taskList.asMap().map((index, task) {
          return MapEntry(task.dueDate, [task]);
        }).cast<DateTime, List<Task>>(),
        thisMonthDayBorderColor: Colors.grey[300],
        weekDays: ['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'],
        weekendTextStyle: TextStyle(color: Colors.red),
        selectedDayTextStyle: TextStyle(color: Colors.white),
        selectedDayButtonColor: Colors.purple[800],
        todayButtonColor: Colors.purple[800],
        todayTextStyle: TextStyle(color: Colors.white),
        height: 420,
        selectedDateTime: DateTime.now(),
      ),
    );
  }
}
