

import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'datamobil.dart';

class TampilanHome extends StatefulWidget {
  const TampilanHome({Key? key}) : super(key: key);

  @override
  State<TampilanHome> createState() => _TampilanHomeState();
}

class _TampilanHomeState extends State<TampilanHome> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<DataMobil>> listMobil;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      listMobil = dbHelper.getMobil();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'MOBILUX SHOWROOM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.0,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadData, // Tombol refresh
          )
        ],
      ),
      body: FutureBuilder<List<DataMobil>>(
        future: listMobil,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('datamobilkosngcik'));
          }

          final data = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              childAspectRatio: 0.78, 
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final mobil = data[index];
              return Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        child: const Icon(
                          Icons.directions_car_filled,
                          size: 55,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Info Detail Mobil
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${mobil.merk} ${mobil.model}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${mobil.tahun} | Seri Warna: ${mobil.warna}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            mobil.harga, 
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}