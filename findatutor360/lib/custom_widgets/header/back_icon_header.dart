import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BackIconHeader extends StatelessWidget implements PreferredSizeWidget {
  final String header;
  const BackIconHeader({
    super.key,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: customTheme['buttonColor'],
                onPressed: () => Navigator.pop(context),
              ),
              MainText(
                text: header,
                fontSize: 18,
              ),
              const CustomIconButton(
                onPressed: null,
                icon: Icon(Iconsax.search_normal_1),
              ),
            ],
          ),
        ),
        Expanded(
          child: Divider(
            color: customTheme['dividerColor'],
            thickness: 1,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        65,
      );
}
