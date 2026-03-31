import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// Modelo interno del slide (privado al widget)
class _CarouselSlide {
  final String imagePath;
  final String badge;

  const _CarouselSlide({
    required this.imagePath,
    required this.badge,
  });
}

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<_CarouselSlide> _slides = const [
    _CarouselSlide(
      imagePath: 'assets/home/peaple2.png',
      badge: 'CONFIANZA Y SEGURIDAD',
    ),
    _CarouselSlide(
      imagePath: 'assets/home/peaple3.png',
      badge: 'ASESORÍA PERSONALIZADA',
    ),
    _CarouselSlide(
      imagePath: 'assets/home/peaple4.png',
      badge: 'TU FUTURO, NUESTRA MISIÓN',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_currentPage + 1) % _slides.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CARRUSEL
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return Image.asset(
                  _slides[index].imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),

        // BADGE dinámico por slide
        Positioned(
          bottom: 14,
          left: 14,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Container(
              key: ValueKey(_currentPage),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                _slides[_currentPage].badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),

        // DOTS indicadores
        Positioned(
          bottom: 14,
          right: 14,
          child: Row(
            children: List.generate(_slides.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(left: 6),
                width: isActive ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}