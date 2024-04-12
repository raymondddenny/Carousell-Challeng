import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousell_challenge/parallax_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ImageParallax> parallaxImages = [
    ImageParallax(
      image: 'assets/images/1.jpg',
      height: 200,
      width: 200,
    ),
    ImageParallax(
      image: 'assets/images/2.jpg',
      height: 200,
      width: 200,
    ),
    ImageParallax(
      image: 'assets/images/3.jpg',
      height: 200,
      width: 200,
    ),
    ImageParallax(
      image: 'assets/images/4.jpg',
      height: 200,
      width: 200,
    ),
    ImageParallax(
      image: 'assets/images/5.jpg',
      height: 200,
      width: 200,
    ),
  ];

  List<MenuIcons> menuIcons = [
    MenuIcons(icon: Icons.fastfood, label: 'Fast food'),
    MenuIcons(icon: Icons.spa, label: 'Spa'),
    MenuIcons(icon: Icons.nightlife, label: 'Experiences'),
    MenuIcons(icon: Icons.tram, label: 'Tram'),
    MenuIcons(icon: Icons.room_service, label: 'Room Services'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffeelatte'),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.orangeAccent.withAlpha(100),
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 25,
              runSpacing: 20,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: menuIcons
                  .map((menu) => Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.26,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            menu.icon,
                          ),
                          Text(
                            menu.label,
                            textAlign: TextAlign.center,
                          )
                        ],
                      )))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: Column(
              children: [
                const Text(
                  'Get Inspired',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Based on what\'s trending right now',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'BUCKET LIST / KIDS / WELLNESS / ROMANTIC',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 500,
                    child: ParallaxCarousel(imagePaths: parallaxImages.map((image) => image.image).toList()))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuIcons {
  MenuIcons({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class ImageParallax {
  ImageParallax({required this.image, required this.height, required this.width});

  final String image;
  final double height;
  final double width;
}

class ParallaxImage extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final double offset;

  const ParallaxImage({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
    this.offset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
