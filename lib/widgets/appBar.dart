import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/widgets/theme_provider.dart';// Import your ThemeProvider class
AppBar buildAppBar(BuildContext context) {
  return AppBar(

    title: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.checklist,

          size: 30,
        ),
        Text("To Do List",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)
      ],
    ),
    actions: [
      IconButton(
        icon: Icon(
          Provider.of<ThemeProvider>(context).isDarkMode
              ? Icons.light_mode
              : Icons.dark_mode,
        ),
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
      ),
    ],
  );
}

