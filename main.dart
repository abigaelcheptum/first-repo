import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

// ═══════════════════════════════════════════════════════════════════════════
//  HOW TO ADD YOUR BACKGROUND IMAGE
//  ─────────────────────────────────────────────────────────────────────────
//  1. Create the folder  assets/images/  inside your Flutter project root.
//  2. Copy your image file there, e.g.  assets/images/farm_bg.jpg
//  3. Open pubspec.yaml and add (under the "flutter:" key):
//
//       flutter:
//         assets:
//           - assets/images/farm_bg.jpg
//
//  4. Run:  flutter pub get
// ═══════════════════════════════════════════════════════════════════════════
const String kBackgroundImagePath = 'assets/images/background.jpg'; 

// ═══════════════════════════════════════════════════════════════════════════
//  CONTACT LINKS  — replace every value below with your own
// ═══════════════════════════════════════════════════════════════════════════
const String kWhatsAppUrl  = 'https://wa.me/254727553334';              // ← YOUR WHATSAPP
const String kFacebookUrl  = 'https://facebook.com/YOUR_PAGE';          // ← YOUR FACEBOOK
const String kLinkedInUrl  = 'https://linkedin.com/in/YOUR_PROFILE';    // ← YOUR LINKEDIN
const String kTwitterUrl   = 'https://twitter.com/YOUR_HANDLE';         // ← YOUR TWITTER
const String kPhoneUrl     = 'tel:+254727553334';                       // ← YOUR PHONE (tel: prefix)
const String kPhoneDisplay = '+254 727 553 334';                        // ← DISPLAY TEXT
const String kEmailDisplay = 'hello@mshambadirect.co.ke';               // ← YOUR EMAIL
const String kAddress      = 'Karatina, Nyeri County, Kenya';           // ← YOUR ADDRESS

// ═══════════════════════════════════════════════════════════════════════════
//  TO MAKE LINKS ACTUALLY OPEN IN THE BROWSER / DIALER:
//  1. Add to pubspec.yaml:   url_launcher: ^6.2.5
//  2. Run:  flutter pub get
//  3. Add at the very top of this file:
//       import 'package:url_launcher/url_launcher.dart';
//  4. In _ContactIconButton._launch(), replace the SnackBar call with:
//       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
// ═══════════════════════════════════════════════════════════════════════════

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MShambaDirectApp());
}

// ===== DESIGN TOKENS =====
class AppColors {
  static const Color forestDeep    = Color(0xFF0D2818);
  static const Color forestMid     = Color(0xFF1A4A2E);
  static const Color forestLight   = Color(0xFF2D6A4F);
  static const Color leafGreen     = Color(0xFF52B788);
  static const Color mintFresh     = Color(0xFF95D5B2);
  static const Color creamWhite    = Color(0xFFF8F5EE);
  static const Color warmBeige     = Color(0xFFEDE8DC);
  static const Color goldenHarvest = Color(0xFFE9C46A);
  static const Color terracotta    = Color(0xFFE76F51);
  static const Color skyBlue       = Color(0xFF4A90D9);
  static const Color darkText      = Color(0xFF1C1C1E);
  static const Color mutedText     = Color(0xFF6B7280);
  static const Color cardWhite     = Color(0xFFFFFFFF);
  static const Color divider       = Color(0xFFE5E7EB);
}

class AppTextStyles {
  static const String fontDisplay = 'Georgia';
  static const String fontBody    = 'Georgia';

  static const TextStyle heroTitle = TextStyle(
    fontFamily: fontDisplay, fontSize: 44, fontWeight: FontWeight.w700,
    color: AppColors.forestDeep, height: 1.15, letterSpacing: -1.0,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontDisplay, fontSize: 28, fontWeight: FontWeight.w700,
    color: AppColors.forestDeep, height: 1.2, letterSpacing: -0.5,
  );
  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontDisplay, fontSize: 18, fontWeight: FontWeight.w600,
    color: AppColors.darkText, height: 1.3,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16, color: AppColors.mutedText, height: 1.6,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 13, color: AppColors.mutedText, height: 1.5,
  );
  static const TextStyle labelBold = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w700,
    letterSpacing: 1.5, color: AppColors.forestLight,
  );
}

// ===== MAIN APP =====
class MShambaDirectApp extends StatelessWidget {
  const MShambaDirectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M-Shamba Direct',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.creamWhite,
        primaryColor: AppColors.forestLight,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.forestLight, background: AppColors.creamWhite,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.forestLight, foregroundColor: Colors.white,
            elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.2),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.divider)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.divider)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.forestLight, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.terracotta)),
          labelStyle: const TextStyle(color: AppColors.mutedText),
        ),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

// ===== AUTH WRAPPER =====
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthService.isLoggedIn,
      builder: (context, isLoggedIn, child) =>
          isLoggedIn ? const MainAppScreen() : const LandingScreen(),
    );
  }
}

// ===== AUTH SERVICE =====
class AuthService {
  static ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);
  static Map<String, String> currentUser = {};

  static Future<bool> login(String phone, String password) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (phone.isNotEmpty && password.length >= 6) {
      currentUser = {'phone': phone, 'name': 'John Mwangi', 'type': 'farmer', 'farmLocation': 'Karatina, Nyeri'};
      isLoggedIn.value = true;
      return true;
    }
    return false;
  }

  static Future<bool> signup(Map<String, String> userData) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (userData['phone']!.isNotEmpty && userData['password']!.length >= 6) {
      currentUser = userData;
      isLoggedIn.value = true;
      return true;
    }
    return false;
  }

  static void logout() { currentUser.clear(); isLoggedIn.value = false; }
}

