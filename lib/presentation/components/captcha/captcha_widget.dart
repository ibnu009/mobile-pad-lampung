import 'package:flutter/material.dart';
import 'package:hb_check_code/hb_check_code.dart';

import '../../utils/helper/string_randomizer.dart';

class CaptchaWidget extends StatefulWidget {
  const CaptchaWidget({Key? key}) : super(key: key);

  @override
  State<CaptchaWidget> createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {

  String code = getRandomString(5);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                alignment: Alignment.center,
                child: HBCheckCode(
                  code: code,
                )),
            InkWell(
                onTap: () {
                  setState(() {
                    code = getRandomString(5);
                  });
                },
                child: const Icon(Icons.refresh)),
          ],
        ),
      ],
    );
  }
}
