import 'package:asset_cache/asset_cache.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParallaxCarousel extends StatefulWidget {
  final List<String> imagePaths;

  const ParallaxCarousel({super.key, required this.imagePaths});

  @override
  State<ParallaxCarousel> createState() => _ParallaxCarouselState();
}

class _ParallaxCarouselState extends State<ParallaxCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    keepPage: true, // Infinite looping
  );
  double currentPageValue = 0.0;
  List<Image> _loadedImages = [];

  @override
  void initState() {
    super.initState();
    _preloadImages();
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page ?? currentPageValue;
        if (_pageController.page == _loadedImages.length - 1) {
          _smoothTransitionToFirst(); // Jump to the first page for continuous transition
        }
      });
    });
    // Auto slide
    _startAutoSlide(); // Start auto slide
  }

  void _smoothTransitionToFirst() {
    // Calculate the offset to mimic the first image's position
    final offsetToFirst = -_pageController.viewportFraction * _loadedImages.length;

    // Animate the transition
    _pageController
        .animateTo(
      offsetToFirst,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOut,
    )
        .then((_) {
      // Optional: Reset to the first page for continuous looping
      _pageController.jumpToPage(0);
    });
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 2), () {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
      );
      _startAutoSlide(); // Continue auto slide
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: _loadedImages.length + 1, // Add 1 to the length for smooth looping
      itemBuilder: (context, index) {
        final pageOffset = currentPageValue - (index % _loadedImages.length); // Use modulo to loop images
        double scaleFactor = math.max(0.8, 1.0 - (pageOffset.abs() * 0.2)); // Make focus image bigger
        return _buildLinearEffect(
            context, index % _loadedImages.length, pageOffset, scaleFactor); // Use modulo for index
      },
    );
  }

  void _preloadImages() {
    _loadedImages = widget.imagePaths.map((imagePath) {
      final cacheImage = ImageAssetCache(basePath: imagePath);
      return Image.asset(
        cacheImage.basePath!,
        cacheWidth: 3000,
      );
    }).toList();
  }

  Widget _buildLinearEffect(BuildContext context, int index, double pageOffset, double scaleFactor) {
    double gauss = math.exp(-(math.pow(pageOffset.abs() - 0.2, 2) / 0.08));
    return Transform.scale(
      scale: scaleFactor,
      child: Transform.translate(
        offset: Offset(gauss * pageOffset.sign, 0),
        child: Container(
          height: 500,
          width: 350,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: _loadedImages[index].image,
              alignment: Alignment(-pageOffset * 0.5, 0), // Adjusted the alignment for smoother transition
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
