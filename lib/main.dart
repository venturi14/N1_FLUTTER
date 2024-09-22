import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HabitListScreen(),
    );
  }
}

class HabitListScreen extends StatefulWidget {
  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  Map<String, Habit> habits = {
    'Beber água': Habit(icon: Icons.water, color: Colors.blue, tasks: []),
    'Exercícios': Habit(icon: Icons.fitness_center, color: Colors.green, tasks: []),
  };

  Map<String, bool> _isExpanded = {};
  TextEditingController _habitController = TextEditingController();
  TextEditingController _taskController = TextEditingController();

  void _addHabit(String habitName) {
    if (habitName.isNotEmpty) {
      setState(() {
        habits[habitName] = Habit(icon: Icons.check, color: Color(0xFFD1D0D7), tasks: []);
        _isExpanded[habitName] = false;
      });
      _habitController.clear();
      Navigator.pop(context);
    }
  }

  void _addTask(String habitName, String task) {
    if (task.isNotEmpty) {
      setState(() {
        habits[habitName]?.tasks.add(Task(name: task, completed: false));
      });
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Hábito'),
          content: TextField(
            controller: _habitController,
            decoration: InputDecoration(hintText: 'Nome do hábito'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addHabit(_habitController.text);
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _showAddTaskDialog(String habitName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Tarefa para $habitName'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Nome da tarefa'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addTask(habitName, _taskController.text);
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTask(String habitName, Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  void _deleteHabit(String habitName) {
    setState(() {
      habits.remove(habitName);
      _isExpanded.remove(habitName);
    });
  }

  double _calculateCompletionPercentage(String habitName) {
    List<Task>? tasks = habits[habitName]?.tasks;
    if (tasks == null || tasks.isEmpty) return 0.0;
    int completedTasks = tasks.where((task) => task.completed).length;
    return (completedTasks / tasks.length) * 100;
  }

  double _calculateTotalCompletionPercentage() {
    if (habits.isEmpty) return 0.0;

    int totalTasks = 0;
    int totalCompletedTasks = 0;

    habits.forEach((key, habit) {
      totalTasks += habit.tasks.length;
      totalCompletedTasks += habit.tasks.where((task) => task.completed).length;
    });

    if (totalTasks == 0) return 0.0;

    return (totalCompletedTasks / totalTasks) * 100;
  }

  void _toggleExpansion(String habitName) {
    setState(() {
      _isExpanded[habitName] = !(_isExpanded[habitName] ?? false);
    });
  }

  void _showCustomizeHabitDialog(String habitName) {
    Habit habit = habits[habitName]!;
    showDialog(
      context: context,
      builder: (context) {
        Color? selectedColor = habit.color;
        IconData? selectedIcon = habit.icon;

        return AlertDialog(
          title: Text('Personalizar Hábito: $habitName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Escolha um ícone:'),
              Wrap(
                spacing: 8.0,
                children: [
                  IconButton(
                    icon: Icon(Icons.water),
                    onPressed: () {
                      selectedIcon = Icons.water;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.fitness_center),
                    onPressed: () {
                      selectedIcon = Icons.fitness_center;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.star),
                    onPressed: () {
                      selectedIcon = Icons.star;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      selectedIcon = Icons.access_time; 
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.bed),
                    onPressed: () {
                      selectedIcon = Icons.bed; 
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.hotel),
                    onPressed: () {
                      selectedIcon = Icons.hotel; 
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.school),
                    onPressed: () {
                      selectedIcon = Icons.school; 
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.work),
                    onPressed: () {
                      selectedIcon = Icons.work; 
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.self_improvement),
                    onPressed: () {
                      selectedIcon = Icons.self_improvement; 
                    },
                  ),
                ],
              ),
              Text('Escolha uma cor:'),
              Wrap(
                spacing: 8.0,
                children: [
                  IconButton(
                    icon: Icon(Icons.circle, color: Color(0xFFfc284f)),
                    onPressed: () {
                      selectedColor = Color(0xFFfc284f);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.circle, color: Colors.green),
                    onPressed: () {
                      selectedColor = Colors.green;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.circle, color: Colors.blue),
                    onPressed: () {
                      selectedColor = Colors.blue;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.circle, color: Color(0xFFff824a)),
                    onPressed: () {
                      selectedColor = Color(0xFFff824a);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.circle, color: Color(0xFFfea887)),
                    onPressed: () {
                      selectedColor = Color(0xFFfea887);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.circle, color: Color(0xFFf6e7f7)),
                    onPressed: () {
                      selectedColor = Color(0xFFf6e7f7);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.circle, color: Color(0xFFD1D0D7)),
                    onPressed: () {
                      selectedColor = Color(0xFFD1D0D7);
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  habit.icon = selectedIcon ?? habit.icon;
                  habit.color = selectedColor ?? habit.color;
                });
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Hábitos'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                String habitName = habits.keys.elementAt(index);
                Habit habit = habits[habitName]!;
                double completionPercentage = _calculateCompletionPercentage(habitName);
                return Card(
                  color: habit.color,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(habit.icon),
                        title: Text(habitName),
                        subtitle: Text('${completionPercentage.toStringAsFixed(0)}% Concluído'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                _isExpanded[habitName] == true ? Icons.expand_less : Icons.expand_more,
                              ),
                              onPressed: () => _toggleExpansion(habitName),
                            ),
                            IconButton(
                              icon: Icon(Icons.settings, color: Colors.black),
                              onPressed: () => _showCustomizeHabitDialog(habitName),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteHabit(habitName);
                              },
                            ),
                          ],
                        ),
                      ),
                      if (_isExpanded[habitName] == true) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ...habit.tasks.map((task) {
                                return CheckboxListTile(
                                  title: Text(task.name),
                                  value: task.completed,
                                  onChanged: (value) {
                                    _toggleTask(habitName, task);
                                  },
                                );
                              }).toList(),
                              TextButton(
                                onPressed: () => _showAddTaskDialog(habitName),
                                child: Text('Adicionar Tarefa'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Progresso Total'),
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 10.0,
                    percent: _calculateTotalCompletionPercentage() / 100,
                    center: Text('${_calculateTotalCompletionPercentage().toStringAsFixed(0)}%'),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Habit {
  IconData icon;
  Color color;
  List<Task> tasks;

  Habit({required this.icon, required this.color, required this.tasks});
}

class Task {
  String name;
  bool completed;

  Task({required this.name, this.completed = false});
}