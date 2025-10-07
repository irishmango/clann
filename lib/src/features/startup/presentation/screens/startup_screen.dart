import 'package:flutter/material.dart';
import 'package:clann/src/features/root_screen/presentation/screens/root_screen.dart';

// Startup screen: shows phrase card. User swipes LEFT to jump to RootScreen.
// No horizontal slide of RootScreen – instead a fade transition on successful swipe.
class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  void _goToApp() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 750),
        pageBuilder: (_, __, ___) => const RootScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuad,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: _PhraseIntroPage(onSwipeLeft: _goToApp));
}

class _PhraseIntroPage extends StatelessWidget {
  final VoidCallback onSwipeLeft;
  const _PhraseIntroPage({required this.onSwipeLeft});

  @override
  Widget build(BuildContext context) {
    // Colors chosen to approximate provided mock.
    const green = Color(0xFF3F755C);
    return GestureDetector(
      // Detect a completed left swipe (negative primary velocity).
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null &&
            details.primaryVelocity! < -250) {
          onSwipeLeft();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20.0),
        color: green,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32),
                const Text(' ', style: TextStyle(color: Colors.white)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.ios_share, color: Colors.white),
                  tooltip: 'Share (coming soon)',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    _QuotationDecoration(),
                    _PhraseText(),
                    SizedBox(height: 20),
                    Text(
                      '(moo cooish-lah moh kree)',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 42),
                    Text(
                      '"my pulse, my heart" / "my darling"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // Keep visual style of two indicators but static.
                  _Indicator(active: true),
                  SizedBox(width: 14),
                  _Indicator(active: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhraseText extends StatelessWidget {
  const _PhraseText();

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      child: Text(
        'MO\nCHUISLE,\nMO\nCHROÍ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 70,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          height: 1.05,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _QuotationDecoration extends StatelessWidget {
  const _QuotationDecoration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [_QuoteShape(isLeft: true), _QuoteShape(isLeft: false)],
      ),
    );
  }
}

class _QuoteShape extends StatelessWidget {
  final bool isLeft;
  const _QuoteShape({required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.22,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(isLeft ? 1.0 : -1.0, 1.0),
        child: const Icon(Icons.format_quote, size: 120, color: Colors.white),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final bool active;
  const _Indicator({required this.active});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      height: 4,
      width: active ? 60 : 40,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
