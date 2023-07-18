import 'package:flutter/material.dart';

enum DrawerItems {
  categories('Categories'),
  archive('Archive');
//  themes('Themes');

  const DrawerItems(this.type);
  final String type;
}

const drawerIcons = [
  Icons.category_sharp,
  Icons.archive,
  // Icons.topic,
];
