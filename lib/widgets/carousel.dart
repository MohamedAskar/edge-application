import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EdgeCarousel extends StatefulWidget {
  final List<dynamic> images;
  final double height;

  EdgeCarousel({@required this.images, @required this.height});

  @override
  _EdgeCarouselState createState() => _EdgeCarouselState();
}

class _EdgeCarouselState extends State<EdgeCarousel> {
  int _currentPage = 0;
  final _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.images.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_controller.hasClients) {
        _controller.animateToPage(_currentPage,
            duration: Duration(milliseconds: 350), curve: Curves.easeIn);
      }
    });
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
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            controller: _controller,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.images[index],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => Container(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            },
          ),
        ),
        Container(
          height: widget.height,
          padding: const EdgeInsets.only(bottom: 18),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(
              controller: _controller,
              count: widget.images.length,
              effect: WormEffect(
                  activeDotColor: Colors.black,
                  dotColor: Colors.grey,
                  radius: 8.0,
                  dotHeight: 8.0,
                  dotWidth: 8.0),
            ),
          ),
        )
      ],
    );
  }
}
