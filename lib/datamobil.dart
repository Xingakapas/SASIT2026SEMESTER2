

class DataMobil {
  final int id;
  final String merk;
  final String model;
  final String harga; 
  final String warna;
  final int tahun;

  DataMobil({
    required this.id,
    required this.merk,
    required this.model,
    required this.harga,
    required this.warna,
    required this.tahun,
  });

  factory DataMobil.fromJson(Map<String, dynamic> json) {

    String hargaDollar = json['price'] ?? '\$0';
    

    String hargaRupiah = _convertDollarKeRupiah(hargaDollar);

    return DataMobil(
      id: json['id'] ?? 0,
      merk: json['car'] ?? 'Tanpa Merk',
      model: json['car_model'] ?? 'Tanpa Model',
      harga: hargaRupiah,
      warna: json['car_color'] ?? 'N/A',
      tahun: json['car_model_year'] ?? 2000,
    );
  }

 
  static String _convertDollarKeRupiah(String dollarStr) {
    try {
      String cleanStr = dollarStr.replaceAll('\$', '').replaceAll(' ', '');
      double angkaDollar = double.parse(cleanStr);
      
      
      int totalRupiah = (angkaDollar * 16000).round();
      

      String strRupiah = totalRupiah.toString();
      StringBuffer buffer = StringBuffer();
      int posisi = 0;
      
      for (int i = strRupiah.length - 1; i >= 0; i--) {
        buffer.write(strRupiah[i]);
        posisi++;
        if (posisi == 3 && i != 0) {
          buffer.write('.');
          posisi = 0;
        }
      }
      return 'Rp ' + buffer.toString().split('').reversed.join('');
    } catch (e) {
      return 'Rp 150.000.000'; 
    }
  }
}