// ===== ORGANIC BACKGROUND PAINTER =====
class OrganicBackgroundPainter extends CustomPainter {
  final double animValue;
  OrganicBackgroundPainter({this.animValue = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rect  = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment.topRight, end: Alignment.bottomLeft,
      colors: [
        const Color(0xFF52B788).withOpacity(0.15),
        const Color(0xFFF8F5EE).withOpacity(0.0),
        const Color(0xFFE9C46A).withOpacity(0.10),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));

    paint.color = const Color(0xFF52B788).withOpacity(0.22);
    final path1 = Path();
    path1.moveTo(size.width * 0.55, -30);
    path1.cubicTo(size.width * 1.15, -10, size.width * 1.1, size.height * 0.4, size.width * 0.82, size.height * 0.32);
    path1.cubicTo(size.width * 0.58, size.height * 0.24, size.width * 0.48, size.height * 0.08, size.width * 0.55, -30);
    canvas.drawPath(path1, paint);

    paint.color = const Color(0xFFE9C46A).withOpacity(0.18);
    final path2 = Path();
    path2.moveTo(-20, size.height * 0.65);
    path2.cubicTo(size.width * 0.18, size.height * 0.55, size.width * 0.35, size.height * 0.78, size.width * 0.22, size.height * 0.95);
    path2.cubicTo(size.width * 0.08, size.height * 1.08, -0.1, size.height * 0.92, -20, size.height * 0.65);
    canvas.drawPath(path2, paint);

    paint.color = const Color(0xFFE76F51).withOpacity(0.08);
    final path3 = Path();
    path3.moveTo(-10, size.height * 0.3);
    path3.cubicTo(size.width * 0.12, size.height * 0.22, size.width * 0.2, size.height * 0.38, size.width * 0.1, size.height * 0.48);
    path3.cubicTo(size.width * 0.02, size.height * 0.56, -0.08, size.height * 0.44, -10, size.height * 0.3);
    canvas.drawPath(path3, paint);

    final linePaint = Paint()
      ..color = const Color(0xFF2D6A4F).withOpacity(0.05)
      ..strokeWidth = 1.0 ..style = PaintingStyle.stroke;
    for (int i = -5; i < 20; i++) {
      final x = i * size.width * 0.08;
      canvas.drawLine(Offset(x, 0), Offset(x + size.height * 0.6, size.height), linePaint);
    }

    paint.color = const Color(0xFF2D6A4F).withOpacity(0.07);
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 6; j++) {
        canvas.drawCircle(Offset(size.width * 0.65 + i * 28.0, size.height * 0.55 + j * 28.0), 2.0, paint);
      }
    }

    paint.color = const Color(0xFF52B788).withOpacity(0.10);
    void drawLeaf(double cx, double cy, double r, double angle) {
      final path = Path();
      final cos  = math.cos(angle);
      final sin  = math.sin(angle);
      path.moveTo(cx, cy);
      path.cubicTo(cx + cos * r - sin * r * 0.4, cy + sin * r + cos * r * 0.4,
          cx + cos * r * 1.8 - sin * r * 0.2, cy + sin * r * 1.8 + cos * r * 0.2, cx + cos * r * 2, cy + sin * r * 2);
      path.cubicTo(cx + cos * r * 1.8 + sin * r * 0.2, cy + sin * r * 1.8 - cos * r * 0.2,
          cx + cos * r + sin * r * 0.4, cy + sin * r - cos * r * 0.4, cx, cy);
      canvas.drawPath(path, paint);
    }
    drawLeaf(size.width * 0.88, size.height * 0.12, 22, -0.6);
    drawLeaf(size.width * 0.08, size.height * 0.85, 18, 1.2);
    drawLeaf(size.width * 0.75, size.height * 0.72, 14, 0.3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
//  SOCIAL ICON PAINTER  — draws brand icons using SVG paths (no emoji)
// ═══════════════════════════════════════════════════════════════════════════
class SocialIconPainter extends CustomPainter {
  final SocialIconType type;
  final Color color;
  const SocialIconPainter({required this.type, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final s = size.width;

    switch (type) {
      case SocialIconType.whatsapp:
        // Rounded speech bubble with phone handset
        final bubblePaint = Paint()..color = color..style = PaintingStyle.fill;
        // Outer circle (filled)
        canvas.drawCircle(Offset(s / 2, s / 2), s * 0.44, bubblePaint);
        // Inner phone shape (white cutout)
        final phonePaint = Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = s * 0.09..strokeCap = StrokeCap.round;
        final phonePath = Path();
        phonePath.moveTo(s * 0.33, s * 0.28);
        phonePath.cubicTo(s * 0.28, s * 0.38, s * 0.26, s * 0.46, s * 0.36, s * 0.57);
        phonePath.cubicTo(s * 0.46, s * 0.68, s * 0.56, s * 0.70, s * 0.66, s * 0.65);
        canvas.drawPath(phonePath, phonePaint);
        // Tail
        final tailPath = Path();
        tailPath.moveTo(s * 0.25, s * 0.82);
        tailPath.lineTo(s * 0.32, s * 0.65);
        tailPath.lineTo(s * 0.42, s * 0.72);
        canvas.drawPath(tailPath, Paint()..color = color..style = PaintingStyle.fill);
        break;

      case SocialIconType.facebook:
        // Blue rounded square with 'f'
        final bgPaint = Paint()..color = color..style = PaintingStyle.fill;
        final bgRect  = RRect.fromRectAndRadius(Rect.fromLTWH(s * 0.06, s * 0.06, s * 0.88, s * 0.88), Radius.circular(s * 0.18));
        canvas.drawRRect(bgRect, bgPaint);
        // 'f' letterform in white
        final fPaint = Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = s * 0.12..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round;
        // vertical stem
        canvas.drawLine(Offset(s * 0.55, s * 0.28), Offset(s * 0.55, s * 0.80), fPaint);
        // crossbar
        canvas.drawLine(Offset(s * 0.38, s * 0.54), Offset(s * 0.68, s * 0.54), fPaint);
        // top curve
        final curvePaint = Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = s * 0.12..strokeCap = StrokeCap.round;
        final curvePath = Path();
        curvePath.moveTo(s * 0.55, s * 0.28);
        curvePath.cubicTo(s * 0.55, s * 0.22, s * 0.58, s * 0.18, s * 0.65, s * 0.18);
        canvas.drawPath(curvePath, curvePaint);
        break;

      case SocialIconType.linkedin:
        // Blue rounded square with 'in'
        final bgPaint2 = Paint()..color = color..style = PaintingStyle.fill;
        final bgRect2  = RRect.fromRectAndRadius(Rect.fromLTWH(s * 0.06, s * 0.06, s * 0.88, s * 0.88), Radius.circular(s * 0.18));
        canvas.drawRRect(bgRect2, bgPaint2);
        final linPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
        // Dot
        canvas.drawCircle(Offset(s * 0.31, s * 0.31), s * 0.07, linPaint);
        // Left vertical bar
        canvas.drawRect(Rect.fromLTWH(s * 0.25, s * 0.42, s * 0.12, s * 0.38), linPaint);
        // Right vertical bar
        canvas.drawRect(Rect.fromLTWH(s * 0.50, s * 0.42, s * 0.12, s * 0.38), linPaint);
        // Right horizontal connector
        canvas.drawRect(Rect.fromLTWH(s * 0.50, s * 0.42, s * 0.25, s * 0.12), linPaint);
        // Right curve top
        final arcPath = Path();
        arcPath.moveTo(s * 0.50, s * 0.42);
        arcPath.cubicTo(s * 0.50, s * 0.36, s * 0.58, s * 0.34, s * 0.64, s * 0.42);
        canvas.drawPath(arcPath, Paint()..color = Colors.white..style = PaintingStyle.stroke..strokeWidth = s * 0.12..strokeCap = StrokeCap.round);
        break;

      case SocialIconType.twitter:
        // X (formerly Twitter) bird / X mark
        final xPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = s * 0.13
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(Offset(s * 0.18, s * 0.18), Offset(s * 0.82, s * 0.82), xPaint);
        canvas.drawLine(Offset(s * 0.82, s * 0.18), Offset(s * 0.18, s * 0.82), xPaint);
        break;

      case SocialIconType.phone:
        // Phone handset icon
        final pPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = s * 0.12
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
        final phonePath2 = Path();
        // handset body
        phonePath2.moveTo(s * 0.25, s * 0.20);
        phonePath2.cubicTo(s * 0.22, s * 0.30, s * 0.22, s * 0.38, s * 0.30, s * 0.48);
        phonePath2.cubicTo(s * 0.40, s * 0.62, s * 0.52, s * 0.72, s * 0.65, s * 0.76);
        phonePath2.cubicTo(s * 0.74, s * 0.80, s * 0.80, s * 0.76, s * 0.82, s * 0.70);
        phonePath2.lineTo(s * 0.70, s * 0.56);
        canvas.drawPath(phonePath2, pPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant SocialIconPainter oldDelegate) =>
      oldDelegate.type != type || oldDelegate.color != color;
}

enum SocialIconType { whatsapp, facebook, linkedin, twitter, phone }

// ===== LANDING SCREEN =====
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _floatController;
  late Animation<double>  _fadeAnim;
  late Animation<Offset>  _slideAnim;
  late Animation<double>  _floatAnim;
  bool _showAuthModal = false;
  bool _isLoginMode   = true;

  @override
  void initState() {
    super.initState();
    _heroController  = AnimationController(duration: const Duration(milliseconds: 900), vsync: this);
    _floatController = AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat(reverse: true);
    _fadeAnim  = CurvedAnimation(parent: _heroController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _heroController, curve: Curves.easeOutCubic));
    _floatAnim = Tween<double>(begin: -6.0, end: 6.0)
        .animate(CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));
    _heroController.forward();
  }

  @override
  void dispose() { _heroController.dispose(); _floatController.dispose(); super.dispose(); }

  void _openAuth({bool login = true}) =>
      setState(() { _isLoginMode = login; _showAuthModal = true; });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: Stack(
        children: [
          // ─────────────────────────────────────────────────────────────
          //  BACKGROUND IMAGE
          //  • Change  kBackgroundImagePath  at the top of this file.
          //  • See the HOW TO ADD YOUR BACKGROUND IMAGE comment above.
          // ─────────────────────────────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              kBackgroundImagePath,
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.82),
              colorBlendMode: BlendMode.lighten,
              errorBuilder: (_, __, ___) => Container(color: AppColors.creamWhite),
            ),
          ),
          CustomPaint(
            painter: OrganicBackgroundPainter(),
            size: MediaQuery.of(context).size,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildNavBar(),
                _buildHeroSection(),
                _buildStatsStrip(),
                _buildSolutionsSection(),
                _buildImpactSection(),
                _buildTestimonialsSection(),
                _buildCtaSection(),
                _buildContactsSection(),
                _buildFooter(),
              ],
            ),
          ),
          if (_showAuthModal)
            GestureDetector(
              onTap: () => setState(() => _showAuthModal = false),
              child: Container(
                color: Colors.black.withOpacity(0.45),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: AuthModal(
                      initialLogin: _isLoginMode,
                      onClose: () => setState(() => _showAuthModal = false),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── NAV BAR ──────────────────────────────────────────────────────────────
  Widget _buildNavBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 24, right: 24,
        top: MediaQuery.of(context).padding.top + 12, bottom: 12,
      ),
      child: Row(
        children: [
          Row(children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(color: AppColors.forestDeep, borderRadius: BorderRadius.circular(10)),
              child: const Center(child: Text('🌿', style: TextStyle(fontSize: 20))),
            ),
            const SizedBox(width: 10),
            const Text('M-Shamba', style: TextStyle(fontFamily: 'Georgia', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.forestDeep, letterSpacing: -0.3)),
            const Text(' Direct',  style: TextStyle(fontFamily: 'Georgia', fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.forestLight, letterSpacing: -0.3)),
          ]),
          const Spacer(),
          TextButton(onPressed: () => _openAuth(login: false), child: const Text('Sign Up', style: TextStyle(color: AppColors.mutedText, fontSize: 14))),
          const SizedBox(width: 8),
          _PillButton(label: 'Sign In', onTap: () => _openAuth(login: true), filled: true),
        ],
      ),
    );
  }

  // ── HERO ─────────────────────────────────────────────────────────────────
  Widget _buildHeroSection() {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
          padding: const EdgeInsets.fromLTRB(28, 40, 28, 60),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.forestLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.forestLight.withOpacity(0.25)),
              ),
              child: const Text('✦  From Farm to Fork, Direct',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: AppColors.forestLight)),
            ),
            const SizedBox(height: 28),
            const Text('Kenya\'s Smartest\nAgricultural\nMarketplace', textAlign: TextAlign.center, style: AppTextStyles.heroTitle),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 380),
              child: const Text(
                'Connect directly with buyers, track market prices in real-time, and receive instant M-Pesa payments — all designed for the Kenyan farmer.',
                textAlign: TextAlign.center, style: AppTextStyles.bodyLarge,
              ),
            ),
            const SizedBox(height: 36),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _PillButton(label: '📸  Scan Crop', onTap: () => _openAuth(login: true), filled: true, large: true),
              const SizedBox(width: 12),
              _PillButton(label: 'Start Selling', onTap: () => _openAuth(login: false), filled: false, large: true),
            ]),
            const SizedBox(height: 48),
            AnimatedBuilder(
              animation: _floatAnim,
              builder: (context, child) => Transform.translate(offset: Offset(0, _floatAnim.value), child: child),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: AppColors.forestLight.withOpacity(0.12), blurRadius: 32, offset: const Offset(0, 12))],
                ),
                child: Row(children: [
                  _HeroStatChip(emoji: '🌾', value: '150K+', label: 'Farmers'),
                  Container(width: 1, height: 40, color: AppColors.divider),
                  _HeroStatChip(emoji: '🗺️', value: '8', label: 'Counties'),
                  Container(width: 1, height: 40, color: AppColors.divider),
                  _HeroStatChip(emoji: '🎯', value: '97%', label: 'AI Accuracy'),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // ── STATS STRIP ───────────────────────────────────────────────────────────
  Widget _buildStatsStrip() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(color: AppColors.forestDeep, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _DarkStat(value: 'KES 500M', label: 'GMV Target Y1'),
          _DarkStat(value: '40%',      label: 'Loss Reduction'),
          _DarkStat(value: '5 min',    label: 'Payment Time'),
        ],
      ),
    );
  }

  // ── SOLUTIONS ─────────────────────────────────────────────────────────────
  Widget _buildSolutionsSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 64),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('OUR SOLUTIONS', style: AppTextStyles.labelBold),
        const SizedBox(height: 12),
        const Text('Everything a farmer\nneeds, in one app', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 32),
        _SolutionCard(icon: '🔬', accent: AppColors.leafGreen,     tag: 'AI DIAGNOSIS', title: 'Plant Health\nDiagnosis',
            description: '97% accurate disease detection for 23 common crops in just 2.5 seconds. Works even offline.',
            chips: ['23 crop diseases', '2.5 sec scan', 'Offline ready'], onTap: () => _openAuth(login: true)),
        const SizedBox(height: 16),
        _SolutionCard(icon: '📈', accent: AppColors.goldenHarvest, tag: 'PRICE AI',    title: 'Market Price\nPredictions',
            description: 'Know prices 3 months ahead. 92% accuracy across 27 crops and 42 local markets.',
            chips: ['3-month forecast', '42 markets', 'Weekly alerts'], onTap: () => _openAuth(login: true)),
        const SizedBox(height: 16),
        _SolutionCard(icon: '🚚', accent: AppColors.skyBlue,       tag: 'LOGISTICS',   title: 'Smart Delivery\nNetwork',
            description: 'GPS-tracked drivers, route optimization, and M-Pesa escrow payments for safe trading.',
            chips: ['Live tracking', 'M-Pesa escrow', 'Verified drivers'], onTap: () => _openAuth(login: true)),
      ]),
    );
  }

  // ── IMPACT ────────────────────────────────────────────────────────────────
  Widget _buildImpactSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(color: AppColors.forestDeep, borderRadius: BorderRadius.circular(28)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('WHY IT MATTERS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.5, color: AppColors.mintFresh)),
        const SizedBox(height: 12),
        const Text('Real impact\nfor real farmers',
            style: TextStyle(fontFamily: 'Georgia', fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2, letterSpacing: -0.5)),
        const SizedBox(height: 28),
        GridView.count(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.15,
          children: const [
            _ImpactTile(emoji: '💰', stat: '50%',    label: 'More income\nfor farmers'),
            _ImpactTile(emoji: '🥬', stat: '40%',    label: 'Less post-\nharvest loss'),
            _ImpactTile(emoji: '⚡', stat: '<5 min', label: 'M-Pesa\npayment time'),
            _ImpactTile(emoji: '🤖', stat: '287K+',  label: 'African crop\nimages trained'),
          ],
        ),
      ]),
    );
  }

  // ── TESTIMONIALS ──────────────────────────────────────────────────────────
  Widget _buildTestimonialsSection() {
    return Column(children: [
      const SizedBox(height: 64),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('TESTIMONIALS', style: AppTextStyles.labelBold),
          SizedBox(height: 12),
          Text('Trusted by farmers\nacross Africa', style: AppTextStyles.sectionTitle),
        ]),
      ),
      const SizedBox(height: 28),
      SizedBox(height: 220, child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: const [
          _TestimonialCard(name: 'Nala W.',    role: 'Tomato Farmer, Tanzania',    quote: 'Saved 78% of my harvest from blight. M-Shamba detected it before it could spread.', avatar: '👩🏾‍🌾'),
          _TestimonialCard(name: 'Emmanuel K.', role: 'Maize Farmer, Kenya',       quote: 'Waited for M-Shamba\'s predicted price peak. Made 42% more profit that season.',     avatar: '👨🏿‍🌾'),
          _TestimonialCard(name: 'Grace M.',   role: 'Cooperative Leader, Uganda', quote: 'Our 120-farmer co-op earns 37% more together using M-Shamba market predictions.',    avatar: '👩🏽‍💼'),
        ],
      )),
      const SizedBox(height: 64),
    ]);
  }

  // ── CTA ───────────────────────────────────────────────────────────────────
  Widget _buildCtaSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [AppColors.forestLight, AppColors.forestDeep]),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(children: [
        const Text('🌱', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 16),
        const Text('Ready to grow\nyour income?', textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Georgia', fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, height: 1.2)),
        const SizedBox(height: 12),
        const Text('Join 150,000+ farmers already on M-Shamba Direct', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _openAuth(login: false),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.forestDeep,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            child: const Text('Get Started Free', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Starting at KES 350/month', style: TextStyle(color: Colors.white54, fontSize: 12)),
      ]),
    );
  }

  // ── CONTACTS SECTION ──────────────────────────────────────────────────────
  Widget _buildContactsSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 40, 24, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
        boxShadow: [BoxShadow(color: AppColors.forestLight.withOpacity(0.08), blurRadius: 24, offset: const Offset(0, 8))],
      ),
      child: Column(children: [

        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: const BoxDecoration(
            color: AppColors.forestDeep,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: const Column(children: [
            Text('CONTACTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2.0, color: AppColors.mintFresh)),
            SizedBox(height: 3),
            Text('Reach us on any platform', style: TextStyle(fontSize: 12, color: Colors.white54)),
          ]),
        ),

        // Social icon buttons — real SVG icons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ContactIconButton(
                iconType: SocialIconType.whatsapp,
                label: 'WhatsApp',
                color: const Color(0xFF25D366),
                url: kWhatsAppUrl,   // ← defined at top of file
              ),
              _ContactIconButton(
                iconType: SocialIconType.facebook,
                label: 'Facebook',
                color: const Color(0xFF1877F2),
                url: kFacebookUrl,   // ← defined at top of file
              ),
              _ContactIconButton(
                iconType: SocialIconType.linkedin,
                label: 'LinkedIn',
                color: const Color(0xFF0A66C2),
                url: kLinkedInUrl,   // ← defined at top of file
              ),
              _ContactIconButton(
                iconType: SocialIconType.twitter,
                label: 'X / Twitter',
                color: const Color(0xFF000000),
                url: kTwitterUrl,    // ← defined at top of file
              ),
              _ContactIconButton(
                iconType: SocialIconType.phone,
                label: 'Call',
                color: AppColors.terracotta,
                url: kPhoneUrl,      // ← defined at top of file
              ),
            ],
          ),
        ),

        const Divider(height: 1, color: AppColors.divider),

        // Contact detail rows
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            _ContactDetailRow(icon: Icons.phone_outlined,    label: 'Phone / WhatsApp', value: kPhoneDisplay),
            const SizedBox(height: 12),
            _ContactDetailRow(icon: Icons.email_outlined,    label: 'Email',            value: kEmailDisplay),
            const SizedBox(height: 12),
            _ContactDetailRow(icon: Icons.location_on_outlined, label: 'Address',       value: kAddress),
          ]),
        ),

      ]),
    );
  }

  // ── FOOTER ────────────────────────────────────────────────────────────────
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.only(top: 32),
      child: Column(children: [
        const Text('M-Shamba Direct',
            style: TextStyle(fontFamily: 'Georgia', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.forestDeep)),
        const SizedBox(height: 8),
        const Text('Powering African agriculture with AI', style: TextStyle(color: AppColors.mutedText, fontSize: 13)),
        const SizedBox(height: 24),
        const Text('© 2026 M-Shamba Direct. All rights reserved.', style: TextStyle(color: AppColors.mutedText, fontSize: 12)),
        const SizedBox(height: 8),
        const Text('Designed by ABBY TOGAN  •  +254 727 553 334', style: TextStyle(color: AppColors.mutedText, fontSize: 11)),
      ]),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// CONTACTS HELPER WIDGETS
