class TourMenu {
  final int id_wisata;
  final String nama_tempat;
  final String lokasi_tempat;
  final String image;
  final String biaya;
  

  TourMenu({
    required this.id_wisata,
    required this.nama_tempat,
    required this.lokasi_tempat,
    required this.image,
    required this.biaya,
    
  });

  factory TourMenu.fromJson(Map<String, dynamic> json) {
    return TourMenu(
      id_wisata: json['id_wisata'],
      nama_tempat: json['nama_tempat'],
      lokasi_tempat: json['lokasi_tempat'],
      image: json['image'],
      biaya: json['biaya'],
      
    );
  }
}
