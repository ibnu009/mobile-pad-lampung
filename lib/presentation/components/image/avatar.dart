import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.url, this.size, this.color})
      : super(key: key);
  final String url;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: url == '' ? Colors.transparent : color,
      backgroundImage: Image.network(
        url,
        errorBuilder: (_, __, ___) {
          return Image.asset("assets/images/default_profile.png");
        },
      ).image,
      onBackgroundImageError: (_, __) {},
      child: url != '' ? const SizedBox() : SvgPicture.asset("assets/icons/default_profile_icon.svg"),
    );
  }
}
