import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {
        'action': 'Автоматический полив',
        'time': 'Сегодня, 14:20',
        'details': 'Вылито 150 мл воды',
        'icon': Icons.water_drop,
        'color': Colors.blue,
      },
      {
        'action': 'Включение УФ-лампы',
        'time': 'Вчера, 18:00',
        'details': 'Работа 2 часа по плану AI',
        'icon': Icons.wb_sunny,
        'color': Colors.yellow,
      },
      {
        'action': 'AI создал план',
        'time': 'Вчера, 17:55',
        'details': 'Новый план ухода активирован',
        'icon': Icons.auto_awesome,
        'color': Color(0xFF39FF14),
      },
      {
        'action': 'Критический показатель',
        'time': '15 мая, 08:45',
        'details': 'Влажность упала ниже 35%',
        'icon': Icons.warning_amber,
        'color': Colors.red,
      },
      {
        'action': 'Экстренный полив',
        'time': '15 мая, 08:46',
        'details': 'Вылито 200 мл воды',
        'icon': Icons.water_drop,
        'color': Colors.blue,
      },
      {
        'action': 'Температура в норме',
        'time': '14 мая, 12:00',
        'details': 'Показатель стабилизировался 23°C',
        'icon': Icons.thermostat,
        'color': Colors.orange,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E17),
      body: SafeArea(
        child: Stack(
          children: [
            // Фоновые свечения
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF39FF14).withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -80,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.07),
                ),
              ),
            ),

            // Контент
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Заголовок
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('История',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                              )),
                          Text('Журнал действий станции',
                              style: GoogleFonts.inter(
                                color: Colors.white54,
                                fontSize: 14,
                              )),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.1)),
                            ),
                            child: Text(
                              '${events.length} событий',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF39FF14),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fade(duration: 600.ms).slideY(begin: -0.2),

                  const SizedBox(height: 28),

                  // Список событий
                  Expanded(
                    child: ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        final color = event['color'] as Color;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: color.withOpacity(0.2)),
                                ),
                                child: Row(
                                  children: [
                                    // Иконка
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color.withOpacity(0.15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: color.withOpacity(0.3),
                                            blurRadius: 16,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        event['icon'] as IconData,
                                        color: color,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Текст
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event['action'] as String,
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            event['details'] as String,
                                            style: GoogleFonts.inter(
                                              color: Colors.white54,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Время
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: color.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            event['time'] as String,
                                            style: GoogleFonts.inter(
                                              color: color,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fade(duration: 500.ms, delay: (index * 80).ms)
                            .slideX(begin: 0.3);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}