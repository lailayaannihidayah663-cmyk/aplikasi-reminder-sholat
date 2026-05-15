import 'package:flutter_notification/flutter_local_notification.dart';
import 'package:adhan/adhan.dart';

class NotificationService {
  static final FlutterLocalNotificationPlugin _notifications =
    FlutterLocalNotificationPlugin();
  
  static Future<void>init() async{
    const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,  
    );
    await _notifications.initialize(settings);
  }

  static Future<void> schedulePrayerNotifications(
      PrayerTimes prayerTimes) async {
    final prayers = {
      'Subuh': prayerTimes.fajr,
      'Dzuhur': prayerTimes.dhuhr,
      'Ashar': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isya': prayerTimes.isha,
    };

    int id = 0;
    prayers.forEach((name,time) async{
      if (time.isAfter(DataTime.now())) {
        await _notifications.zonedSchedule(
          id++,
          'Waktu Sholat $name',
          'Sudah masuk waktu sholat $name',
          time as dynamic,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'prayer_channel',
              'Jadwal Sholat',
              importance: importance.high,
              priority: Priority.high,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation.absoluteTime,
        );
      }
    });

  }
  
    
}