// ═════════════════════════════════════════════════════════════════════════════

/// Tappable social icon with a proper SVG-painted brand icon.
///
/// To make URLs actually open, see the HOW TO comment at the top of the file.
class _ContactIconButton extends StatelessWidget {
  final SocialIconType iconType;
  final String         label;
  final Color          color;
  final String         url;

  const _ContactIconButton({
    required this.iconType, required this.label,
    required this.color,    required this.url,
  });

  void _launch(BuildContext context) {
    // ─── REPLACE the SnackBar below with launchUrl() once url_launcher is added ───
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: $url'),
        backgroundColor: AppColors.forestLight,
        duration: const Duration(seconds: 2),
      ),
    );
    // launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication); // ← UNCOMMENT
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launch(context),
      child: Column(children: [
        Container(
          width: 54, height: 54,
          decoration: BoxDecoration(
            color: color.withOpacity(0.10), shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.35), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: CustomPaint(
              size: const Size(28, 28),
              painter: SocialIconPainter(type: iconType, color: color),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
        ),
      ]),
    );
  }
}

/// A labelled contact detail row (phone / email / address).
class _ContactDetailRow extends StatelessWidget {
  final IconData icon;
  final String   label;
  final String   value;
  const _ContactDetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(color: AppColors.forestLight.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: 18, color: AppColors.forestLight),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
        Text(value,  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.darkText)),
      ])),
    ]);
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// REUSABLE LANDING WIDGETS
// ═════════════════════════════════════════════════════════════════════════════

