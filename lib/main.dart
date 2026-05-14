import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'dart:async';
import 'theme_provider.dart';
import 'panduan_niat.dart';
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
  Color get sageBase => _currentTheme.sageBase;
  Color get sageLight => _currentTheme.sageLight;
  Color get textColor => _currentTheme.textColor;
   
   

   PrayerTimes? _prayerTimes;
   bool _isLoading = true;
   String _erroMsg = '';
   String _countdown ='';
   String _nextPrayer = '';
   late Timer _timer;
   AppTheme _currentTheme = appThemes[0];
   

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
      _startCountdown();
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
   void dispose(){
    _timer.cancel();
    super.dispose();
   }

   void _startCountdown(){
    _timer = Timer.periodic(const Duration(seconds: 1), (_){
      if (_prayerTimes == null) return;

      final now = DateTime.now();
      final prayers = {
        'Subuh': _prayerTimes!.fajr,
        'Dzuhur': _prayerTimes!.dhuhr,
        'Ashar': _prayerTimes!.asr,
        'Maghrib': _prayerTimes!.maghrib,
        'Isya': _prayerTimes!.isha,
      };

      DateTime? next;
      String nextName = '';

      for (var entry in prayers.entries){
        if (entry.value.isAfter(now)) {
          next =entry.value;
          nextName =entry.key;
          break;

        }
      }

      if (next != null) {
        final diff = next.difference(now);
        final h = diff.inHours.toString().padLeft(2, '0');
        final m = (diff.inMinutes % 60).toString().padLeft(2, '0');
         final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
         setState(() {
           _countdown = '$h:$m:$s';
           _nextPrayer = nextName;
         });
        

      }

    });
   }
   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
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
                    SizedBox(height: 60),

                     Text(
                      "Reminder Sholat",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "(Mualaf Friendly)",
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: appThemes.map((theme) => GestureDetector(
                          onTap: (){
                            setState ((){
                              _currentTheme = theme;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            padding:  EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                            decoration:  BoxDecoration(
                              color: _currentTheme == theme
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.6),
                                width: 1,
                              ),
                          ),
                          child: Text(
                            theme.name,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 13,
                              fontWeight: _currentTheme == theme
                                ? FontWeight.bold
                                : FontWeight.normal,   
                            ),
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => PanduanNiatPage(
                            bgLight: bgLight,
                             bgBase: bgBase,
                              textColor: textColor
                              ),
                          ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    '📖Panduan Niat Sholat',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),


                    const Spacer(),

                    _isLoading?  CircularProgressIndicator(color: textColor): _erroMsg.isNotEmpty? Text( _erroMsg,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center): _buildJadwalCard(),

                    const Spacer(),
                  ]),
              ),
            ),
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
          Text(
            "Jadwal Sholat Hari ini",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: textColor, thickness: 0.5),
          const SizedBox(height: 8),
          if  (_nextPrayer.isNotEmpty) ...[
            Text(
              'Menuju $_nextPrayer',
              style: TextStyle(
                color: textColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _countdown,
              style:  TextStyle(
                color: textColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: textColor, thickness: 0.5),
            const SizedBox(height: 8),
          ],

          ...sholat.map((s) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(s['nama']!,
                  style:  TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  )),
                Text(s['waktu']!,
                  style:  TextStyle(
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