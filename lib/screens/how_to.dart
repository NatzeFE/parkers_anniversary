import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/menu_bottom.dart';
// import '../shared/menu_drawer.dart';

class HowTo extends StatefulWidget {
  const HowTo({super.key});

  @override
  State<HowTo> createState() => _HowToState();
}

class _HowToState extends State<HowTo> {
  final controller = CarouselController();
  int activeIndex = 0;
  final images = [
    "assets/images/takePic.jpg",
    "assets/images/rec.jpg",
    "assets/images/submit.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Center(
          child: Text(
            "How to enter",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const MenuBottom(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImageSlider(),
            const SizedBox(
              height: 20,
            ),
            buildIndicator(),
            const SizedBox(
              height: 20,
            ),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildImageSlider() => CarouselSlider.builder(
        carouselController: controller,
        options: CarouselOptions(
          height: 400,
          // initialPage: 0,
          autoPlay: true,
          autoPlayInterval: const Duration(milliseconds: 2500),
          enlargeCenterPage: true,
          onPageChanged: (index, reason) => setState(
            () => activeIndex = index,
          ),
        ),
        itemCount: images.length,
        itemBuilder: (context, index, realIndex) {
          final image = images[index];

          return buildImage(image, index);
        },
      );

  Widget buildImage(String image, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        color: Colors.grey,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        // onDotClicked: animeToSlide,
        effect: const JumpingDotEffect(
          dotColor: Colors.black,
          activeDotColor: Colors.red,
          dotWidth: 15,
          dotHeight: 15,
        ),
      );

  Widget buildButtons({bool stretch = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            onPressed: previous,
            child: const Icon(Icons.arrow_back, size: 32),
          ),
          stretch ? const Spacer() : const SizedBox(width: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            onPressed: next,
            child: const Icon(Icons.arrow_forward, size: 32),
          ),
        ],
      );

  void previous() =>
      controller.previousPage(duration: const Duration(milliseconds: 500));

  void next() =>
      controller.nextPage(duration: const Duration(milliseconds: 500));

  // animeToSlide(int index) => controller.animateToPage(index); click on the dot to change
}