class _PillButton extends StatelessWidget {
  final String   label;
  final VoidCallback onTap;
  final bool     filled;
  final bool     large;
  const _PillButton({required this.label, required this.onTap, this.filled = true, this.large = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: large ? 22 : 18, vertical: large ? 14 : 10),
        decoration: BoxDecoration(
          color: filled ? AppColors.forestDeep : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: filled ? null : Border.all(color: AppColors.forestLight.withOpacity(0.4), width: 1.5),
        ),
        child: Text(label, style: TextStyle(fontSize: large ? 15 : 13, fontWeight: FontWeight.w600,
            color: filled ? Colors.white : AppColors.forestDeep, letterSpacing: 0.1)),
      ),
    );
  }
}

class _HeroStatChip extends StatelessWidget {
  final String emoji, value, label;
  const _HeroStatChip({required this.emoji, required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Expanded(child: Column(children: [
    Text(emoji, style: const TextStyle(fontSize: 22)),
    const SizedBox(height: 4),
    Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.forestDeep)),
    Text(label, style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
  ]));
}

class _DarkStat extends StatelessWidget {
  final String value, label;
  const _DarkStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(fontFamily: 'Georgia', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.mintFresh)),
    const SizedBox(height: 2),
    Text(label, style: const TextStyle(fontSize: 11, color: Colors.white54)),
  ]);
}

