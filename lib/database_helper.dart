

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'datamobil.dart';

class DatabaseHelper {
  static List<DataMobil> _lokalDatabase = [];

  Future<List<DataMobil>> getMobil() async {
    if (_lokalDatabase.isNotEmpty) {
      return _lokalDatabase;
    }

    try {
     
      final response = await http
          .get(Uri.parse('https://myfakeapi.com/api/cars/'))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List listMobil = data['cars'] ?? [];
    
        _lokalDatabase = listMobil
            .take(20)
            .map((json) => DataMobil.fromJson(json))
            .toList();
            
        return _lokalDatabase;
      } else {
        throw Exception('Gagal muat API');
      }
    } catch (e) {

      print('Koneksi web terganggu ($e). Memakai data cadangan Rupiah...');
      return [
        DataMobil(id: 1, merk: 'Toyota', model: 'Avanza Veloz', harga: 'Rp 235.000.000', warna: 'Hitam', tahun: 2022),
        DataMobil(id: 2, merk: 'Honda', model: 'Civic Turbo', harga: 'Rp 510.000.000', warna: 'Putih', tahun: 2023),
        DataMobil(id: 3, merk: 'BMW', model: 'M3 Series', harga: 'Rp 1.450.000.000', warna: 'Abu-abu', tahun: 2021),
        DataMobil(id: 4, merk: 'Mercedes', model: 'C-Class 200', harga: 'Rp 980.000.000', warna: 'Hitam', tahun: 2023),
        DataMobil(id: 5, merk: 'Mitsubishi', model: 'Xpander Cross', harga: 'Rp 310.000.000', warna: 'Putih', tahun: 2022),
        DataMobil(id: 6, merk: 'Suzuki', model: 'Ertiga Hybrid', harga: 'Rp 270.000.000', warna: 'Perak', tahun: 2023),
      ];
    }
  }
}