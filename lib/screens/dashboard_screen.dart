import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class DashboardScreen extends StatefulWidget {
  final Map<String, dynamic>? activePlan;

  const DashboardScreen({
    super.key,
    this.activePlan,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int moisture = 45;
  int temp = 24;
  int light = 450;
  bool isUvOn = false;

  String _getPlantImage(String? plantName) {
    if (plantName == null) {
      return 'assets/plants/default_plant.png';
    }

    final name = plantName.toLowerCase();

    if (name.contains('монстер') || name.contains('monstera')) {
      return 'assets/plants/monstera.png';
    }

    if (name.contains('орхидея') || name.contains('orchid')) {
      return 'assets/plants/orchid.png';
    }

    if (name.contains('микрозелень') || name.contains('microgreen')) {
      return 'assets/plants/microgreens.png';
    }

    if (name.contains('кофе') || name.contains('coffee')) {
      return 'assets/plants/coffee.png';
    }

    return 'assets/plants/default_plant.png';
  }

  @override
  void initState() {
    super.initState();
    _listenToSensors();
  }

  void _listenToSensors() {
    FirebaseDatabase.instance.ref('sensors').onValue.listen((event) {
      final data = event.snapshot.value as Map?;

      if (data != null && mounted) {
        setState(() {
          moisture = (data['moisture'] ?? 45) as int;
          temp = (data['temp'] ?? 24) as int;
          light = (data['light'] ?? 450) as int;
        });
      }
    });

    FirebaseDatabase.instance.ref('isUvLampOn').onValue.listen((event) {
      if (mounted) {
        setState(() {
          isUvOn = (event.snapshot.value ?? false) as bool;
        });
      }
    });
  }

  @override
Widget build(BuildContext context) {
  final plan = widget.activePlan;
  final plantImage = _getPlantImage(plan?['plant']);

  final double screenWidth = MediaQuery.of(context).size.width;
  final double smartAspectRatio = screenWidth < 600 ? 0.85 : 1.9;

  return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      body: SafeArea(
        child: Stack(
          children: [
            /// BACKGROUND
            Positioned(
              top: -140,
              right: -120,
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF39FF14).withOpacity(0.16),
                ),
              ),
            ),

            Positioned(
              bottom: -180,
              left: -120,
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.cyan.withOpacity(0.12),
                ),
              ),
            ),

            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 120,
                sigmaY: 120,
              ),
              child: Container(
                color: Colors.transparent,
              ),
            ),

            /// CONTENT
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Colors.white,
                                  Color(0xFF39FF14),
                                ],
                              ).createShader(bounds);
                            },
                            child: Text(
                              'Oasis AI',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Autonomous Greenhouse Intelligence',
                            style: GoogleFonts.inter(
                              color: Colors.white54,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFF39FF14).withOpacity(0.35),
                              const Color(0xFF39FF14).withOpacity(0.08),
                            ],
                          ),
                          border: Border.all(
                            color: const Color(0xFF39FF14).withOpacity(0.45),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF39FF14).withOpacity(0.35),
                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.eco,
                          color: Color(0xFF39FF14),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fade(duration: 700.ms)
                      .slideY(begin: -0.2),

                  const SizedBox(height: 28),

                  /// HERO CARD
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      image: DecorationImage(
                        image: AssetImage(plantImage),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF39FF14).withOpacity(0.22),
                          blurRadius: 50,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.88),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.08),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF39FF14),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'AI ACTIVE',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const Spacer(),

                            Text(
                              plan != null
                                  ? (plan['plant'] ?? 'Smart Plant')
                                  : 'No Active Plan',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                height: 1,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              plan != null
                                  ? 'Station operating under AI care protocol'
                                  : 'Generate a premium AI care plan',
                              style: GoogleFonts.inter(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 22),

                            Row(
                              children: [
                                _heroStat(
                                  'Moisture',
                                  '$moisture%',
                                ),
                                const SizedBox(width: 12),
                                _heroStat(
                                  'Temp',
                                  '$temp°C',
                                ),
                                const SizedBox(width: 12),
                                _heroStat(
                                  'Light',
                                  '$light lx',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat())
                      .shimmer(duration: 5.seconds),

                  const SizedBox(height: 34),

                  /// ACTIVE PLAN
                  if (plan != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'AI Care Protocol',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF39FF14).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'LIVE',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF39FF14),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 20,
                          sigmaY: 20,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color:
                                  const Color(0xFF39FF14).withOpacity(0.15),
                            ),
                          ),
                          child: Column(
                            children: [
                              _planTile(
                                Icons.water_drop,
                                'Watering',
                                '${plan['watering_times_per_day']}x daily',
                                Colors.blue,
                              ),
                              const SizedBox(height: 14),
                              _planTile(
                                Icons.wb_sunny,
                                'UV Cycle',
                                '${plan['uv_lamp_hours']} hours',
                                Colors.yellow,
                              ),
                              const SizedBox(height: 14),
                              _planTile(
                                Icons.opacity,
                                'Humidity',
                                '${plan['target_moisture_min']} - ${plan['target_moisture_max']}%',
                                Colors.cyan,
                              ),
                              const SizedBox(height: 14),
                              _planTile(
                                Icons.thermostat,
                                'Temperature',
                                '${plan['target_temp_min']}° - ${plan['target_temp_max']}°',
                                Colors.orange,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),
                  ],

                  /// LIVE SENSORS
                  Text(
                    'Live Sensors',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 18),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: smartAspectRatio,
                    children: [
                      PremiumSensorCard(
                        title: 'Moisture',
                        value: '$moisture%',
                        subtitle: 'Optimal zone',
                        icon: Icons.water_drop,
                        color: Colors.blue,
                      ),
                      PremiumSensorCard(
                        title: 'Temperature',
                        value: '$temp°C',
                        subtitle: 'Stable',
                        icon: Icons.thermostat,
                        color: Colors.orange,
                      ),
                      PremiumSensorCard(
                        title: 'Light',
                        value: '$light lx',
                        subtitle: 'Photosynthesis',
                        icon: Icons.sunny,
                        color: Colors.yellow,
                      ),
                      PremiumSensorCard(
                        title: 'UV Lamp',
                        value: isUvOn ? 'ONLINE' : 'OFFLINE',
                        subtitle: 'Artificial sun',
                        icon: Icons.wb_twilight,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroStat(String label, String value) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            child: Column(
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _planTile(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.14),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumSensorCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const PremiumSensorCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 24,
          sigmaY: 24,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.045),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.10),
                blurRadius: 25,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          color.withOpacity(0.30),
                          color.withOpacity(0.08),
                        ],
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 28,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.8),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: 700.ms)
        .moveY(begin: 35);
  }
}