class _SolutionCard extends StatelessWidget {
  final String icon, tag, title, description;
  final Color accent;
  final List<String> chips;
  final VoidCallback onTap;
  const _SolutionCard({required this.icon, required this.accent, required this.tag,
      required this.title, required this.description, required this.chips, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
          boxShadow: [BoxShadow(color: accent.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 6))],
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 52, height: 52,
              decoration: BoxDecoration(color: accent.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
              child: Center(child: Text(icon, style: const TextStyle(fontSize: 24)))),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(tag, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.3, color: accent)),
            const SizedBox(height: 4),
            Text(title, style: AppTextStyles.cardTitle),
            const SizedBox(height: 8),
            Text(description, style: AppTextStyles.bodySmall),
            const SizedBox(height: 12),
            Wrap(spacing: 6, runSpacing: 6,
              children: chips.map((c) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: accent.withOpacity(0.1), borderRadius: BorderRadius.circular(100)),
                child: Text(c, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: accent.withOpacity(0.85))),
              )).toList(),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _ImpactTile extends StatelessWidget {
  final String emoji, stat, label;
  const _ImpactTile({required this.emoji, required this.stat, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 26)),
        const Spacer(),
        Text(stat, style: const TextStyle(fontFamily: 'Georgia', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.mintFresh)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white60, height: 1.4)),
      ]),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String name, role, quote, avatar;
  const _TestimonialCard({required this.name, required this.role, required this.quote, required this.avatar});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, margin: const EdgeInsets.only(right: 16), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.star, color: AppColors.goldenHarvest, size: 14),
          Icon(Icons.star, color: AppColors.goldenHarvest, size: 14),
          Icon(Icons.star, color: AppColors.goldenHarvest, size: 14),
          Icon(Icons.star, color: AppColors.goldenHarvest, size: 14),
          Icon(Icons.star, color: AppColors.goldenHarvest, size: 14),
        ]),
        const SizedBox(height: 12),
        Text('"$quote"', style: const TextStyle(fontSize: 13, color: AppColors.darkText, height: 1.55, fontStyle: FontStyle.italic)),
        const Spacer(),
        Row(children: [
          Text(avatar, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.darkText)),
            Text(role, style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
          ]),
        ]),
      ]),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// AUTH MODAL
// ═════════════════════════════════════════════════════════════════════════════
class AuthModal extends StatefulWidget {
  final bool initialLogin;
  final VoidCallback onClose;
  const AuthModal({super.key, this.initialLogin = true, required this.onClose});
  @override
  State<AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<AuthModal> {
  late bool _isLogin;
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _selectedUserType = 'farmer';
  String _error = '';

  final _phoneController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController     = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() { super.initState(); _isLogin = widget.initialLogin; }

  @override
  void dispose() {
    _phoneController.dispose(); _passwordController.dispose();
    _nameController.dispose();  _locationController.dispose();
    super.dispose();
  }

  String? _validatePhone(String phone) {
    if (phone.isEmpty) return 'Phone number is required';
    final clean = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (clean.length < 10) return 'Enter a valid Kenyan number (e.g., 0712345678)';
    return null;
  }

  void _submit() async {
    final phoneErr = _validatePhone(_phoneController.text);
    if (phoneErr != null) { setState(() => _error = phoneErr); return; }
    if (_passwordController.text.length < 6) { setState(() => _error = 'Password must be at least 6 characters'); return; }
    if (!_isLogin && _nameController.text.isEmpty) { setState(() => _error = 'Please enter your full name'); return; }
    setState(() { _isLoading = true; _error = ''; });

    bool success;
    if (_isLogin) {
      success = await AuthService.login(_phoneController.text, _passwordController.text);
    } else {
      success = await AuthService.signup({
        'phone': _phoneController.text, 'password': _passwordController.text,
        'name': _nameController.text,   'type': _selectedUserType,
        'farmLocation': _locationController.text,
      });
    }

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) widget.onClose();
      else setState(() => _error = 'Authentication failed. Please check your details.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      constraints: const BoxConstraints(maxWidth: 440, maxHeight: 700),
      decoration: BoxDecoration(
        color: AppColors.creamWhite, borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 16))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            color: AppColors.forestDeep,
            child: Row(children: [
              const Text('🌿', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_isLogin ? 'Welcome back' : 'Join M-Shamba',
                    style: const TextStyle(fontFamily: 'Georgia', fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                Text(_isLogin ? 'Sign in to your farm account' : 'Create your free account',
                    style: const TextStyle(fontSize: 12, color: Colors.white60)),
              ]),
              const Spacer(),
              GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), shape: BoxShape.circle),
                  child: const Icon(Icons.close, color: Colors.white70, size: 18),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              if (_error.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.terracotta.withOpacity(0.1), borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.terracotta.withOpacity(0.3)),
                  ),
                  child: Row(children: [
                    const Icon(Icons.error_outline, color: AppColors.terracotta, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_error, style: const TextStyle(color: AppColors.terracotta, fontSize: 13))),
                  ]),
                ),
                const SizedBox(height: 16),
              ],
              if (!_isLogin) ...[
                const Align(alignment: Alignment.centerLeft, child: Text('I am joining as:', style: AppTextStyles.bodySmall)),
                const SizedBox(height: 8),
                Row(children: [
                  _UserTypeChip(type: 'farmer', emoji: '👨🏿‍🌾', label: 'Farmer', selected: _selectedUserType == 'farmer', onTap: () => setState(() => _selectedUserType = 'farmer')),
                  const SizedBox(width: 8),
                  _UserTypeChip(type: 'buyer',  emoji: '🏪',     label: 'Buyer',  selected: _selectedUserType == 'buyer',  onTap: () => setState(() => _selectedUserType = 'buyer')),
                  const SizedBox(width: 8),
                  _UserTypeChip(type: 'driver', emoji: '🚚',     label: 'Driver', selected: _selectedUserType == 'driver', onTap: () => setState(() => _selectedUserType = 'driver')),
                ]),
                const SizedBox(height: 16),
                TextField(controller: _nameController, textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline, color: AppColors.forestLight))),
                const SizedBox(height: 12),
              ],
              TextField(
                controller: _phoneController, keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(12)],
                decoration: const InputDecoration(labelText: 'Phone Number', hintText: '0712 345 678',
                    prefixIcon: Icon(Icons.phone_outlined, color: AppColors.forestLight)),
              ),
              const SizedBox(height: 12),
              if (!_isLogin && _selectedUserType == 'farmer') ...[
                TextField(controller: _locationController, textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Farm Location', hintText: 'e.g., Karatina, Nyeri',
                        prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.forestLight))),
                const SizedBox(height: 12),
              ],
              TextField(
                controller: _passwordController, obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.forestLight),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.mutedText, size: 20),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.forestDeep,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(_isLogin ? 'Sign In to Farm Account' : 'Create Free Account',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(_isLogin ? "Don't have an account? " : "Already have an account? ",
                    style: const TextStyle(color: AppColors.mutedText, fontSize: 13)),
                GestureDetector(
                  onTap: () => setState(() { _isLogin = !_isLogin; _error = ''; }),
                  child: Text(_isLogin ? 'Sign Up' : 'Sign In',
                      style: const TextStyle(color: AppColors.forestLight, fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ]),
            ]),
          ),
        ])),
      ),
    );
  }
}

