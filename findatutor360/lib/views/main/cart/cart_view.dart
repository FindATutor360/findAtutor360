import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/card/carts_card.dart';
import 'package:findatutor360/custom_widgets/card/expansionTile.dart';
import 'package:findatutor360/custom_widgets/dialogs/delete_dialog.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/cart/check_out_view.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const path = '/chatView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const Header(),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MainText(
                text: 'Cart Items',
                fontSize: 18,
              ),
              const SizedBox(
                height: 16,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, i) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: 2,
                itemBuilder: (context, i) {
                  return CartsCard(
                    itemImage: 'assets/images/activeImg.png',
                    itemName: 'The science of leadership',
                    authorName: 'Marcelos Ramequin',
                    itemPrice: '\$100.00',
                    deleteTap: () {
                      Navigator.of(context).push(
                        DeleteDialog(
                          removeTap: () {},
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              const Divider(),
              const SizedBox(
                height: 40,
              ),
              TextExpansionTile(
                initiallyExpanded: true,
                iconColor: customTheme['primaryColor'],
                title: Row(
                  children: [
                    const MainText(
                      text: 'Subtotal',
                      fontSize: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MainText(
                      text: '(2 Items)',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: customTheme['secondaryTextColor'],
                    ),
                  ],
                ),
                description: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, i) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      itemCount: 2,
                      itemBuilder: (context, i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainText(
                              text: '2x The Science of le...',
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              color: customTheme['secondaryTextColor'],
                            ),
                            MainText(
                              text: 'Ghc200.00',
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              color: customTheme['secondaryTextColor'],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 24,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'Total',
                          fontSize: 16,
                        ),
                        MainText(
                          text: 'GHc400.00',
                          fontSize: 16,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PrimaryButton(
                      text: 'Checkout',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      isIconPresent: false,
                      onPressed: () {
                        router.push(
                          CheckOutView.path,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
