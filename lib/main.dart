

import 'package:flutter/material.dart';
import 'tampilanhome.dart'; // Memanggil nama file baru lu

void main() {
  runApp(const AplikasiJualMobil());
}

class AplikasiJualMobil extends StatelessWidget {
  const AplikasiJualMobil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi jualan Mobil',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const TampilanHome(), 
    );
  }
}