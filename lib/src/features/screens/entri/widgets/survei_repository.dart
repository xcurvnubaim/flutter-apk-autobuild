import 'package:welangflood/src/features/screens/entri/widgets/data_survei.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveiRepository {
  static const String _namaKey = 'nama';
  static const String _tanggalKey = 'tanggal';
  static const String _tinggiKey = 'tinggi';
  static const String _fotoKey = 'foto';
  static const String _lokasiKey = 'lokasi';

  static Future<void> simpanSurvei(Survei survei) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_namaKey, survei.namaLengkap);
    await prefs.setString(_tanggalKey, survei.tanggal.toString());
    await prefs.setDouble(_tinggiKey, survei.tinggiGenangan);
    await prefs.setString(_fotoKey, survei.fotoPath);
    await prefs.setString(_lokasiKey, survei.lokasi);
  }

  static Future<Survei?> bacaSurvei() async {
    final prefs = await SharedPreferences.getInstance();
    final namaLengkap = prefs.getString(_namaKey);
    final tanggalString = prefs.getString(_tanggalKey);
    final tanggal = tanggalString != null ? DateTime.parse(tanggalString) : null;
    final tinggiGenangan = prefs.getDouble(_tinggiKey);
    final fotoPath = prefs.getString(_fotoKey);
    final lokasi = prefs.getString(_lokasiKey);

    if (namaLengkap != null &&
        tanggal != null &&
        tinggiGenangan != null &&
        fotoPath != null &&
        lokasi != null) {
      return Survei(
        namaLengkap: namaLengkap,
        tanggal: tanggal,
        tinggiGenangan: tinggiGenangan,
        fotoPath: fotoPath,
        lokasi: lokasi,
      );
    } else {
      return null;
    }
  }
}
