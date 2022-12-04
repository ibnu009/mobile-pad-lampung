
import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatefulWidget {
  final double? width, height;
  final void Function() onTap;
  const ImagePlaceHolder(
      {Key? key,
      this.width,
      this.height,
      required this.onTap})
      : super(key: key);

  @override
  State<ImagePlaceHolder> createState() =>
      _ImagePlaceHolderState();
}

class _ImagePlaceHolderState extends State<ImagePlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Center(
        child: Image.asset(
          'assets/images/empty_photo.png',
          height: widget.height ?? 100,
          width: widget.width ?? 100,
        ),
      ),
    );
  }
}
