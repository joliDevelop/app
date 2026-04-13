import 'package:flutter/material.dart';
import 'login_indicator.dart';

class LoginCarousel extends StatefulWidget {
  const LoginCarousel({super.key});

  @override
  State<LoginCarousel> createState() => _LoginCarouselState();
}

class _LoginCarouselState extends State<LoginCarousel> {
  final PageController _controller = PageController();

  final List<String> images = [
    'assets/auth/A2.png',
    'assets/auth/A1.png',
    'assets/home/peaple3.png',
    'assets/home/peaple4.png',
  ];

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _autoPlay();
  }

  void _autoPlay() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 4));

      int nextPage = currentPage + 1;
      if (nextPage >= images.length) nextPage = 0;

      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: (index) {
            setState(() => currentPage = index);
          },
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Image.asset(
              images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            );
          },
        ),

        // Fade
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color.fromARGB(0, 255, 255, 255).withOpacity(0.45),
              ],
            ),
          ),
        ),

        // Indicador
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: LoginIndicator(
            currentPage: currentPage,
            total: images.length,
          ),
        ),
      ],
    );
  }
}