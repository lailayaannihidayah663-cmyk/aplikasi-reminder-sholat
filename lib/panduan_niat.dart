import 'package:flutter/material.dart';

class PanduanNiatPage extends StatelessWidget{
  final Color bgLight;
  final Color bgBase;
  final Color textColor;

  const PanduanNiatPage({
    required this.bgLight,
    required this.bgBase,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> niatlist = [
      {
        'sholat': 'Subuh',
        'arab'  : 'أُصَلِّى فَرْضَ الصُّبْح رَكَعتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى',
        'latin' : 'Ushalli fardash subhi rak\'ataini mustaqbilal qiblati adaa\'an lillahi ta\'ala',
        'arti'  :'Aku niat sholat fardhu Subuh dua rakaat menghadap kiblat karena Allah Ta\'ala',
      },
      {
        'sholat': 'Dzuhur',
        'arab'  : 'اُصَلِّيْ فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى',
        'latin' : 'Ushalli fardhadh dhuhri arba\'a raka\'atin mustaqbilal qiblati adaa\'an lillahi ta\'ala',
        'arti'  :'Aku niat sholat fardhu Dzuhur empat rakaat menghadap kiblat karena Allah Ta\'ala',
      },
      {
        'sholat': 'Ashar',
        'arab'  : 'أُصَلِّى فَرْضَ العَصْرِأَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى',
        'latin' : 'Ushalli fardhal \'ashri arba\'a raka\'atin mustaqbilal qiblati adaa\'an lillahi ta\'ala',
        'arti'  :'Aku niat sholat fardhu Ashar empat rakaat menghadap kiblat karena Allah Ta\'ala',
      },
      {
        'sholat': 'Maghrib',
        'arab'  : 'أُصَلِّى فَرْضَ المَغْرِبِ ثَلاَثَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَ',
        'latin' : 'Ushalli fardhal maghribi tsalatsa raka\'atin mustaqbilal qiblati adaa\'an lillahi ta\'ala',
        'arti'  :'Aku niat sholat fardhu Maghrib tiga  rakaat menghadap kiblat karena Allah Ta\'ala',
      },
      {
        'sholat': 'Isya',
        'arab'  : 'أُصَلِّى فَرْضَ العِشَاء ِأَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى',
        'latin' : 'Ushalli fardhal \'isya\'i arba\'a raka\'atin mustaqbilal qiblati adaa\'an lillahi ta\'ala',
        'arti'  :'Aku niat sholat fardhu isya empat rakaat menghadap kiblat karena Allah Ta\'ala',
      },
    ];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgLight, bgBase],
          ),

        ),

        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, color: textColor),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Panduan Niat Sholat',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: niatlist.length,
                  itemBuilder: (context, index){
                    final niat = niatlist[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Sholat ${niat['sholat']}',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  niat['arab']!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    height: 2,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  niat['latin']!,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  niat['arti']!,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            ],

           ),
        ),
      ),
    );
  }  
  
}