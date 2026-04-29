import 'package:flutter/material.dart';
import 'package:mvvm_app/res/color.dart';
import 'package:mvvm_app/res/components/custom_text_field.dart';
import 'package:mvvm_app/res/components/round_button.dart';
import 'package:mvvm_app/viewModel/task_view_model.dart';
import 'package:mvvm_app/viewModel/user_View_Model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // token নিয়ে tasks load করো
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<UserViewModel>(context, listen: false)
          .getUser()
          .then((user) {
        Provider.of<TaskViewModel>(context, listen: false)
            .getTasks(user.token ?? "", context);
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _titleFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  // Task add করার dialog
  void _showAddTaskDialog(String token) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Add New Task",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: _titleController,
                  focusNode: _titleFocus,
                  label: "Title",
                  hint: "Enter task title",
                  prefixIcon: Icons.title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter title";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _descController,
                  focusNode: _descFocus,
                  label: "Description",
                  hint: "Enter task description",
                  prefixIcon: Icons.description_outlined,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _titleController.clear();
                _descController.clear();
                Navigator.pop(context);
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            RoundButton(
              title: "Create",
              onPress: () {
                if (_formKey.currentState!.validate()) {
                  final data = {
                    "title": _titleController.text.trim(),
                    "description": _descController.text.trim(),
                  };
                  Provider.of<TaskViewModel>(context, listen: false)
                      .createTask(data, token, context);
                  _titleController.clear();
                  _descController.clear();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskViewModel, UserViewModel>(
      builder: (context, taskVM, userVM, child) {
        return FutureBuilder(
          future: userVM.getUser(),
          builder: (context, snapshot) {
            final token = snapshot.data?.token ?? "";

            // Loading State=============================================
            if (taskVM.loading) {
              return ListView.builder(
                itemCount: 6,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              );
            }

            // Empty State===================================================
            if (taskVM.tasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_alt, size: 80, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      "No tasks yet!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tap + to add a new task",
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                    ),
                    const SizedBox(height: 24),
                    FloatingActionButton(
                      onPressed: () => _showAddTaskDialog(token),
                      backgroundColor: Colors.blueGrey,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              );
            }

            // Task List======================================================
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: taskVM.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskVM.tasks[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: task.isCompleted == true
                              ? Colors.green.shade100
                              : Colors.blueGrey.shade100,
                          child: Icon(
                            task.isCompleted == true
                                ? Icons.check
                                : Icons.pending_outlined,
                            color: task.isCompleted == true
                                ? Colors.green
                                : Colors.blueGrey,
                          ),
                        ),
                        title: Text(
                          task.title ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: task.isCompleted == true
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted == true
                                ? Colors.grey
                                : Colors.black87,
                          ),
                        ),
                        subtitle: task.description != null &&
                            task.description!.isNotEmpty
                            ? Text(
                          task.description!,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Complete button
                            if (task.isCompleted == false)
                              IconButton(
                                onPressed: () {
                                  taskVM.completeTask(
                                      task.id!, token, context);
                                },
                                icon: const Icon(Icons.check_circle_outline,
                                    color: Colors.green),
                              ),
                            // Delete button
                            IconButton(
                              onPressed: () {
                                taskVM.deleteTask(task.id!, token, context);
                              },
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // FAB Button==========================================
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () => _showAddTaskDialog(token),
                    backgroundColor: Colors.blueGrey,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}