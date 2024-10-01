import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class BackIconHeader extends StatelessWidget implements PreferredSizeWidget {
  final String header;
  final IconData icon;
  final Color iconColor;
  final bool showIcon;
  final IconData closeIcon;
  const BackIconHeader({
    super.key,
    required this.header,
    this.icon = Iconsax.search_normal_1,
    this.iconColor = const Color.fromRGBO(121, 132, 142, 1),
    this.showIcon = true,
    this.closeIcon = Icons.arrow_back,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(closeIcon),
                onPressed: () => context.pop(context),
              ),
              const Spacer(),
              MainText(
                text: header,
                fontSize: 18,
              ),
              const Spacer(),
              if (showIcon) ...[
                CustomIconButton(
                  onPressed: null,
                  icon: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
              ],
              showIcon == false ? const Spacer() : const SizedBox.shrink(),
            ],
          ),
        ),
        const Expanded(
          child: Divider(),
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
