import 'package:flutter/material.dart';

import '../generic/loading_widget.dart';

const String defaultImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png";
class GenericImageNetwork extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;

  const GenericImageNetwork({Key? key, required this.imageUrl, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl != null ? 'https://backend-pad.abera.id/storage/$imageUrl' : defaultImage,
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: LoadingWidget(
            width: 80,
            height: 80,
          ),
        );
      },
    );
  }
}