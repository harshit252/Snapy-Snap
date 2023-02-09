import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class GenerateImage extends StatelessWidget {
  const GenerateImage({
    super.key,
    required this.imageList,
  });

  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      primary: false,
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      itemCount: imageList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageList[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
