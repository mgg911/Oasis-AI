import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_ai/services/ai_service.dart';

import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_FIREBASE_API_KEY",
      authDomain: "YOUR_AUTH_DOMAIN",
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "YOUR_PROJECT_ID",
      databaseURL: "YOUR_DATABASE_URL",
      storageBucket: "YOUR_STORAGE_BUCKET",
      measurementId: "YOUR_MEASUREMENT_ID",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oasis AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070B14),
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  Map<String, dynamic>? _activePlan;

  void _onPlanCreated(Map<String, dynamic> plan) {
    setState(() {
      _activePlan = plan;
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Stack(
        children: [

          /// BACKGROUND
          Positioned(
            top: -140,
            right: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF39FF14)
                    .withOpacity(0.12),
              ),
            ),
          ),

          Positioned(
            bottom: -160,
            left: -120,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.10),
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

          /// SCREENS
          IndexedStack(
            index: _selectedIndex,
            children: [
              DashboardScreen(
                activePlan: _activePlan,
              ),
              AIScreen(
                onPlanCreated: _onPlanCreated,
              ),
              const HistoryScreen(),
            ],
          ),
        ],
      ),

      /// PREMIUM NAVBAR
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              height: 82,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF39FF14)
                        .withOpacity(0.08),
                    blurRadius: 30,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },

                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,

                selectedItemColor: const Color(0xFF39FF14),
                unselectedItemColor: Colors.white38,

                selectedLabelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),

                unselectedLabelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),

                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view_rounded),
                    label: 'Мониторинг',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.auto_awesome),
                    label: 'Oasis AI',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history_rounded),
                    label: 'История',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AIScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onPlanCreated;

  const AIScreen({
    super.key,
    required this.onPlanCreated,
  });

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _plantController =
      TextEditingController();

  String _status = '';

  bool _isLoading = false;

  Map<String, dynamic>? _lastPlan;

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _plantController.dispose();
    super.dispose();
  }

  void _generatePlan() async {
    final plantName = _plantController.text.trim();

    if (plantName.isEmpty) return;

    setState(() {
      _isLoading = true;
      _status = '';
      _lastPlan = null;
    });

    final plan =
        await AIService.generateCarePlan(plantName);

    setState(() {
      _isLoading = false;

      if (plan != null) {
        _lastPlan = plan;
        _status =
            plan['summary'] ?? 'План создан успешно.';
      } else {
        _status =
            'Не удалось создать план. Попробуйте ещё раз.';
      }
    });
  }

  void _activatePlan() {
    if (_lastPlan != null) {
      widget.onPlanCreated(_lastPlan!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            '✅ План активирован',
          ),
          backgroundColor:
              const Color(0xFF39FF14).withOpacity(0.9),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
  }

  Widget _glassContainer({
    required Widget child,
    EdgeInsets? padding,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          padding: padding ??
              const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 140,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                /// HEADER
                Text(
                  'Oasis AI',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'AI Care Generator',
                  style: GoogleFonts.inter(
                    color: Colors.white54,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF39FF14)
                        .withOpacity(0.08),
                    borderRadius:
                        BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFF39FF14)
                          .withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    'NEURAL GREENHOUSE ENGINE',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF39FF14),
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 42),

                /// AI ORB
                Center(
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFF39FF14)
                                  .withOpacity(0.35),
                              const Color(0xFF39FF14)
                                  .withOpacity(0.05),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF39FF14)
                                  .withOpacity(
                                0.25 +
                                    _pulseController
                                            .value *
                                        0.3,
                              ),
                              blurRadius:
                                  50 +
                                      _pulseController
                                              .value *
                                          40,
                              spreadRadius: 4,
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.blur_on_rounded,
                          color: Color(0xFF39FF14),
                          size: 90,
                        ),
                      );
                    },
                  ),
                )
                    .animate()
                    .fade(duration: 800.ms)
                    .scale(),

                const SizedBox(height: 42),

                /// INPUT
                _glassContainer(
                  padding: EdgeInsets.zero,
                  child: TextField(
                    controller: _plantController,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Введите растение...',
                      hintStyle:
                          GoogleFonts.inter(
                        color: Colors.white38,
                      ),
                      prefixIcon: const Icon(
                        Icons.eco,
                        color: Color(0xFF39FF14),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// RESULT
                _glassContainer(
                  child: SizedBox(
                    width: double.infinity,
                    child: _isLoading
                        ? Column(
                            children: [
                              const SizedBox(
                                  height: 20),
                              const CircularProgressIndicator(
                                color:
                                    Color(0xFF39FF14),
                              ),
                              const SizedBox(
                                  height: 24),
                              Text(
                                'AI анализирует растение...',
                                style:
                                    GoogleFonts.inter(
                                  color:
                                      Colors.white70,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [

                              if (_lastPlan != null)
                                ...[
                                  Text(
                                    'AI CARE PLAN',
                                    style:
                                        GoogleFonts.inter(
                                      color:
                                          const Color(
                                              0xFF39FF14),
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      letterSpacing:
                                          1.2,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 18),

                                  _planTile(
                                    Icons.water_drop,
                                    Colors.blue,
                                    'Полив',
                                    '${_lastPlan!['watering_times_per_day']}x в день',
                                  ),

                                  const SizedBox(
                                      height: 14),

                                  _planTile(
                                    Icons.sunny,
                                    Colors.yellow,
                                    'УФ-лампа',
                                    '${_lastPlan!['uv_lamp_hours']} часов',
                                  ),

                                  const SizedBox(
                                      height: 14),

                                  _planTile(
                                    Icons.opacity,
                                    Colors.cyan,
                                    'Влажность',
                                    '${_lastPlan!['target_moisture_min']}% - ${_lastPlan!['target_moisture_max']}%',
                                  ),

                                  const SizedBox(
                                      height: 14),

                                  _planTile(
                                    Icons.thermostat,
                                    Colors.orange,
                                    'Температура',
                                    '${_lastPlan!['target_temp_min']}° - ${_lastPlan!['target_temp_max']}°',
                                  ),

                                  const SizedBox(
                                      height: 24),
                                ],

                              Text(
                                _status.isEmpty
                                    ? 'Введите растение и создайте AI план ухода.'
                                    : _status,
                                style:
                                    GoogleFonts.inter(
                                  color:
                                      Colors.white70,
                                  height: 1.7,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                /// BUTTONS
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed:
                        _isLoading
                            ? null
                            : _generatePlan,
                    icon: const Icon(
                      Icons.auto_awesome,
                    ),
                    label: Text(
                      'Создать план ухода',
                      style: GoogleFonts.inter(
                        fontWeight:
                            FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF39FF14),
                      foregroundColor:
                          Colors.black,
                      elevation: 20,
                      shadowColor:
                          const Color(0xFF39FF14)
                              .withOpacity(0.4),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),
                    ),
                  ),
                ),

                if (_lastPlan != null) ...[
                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: OutlinedButton.icon(
                      onPressed:
                          _activatePlan,
                      icon: const Icon(
                        Icons.rocket_launch,
                      ),
                      label: Text(
                        'Активировать план',
                        style:
                            GoogleFonts.inter(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                      style:
                          OutlinedButton.styleFrom(
                        foregroundColor:
                            const Color(
                                0xFF39FF14),
                        side: BorderSide(
                          color:
                              const Color(
                                      0xFF39FF14)
                                  .withOpacity(
                                      0.4),
                          width: 1.5,
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      20),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _planTile(
    IconData icon,
    Color color,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius:
                BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}