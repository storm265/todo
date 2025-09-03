import 'package:flutter/material.dart';

enum CategoryItems {
  categories('Categories'),
  archive('Archive'),
  settings('Settings');

  const CategoryItems(this.type);
  final String type;
}

const drawerIcons = [
  Icons.category_sharp,
  Icons.archive,
  Icons.settings,
];