class _UserTypeChip extends StatelessWidget {
  final String type, emoji, label;
  final bool selected;
  final VoidCallback onTap;
  const _UserTypeChip({required this.type, required this.emoji, required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.forestLight.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.forestLight : AppColors.divider, width: selected ? 1.5 : 1),
        ),
        child: Column(children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
              color: selected ? AppColors.forestLight : AppColors.mutedText)),
        ]),
      ),
    ));
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// MAIN APP SCREEN (Post-Login)
// ═════════════════════════════════════════════════════════════════════════════
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        children: const [DashboardScreen(), AIDiagnosisScreen(), MarketPriceScreen(), MarketplaceScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: const Border(top: BorderSide(color: AppColors.divider)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, -4))]),
      child: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _NavItem(icon: '🏠', label: 'Home',     index: 0, current: _currentIndex, onTap: _goTo),
          _NavItem(icon: '🔬', label: 'Diagnose', index: 1, current: _currentIndex, onTap: _goTo),
          _NavItem(icon: '📊', label: 'Prices',   index: 2, current: _currentIndex, onTap: _goTo),
          _NavItem(icon: '🏪', label: 'Market',   index: 3, current: _currentIndex, onTap: _goTo),
          _NavItem(icon: '👤', label: 'Profile',  index: 4, current: _currentIndex, onTap: _goTo),
        ]),
      )),
    );
  }

  void _goTo(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
  }
}

class _NavItem extends StatelessWidget {
  final String icon, label;
  final int index, current;
  final Function(int) onTap;
  const _NavItem({required this.icon, required this.label, required this.index, required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.forestLight.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(icon, style: TextStyle(fontSize: isActive ? 22 : 20)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? AppColors.forestLight : AppColors.mutedText)),
        ]),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// DASHBOARD SCREEN
// ═════════════════════════════════════════════════════════════════════════════
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 0, floating: true, backgroundColor: AppColors.creamWhite, elevation: 0,
          title: Row(children: [
            const Text('🌿', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Good morning,', style: TextStyle(fontSize: 12, color: AppColors.mutedText, fontWeight: FontWeight.w400)),
              Text(AuthService.currentUser['name'] ?? 'Farmer',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.forestDeep)),
            ]),
          ]),
          actions: [
            IconButton(
              icon: Container(padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: AppColors.divider)),
                  child: const Icon(Icons.notifications_outlined, color: AppColors.forestDeep, size: 18)),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [AppColors.forestLight, AppColors.forestDeep]),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Farm Health', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 4),
                  const Text('All crops healthy', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(100)),
                    child: const Text('📍 Karatina, Nyeri', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ),
                ])),
                const Text('🌾', style: TextStyle(fontSize: 56)),
              ]),
            ),
            const SizedBox(height: 20),
            Row(children: [
              _StatCard(emoji: '🌱', value: '5',     label: 'Crops',    color: AppColors.leafGreen),
              const SizedBox(width: 10),
              _StatCard(emoji: '📦', value: '3',     label: 'Orders',   color: AppColors.goldenHarvest),
              const SizedBox(width: 10),
              _StatCard(emoji: '💰', value: '12.5K', label: 'KES Saved', color: AppColors.skyBlue),
            ]),
            const SizedBox(height: 28),
            const Text('Quick Actions', style: AppTextStyles.cardTitle),
            const SizedBox(height: 14),
            Row(children: [
              _ActionCard(emoji: '📸', label: 'Scan Crop', sublabel: 'AI Diagnosis',  color: AppColors.leafGreen,     onTap: () {}),
              const SizedBox(width: 10),
              _ActionCard(emoji: '📈', label: 'Prices',    sublabel: 'Market rates',  color: AppColors.goldenHarvest, onTap: () {}),
              const SizedBox(width: 10),
              _ActionCard(emoji: '🏪', label: 'Sell',      sublabel: 'Marketplace',   color: AppColors.terracotta,    onTap: () {}),
            ]),
            const SizedBox(height: 28),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Recent Activity', style: AppTextStyles.cardTitle),
              TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(color: AppColors.forestLight, fontSize: 13))),
            ]),
            const SizedBox(height: 10),
            _ActivityItem(emoji: '🔬', title: 'Diagnosis Complete', subtitle: 'Tomatoes — Healthy ✓', time: '2h ago',    positive: true),
            _ActivityItem(emoji: '📊', title: 'Price Alert',        subtitle: 'Maize +15% in Nairobi', time: 'Yesterday', positive: true),
            _ActivityItem(emoji: '✅', title: 'Order Delivered',    subtitle: 'Fresh Vegetables',      time: '2 days ago', positive: true),
          ]),
        )),
      ]),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String emoji, value, label; final Color color;
  const _StatCard({required this.emoji, required this.value, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
    child: Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 22)),
      const SizedBox(height: 6),
      Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
      Text(label, style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
    ]),
  ));
}

class _ActionCard extends StatelessWidget {
  final String emoji, label, sublabel; final Color color; final VoidCallback onTap;
  const _ActionCard({required this.emoji, required this.label, required this.sublabel, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => Expanded(child: GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 26)),
        const SizedBox(height: 6),
        Text(label,    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        Text(sublabel, style: const TextStyle(fontSize: 10, color: AppColors.mutedText)),
      ]),
    ),
  ));
}

class _ActivityItem extends StatelessWidget {
  final String emoji, title, subtitle, time; final bool positive;
  const _ActivityItem({required this.emoji, required this.title, required this.subtitle, required this.time, this.positive = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
      child: Row(children: [
        Container(width: 42, height: 42,
            decoration: BoxDecoration(color: AppColors.creamWhite, borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20)))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.darkText)),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.mutedText)),
        ])),
        Text(time, style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
      ]),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// AI DIAGNOSIS SCREEN
// ═════════════════════════════════════════════════════════════════════════════
class AIDiagnosisScreen extends StatefulWidget {
  const AIDiagnosisScreen({super.key});
  @override
  State<AIDiagnosisScreen> createState() => _AIDiagnosisScreenState();
}

class _AIDiagnosisScreenState extends State<AIDiagnosisScreen> {
  bool _isAnalyzing = false;
  String? _result;
  String _selectedCrop    = 'Tomato';
  String _selectedSymptom = '';

