import 'package:flutter/material.dart';

import 'widgets/page_acceuil.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,//POUR ENLEVER LA BARRE ROUGE
      home: PageAcceuil(),
    ),
  );
}
