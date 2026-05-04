import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BackgroundSageAesthetic(),
  ));
}
class BackgroundSageAesthetic extends StatefulWidget {
  @override
  State<BackgroundSageAesthetic> createState() => _BackgroundSageAestheticState();
}

class _BackgroundSageAestheticState extends State<BackgroundSageAesthetic> {
  static const Color sageBase = Color(0xFFA7BEAE);
   static const Color sageLight = Color(0xFFE0E7E2);
   static const Color textColor = Color(0xFF55A7D6);

   PrayerTimes? _prayerTimes;
   bool _isLoading = true;
   String _erroMsg = '';

   @override
   void initState(){
    super.initState();
    _loadPrayerTimes();
   }

   Future<void> _loadPrayerTimes() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Izin lokasi ditolak permanen');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.shafi;
      final date = DateComponents.from(DateTime.now());

      setState(() {
        _prayerTimes = PrayerTimes(coordinates, date, params);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _erroMsg = 'Gagal: $e';
        _isLoading = false; 
      });
    }
   }

   String _formatTime(DateTime? time){
    if (time ==null) return '--:--';
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
   }
   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [sageLight,sageBase],
          ),   
        ),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -100,
              child: CircleAvatar(
                radius: 200,
                backgroundColor: Colors.white.withOpacity(0.15),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
            ),
            SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    const Text(
                      "Reminder Sholat",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "(Mualaf Friendly)",
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),

                    _isLoading? const CircularProgressIndicator(color: textColor): _erroMsg.isNotEmpty? Text( _erroMsg,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center): _buildJadwalCard(),

                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
   }

   Widget _buildJadwalCard() {
    final sholat =[
      {'nama': 'Imsak', 'waktu': _formatTime(_prayerTimes?.fajr.subtract(const Duration(minutes: 10)))},
      {'nama': 'Subuh', 'waktu': _formatTime(_prayerTimes?.fajr)},
      {'nama': 'Dzuhur', 'waktu': _formatTime(_prayerTimes?.dhuhr)},
      {'nama': 'Ashar', 'waktu': _formatTime(_prayerTimes?.asr)},
      {'nama': 'Maghrib', 'waktu': _formatTime(_prayerTimes?.maghrib)},
      {'nama': 'Isya', 'waktu': _formatTime(_prayerTimes?.isha)},
    ];
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Jadwal Sholat Hari ini",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: textColor, thickness: 0.5),
          const SizedBox(height: 8),
          ...sholat.map((s) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(s['nama']!,
                  style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  )),
                Text(s['waktu']!,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 15,
                  )),
              ],

            )), 
          ),
        ],
      ),
    );
   }

}