  final crops = ['Tomato', 'Maize', 'Potato', 'Cassava', 'Bean'];
  final symptoms = {
    'Tomato':  ['Yellow leaves', 'Brown spots', 'Wilting', 'Fruit rot', 'Leaf curl'],
    'Maize':   ['Leaf streaks', 'Stunted growth', 'Ear rot', 'Dead heart', 'Yellowing'],
    'Potato':  ['Leaf blight', 'Tuber rot', 'Yellowing', 'Stem lesions', 'Wilting'],
    'Cassava': ['Mosaic patterns', 'Leaf curl', 'Stunted growth', 'Brown spots'],
    'Bean':    ['Rust spots', 'Yellow leaves', 'Pod rot', 'Leaf holes'],
  };

  void _analyze() async {
    if (_selectedSymptom.isEmpty) return;
    setState(() { _isAnalyzing = true; _result = null; });
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      _isAnalyzing = false;
      _result = (_selectedCrop == 'Tomato' && _selectedSymptom == 'Brown spots') ? 'Early Blight Detected' : 'Crop is Healthy';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      appBar: AppBar(backgroundColor: AppColors.creamWhite, elevation: 0,
          title: const Text('AI Diagnosis', style: TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.w700, color: AppColors.forestDeep))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.leafGreen, AppColors.forestLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(children: const [
              Text('🔬', style: TextStyle(fontSize: 40)),
              SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Plant Health AI', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                Text('97% accuracy · 23 diseases · Works offline', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ])),
            ]),
          ),
          const SizedBox(height: 24),
          const Text('Select Crop', style: AppTextStyles.cardTitle),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8,
            children: crops.map((crop) {
              final active = _selectedCrop == crop;
              return GestureDetector(
                onTap: () => setState(() { _selectedCrop = crop; _selectedSymptom = ''; _result = null; }),
                child: AnimatedContainer(duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.forestLight : Colors.white, borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: active ? AppColors.forestLight : AppColors.divider),
                  ),
                  child: Text(crop, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                      color: active ? Colors.white : AppColors.darkText)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Select Symptom', style: AppTextStyles.cardTitle),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8,
            children: (symptoms[_selectedCrop] ?? []).map((s) {
              final active = _selectedSymptom == s;
              return GestureDetector(
                onTap: () => setState(() { _selectedSymptom = s; _result = null; }),
                child: AnimatedContainer(duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.terracotta.withOpacity(0.1) : Colors.white, borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: active ? AppColors.terracotta : AppColors.divider),
                  ),
                  child: Text(s, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,
                      color: active ? AppColors.terracotta : AppColors.darkText)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: (_isAnalyzing || _selectedSymptom.isEmpty) ? null : _analyze,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.forestDeep),
              child: _isAnalyzing
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Run AI Analysis', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ),
          if (_result != null) ...[
            const SizedBox(height: 24),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: _result!.contains('Healthy') ? AppColors.leafGreen.withOpacity(0.08) : AppColors.terracotta.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _result!.contains('Healthy') ? AppColors.leafGreen.withOpacity(0.3) : AppColors.terracotta.withOpacity(0.3)),
              ),
              child: Column(children: [
                Text(_result!.contains('Healthy') ? '✅' : '⚠️', style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text(_result!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,
                    color: _result!.contains('Healthy') ? AppColors.forestLight : AppColors.terracotta)),
                const SizedBox(height: 8),
                Text(
                  _result!.contains('Healthy')
                      ? 'Your crop looks healthy. Continue regular monitoring and best practices.'
                      : 'Disease detected! Apply copper-based fungicide and remove infected leaves within 24 hours.',
                  textAlign: TextAlign.center, style: const TextStyle(color: AppColors.mutedText, height: 1.5),
                ),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Expert consultation request sent!'), backgroundColor: AppColors.forestLight)),
                    icon: const Icon(Icons.support_agent, size: 16),
                    label: const Text('Consult an Expert'),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.forestLight, side: const BorderSide(color: AppColors.forestLight)),
                  ),
                ),
              ]),
            ),
          ],
        ]),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// MARKET PRICE SCREEN
// ═════════════════════════════════════════════════════════════════════════════
class MarketPriceScreen extends StatefulWidget {
  const MarketPriceScreen({super.key});
  @override
  State<MarketPriceScreen> createState() => _MarketPriceScreenState();
}

class _MarketPriceScreenState extends State<MarketPriceScreen> {
  String _selectedCrop   = 'Tomatoes';
  String _selectedMarket = 'Nairobi';
  Map<String, dynamic>? _data;
  bool _loading = false;

  final crops   = ['Tomatoes', 'Maize', 'Potatoes', 'Onions', 'Cabbage', 'Beans'];
  final markets = ['Nairobi', 'Mombasa', 'Kisumu', 'Nakuru', 'Eldoret', 'Meru'];

  void _fetch() async {
    setState(() { _loading = true; _data = null; });
    await Future.delayed(const Duration(milliseconds: 1000));
    final base = 80 + crops.indexOf(_selectedCrop) * 8;
    setState(() {
      _loading = false;
      _data = {
        'current': base, 'change': '+6.7%',
        'forecast': [
          {'label': 'Month 1', 'price': base + 8,  'up': true},
          {'label': 'Month 2', 'price': base + 14, 'up': true},
          {'label': 'Month 3', 'price': base + 9,  'up': false},
        ],
        'tip': 'Prices expected to peak in Month 2. Hold your harvest for maximum profit.',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      appBar: AppBar(backgroundColor: AppColors.creamWhite, elevation: 0,
          title: const Text('Market Prices', style: TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.w700, color: AppColors.forestDeep))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.goldenHarvest.withOpacity(0.12), borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.goldenHarvest.withOpacity(0.25))),
            child: Row(children: const [
              Text('📈', style: TextStyle(fontSize: 36)),
              SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('AI Price Forecast', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: AppColors.darkText)),
                Text('92% accuracy · 27 crops · 42 markets', style: TextStyle(fontSize: 12, color: AppColors.mutedText)),
              ])),
            ]),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _selectedCrop,
            items: crops.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() { _selectedCrop = v!; _data = null; }),
            decoration: const InputDecoration(labelText: 'Crop', prefixIcon: Icon(Icons.eco_outlined, color: AppColors.forestLight)),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedMarket,
            items: markets.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
            onChanged: (v) => setState(() { _selectedMarket = v!; _data = null; }),
            decoration: const InputDecoration(labelText: 'Market', prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.forestLight)),
          ),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _fetch,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.forestDeep),
              child: _loading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Get Forecast', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ),
          if (_data != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.divider)),
              child: Column(children: [
                const Text('Current Price', style: TextStyle(color: AppColors.mutedText, fontSize: 13)),
                const SizedBox(height: 4),
                Text('KES ${_data!['current']}/kg',
                    style: const TextStyle(fontFamily: 'Georgia', fontSize: 36, fontWeight: FontWeight.w700, color: AppColors.forestDeep)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.leafGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(100)),
                  child: Text('↑ ${_data!['change']} from last week',
                      style: const TextStyle(color: AppColors.leafGreen, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 24),
                const Divider(color: AppColors.divider),
                const SizedBox(height: 16),
                const Align(alignment: Alignment.centerLeft, child: Text('3-Month Forecast', style: AppTextStyles.cardTitle)),
                const SizedBox(height: 14),
                Row(children: (_data!['forecast'] as List).map<Widget>((f) {
                  return Expanded(child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: (f['up'] as bool) ? AppColors.leafGreen.withOpacity(0.08) : AppColors.terracotta.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: (f['up'] as bool) ? AppColors.leafGreen.withOpacity(0.2) : AppColors.terracotta.withOpacity(0.2)),
                    ),
                    child: Column(children: [
                      Text(f['label'], style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
                      const SizedBox(height: 4),
                      Text('KES ${f['price']}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.darkText)),
                      const SizedBox(height: 2),
                      Icon((f['up'] as bool) ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 14, color: (f['up'] as bool) ? AppColors.leafGreen : AppColors.terracotta),
                    ]),
                  ));
                }).toList()),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.skyBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                  child: Row(children: [
                    const Text('💡', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 10),
                    Expanded(child: Text(_data!['tip'], style: const TextStyle(fontSize: 13, color: AppColors.darkText, height: 1.4))),
                  ]),
                ),
                const SizedBox(height: 14),
                SizedBox(width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Price alert set!'), backgroundColor: AppColors.forestLight)),
                    icon: const Icon(Icons.notifications_outlined, size: 16),
                    label: const Text('Set Price Alert'),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.forestLight, side: const BorderSide(color: AppColors.forestLight)),
                  ),
                ),
              ]),
            ),
          ],
        ]),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// MARKETPLACE SCREEN
