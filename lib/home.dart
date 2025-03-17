import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/home_provider.dart';
import 'package:todo/util/dialogbox.dart';
import 'package:todo/util/todo_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).initializeData();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller:
              Provider.of<HomeProvider>(context, listen: false).controller,
          onSave: () {
            Provider.of<HomeProvider>(context, listen: false).saveNewTask();
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Todo')),
        actions: [
          InkWell(
            onTap: () async {},
            child: const Icon(
              Icons.picture_as_pdf,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
        ],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return provider.toDoList.isEmpty
              ? const Center(
                  child: Text(
                    "no items",
                    style: TextStyle(fontSize: 30, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: provider.toDoList.length,
                  itemBuilder: (context, index) {
                    final task = provider.toDoList[index];
                    return TodoTile(
                      taskName: task[0],
                      taskCompleted: task[1],
                      isPriority: task.length > 2 ? task[2] : false,
                      onChanged: (val) => provider.checkBoxChanged(val, index),
                      deleteFunction: (context) => provider.deleteTask(index),
                      onEdit: () => _showEditDialog(context, index, task[0]),
                      onPriorityToggle: () => provider.togglePriority(index),
                    );
                  },
                );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index, String currentText) {
    final TextEditingController editController =
        TextEditingController(text: currentText);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(hintText: 'Edit your task'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false)
                  .editTask(index, editController.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
