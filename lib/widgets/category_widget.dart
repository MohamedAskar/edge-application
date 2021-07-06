import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String image;
  final String category;
  final String underline;
  final String subcategory;
  const CategoryWidget({
    @required this.category,
    @required this.image,
    @required this.underline,
    this.subcategory,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 150),
                  opaque: false,
                  pageBuilder: (_, animation1, __) {
                    return SlideTransition(
                        position: Tween(
                                begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation1),
                        child: CategoryScreen(
                          category: category,
                        ));
                  }));
        },
        child: Stack(
          children: [
            CachedNetworkImage(
              width: size.width - 16,
              height: size.height / 3,
              imageUrl: image,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.none,
              progressIndicatorBuilder: (context, url, progress) => Container(
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Positioned(
                top: 22,
                left: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subcategory != null)
                      Text(
                        subcategory,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      category,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      underline,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