// ═════════════════════════════════════════════════════════════════════════════
class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final products = [
      {'emoji': '🍅', 'name': 'Fresh Tomatoes',   'price': '80', 'kg': '500',  'farm': 'Kiambu Farm',  'county': 'Kiambu'},
      {'emoji': '🥬', 'name': 'Green Vegetables', 'price': '50', 'kg': '300',  'farm': 'Nyeri Greens', 'county': 'Nyeri'},
      {'emoji': '🥔', 'name': 'Irish Potatoes',   'price': '60', 'kg': '1000', 'farm': 'Nakuru Farm',  'county': 'Nakuru'},
      {'emoji': '🧅', 'name': 'Red Onions',       'price': '90', 'kg': '200',  'farm': 'Isiolo Farm',  'county': 'Isiolo'},
      {'emoji': '🥦', 'name': 'Fresh Cabbage',    'price': '40', 'kg': '400',  'farm': 'Limuru Farm',  'county': 'Kiambu'},
      {'emoji': '🥕', 'name': 'Fresh Carrots',    'price': '70', 'kg': '250',  'farm': 'Kieni Farm',   'county': 'Nyeri'},
    ];
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      appBar: AppBar(backgroundColor: AppColors.creamWhite, elevation: 0,
          title: const Text('Marketplace', style: TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.w700, color: AppColors.forestDeep)),
          actions: [
            IconButton(
              icon: Container(padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: AppColors.divider)),
                  child: const Icon(Icons.shopping_cart_outlined, color: AppColors.forestDeep, size: 18)),
              onPressed: () {},
            ),
          ]),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search produce...',
              prefixIcon: const Icon(Icons.search, color: AppColors.mutedText, size: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: AppColors.divider)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: AppColors.divider)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: AppColors.forestLight)),
            ),
          ),
        ),
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: products.length,
          itemBuilder: (context, i) {
            final p = products[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.divider)),
              child: Row(children: [
                Container(width: 54, height: 54,
                    decoration: BoxDecoration(color: AppColors.creamWhite, borderRadius: BorderRadius.circular(14)),
                    child: Center(child: Text(p['emoji']!, style: const TextStyle(fontSize: 28)))),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(p['name']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.darkText)),
                  const SizedBox(height: 2),
                  Text('${p['kg']} kg available · ${p['farm']}', style: const TextStyle(fontSize: 12, color: AppColors.mutedText)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.forestLight.withOpacity(0.08), borderRadius: BorderRadius.circular(100)),
                    child: Text('📍 ${p['county']}', style: const TextStyle(fontSize: 10, color: AppColors.forestLight, fontWeight: FontWeight.w600)),
                  ),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('KES ${p['price']}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.forestDeep)),
                  const Text('/kg', style: TextStyle(fontSize: 10, color: AppColors.mutedText)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart!'), backgroundColor: AppColors.forestLight)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(color: AppColors.forestDeep, borderRadius: BorderRadius.circular(100)),
                      child: const Text('Buy', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ]),
              ]),
            );
          },
        )),
      ]),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// PROFILE SCREEN
// ═════════════════════════════════════════════════════════════════════════════
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      appBar: AppBar(
        backgroundColor: AppColors.creamWhite, elevation: 0,
        title: const Text('My Profile', style: TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.w700, color: AppColors.forestDeep)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.terracotta, size: 20),
            onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Sign Out', style: TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.w700)),
              content: const Text('Are you sure you want to sign out of your account?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                TextButton(onPressed: () { AuthService.logout(); Navigator.pop(context); },
                    child: const Text('Sign Out', style: TextStyle(color: AppColors.terracotta))),
              ],
            )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: AppColors.divider)),
            child: Column(children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(color: AppColors.forestLight.withOpacity(0.1), shape: BoxShape.circle,
                    border: Border.all(color: AppColors.forestLight.withOpacity(0.3), width: 2)),
                child: const Center(child: Text('👨🏿‍🌾', style: TextStyle(fontSize: 38))),
              ),
              const SizedBox(height: 14),
              Text(AuthService.currentUser['name'] ?? 'Farmer',
                  style: const TextStyle(fontFamily: 'Georgia', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.forestDeep)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: AppColors.forestLight.withOpacity(0.1), borderRadius: BorderRadius.circular(100)),
                child: Text((AuthService.currentUser['type'] ?? 'farmer').toUpperCase(),
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.forestLight, letterSpacing: 1)),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [
                _ProfileStat(value: '24',       label: 'Orders'),
                _ProfileStatDivider(),
                _ProfileStat(value: 'KES 125K', label: 'Total Sales'),
                _ProfileStatDivider(),
                _ProfileStat(value: '4.8 ⭐',  label: 'Rating'),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.divider)),
            child: Column(children: [
              _ProfileRow(emoji: '📞', label: 'Phone',         value: AuthService.currentUser['phone'] ?? kPhoneDisplay),
              const Divider(height: 1, indent: 58, color: AppColors.divider),
              _ProfileRow(emoji: '📍', label: 'Farm Location', value: AuthService.currentUser['farmLocation'] ?? 'Karatina, Nyeri'),
              const Divider(height: 1, indent: 58, color: AppColors.divider),
              _ProfileRow(emoji: '📅', label: 'Member Since',  value: 'January 2024'),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.divider)),
            child: Column(children: [
              _ProfileRow(emoji: '🔔', label: 'Notifications', value: 'Enabled',    showArrow: true),
              const Divider(height: 1, indent: 58, color: AppColors.divider),
              _ProfileRow(emoji: '🔒', label: 'Privacy',       value: '',            showArrow: true),
              const Divider(height: 1, indent: 58, color: AppColors.divider),
              _ProfileRow(emoji: '💬', label: 'Support',       value: kPhoneDisplay, showArrow: true),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value, label;
  const _ProfileStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.forestDeep)),
    Text(label, style: const TextStyle(fontSize: 11, color: AppColors.mutedText)),
  ]);
}

class _ProfileStatDivider extends StatelessWidget {
  const _ProfileStatDivider();
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 32, color: AppColors.divider);
}

class _ProfileRow extends StatelessWidget {
  final String emoji, label, value;
  final bool showArrow;
  const _ProfileRow({required this.emoji, required this.label, required this.value, this.showArrow = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.mutedText)),
          if (value.isNotEmpty) Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkText)),
        ])),
        if (showArrow) const Icon(Icons.chevron_right, color: AppColors.mutedText, size: 18),
      ]),
    );
  }
}