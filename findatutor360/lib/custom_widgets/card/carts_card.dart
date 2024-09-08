import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CartsCard extends StatefulWidget {
  const CartsCard({
    required this.itemImage,
    required this.itemName,
    required this.authorName,
    required this.itemPrice,
    this.deleteTap,
    super.key,
  });
  final String itemImage;
  final String itemName;
  final String authorName;
  final String itemPrice;
  final VoidCallback? deleteTap;

  @override
  State<CartsCard> createState() => _CartsCardState();
}

class _CartsCardState extends State<CartsCard> {
  ValueNotifier<int> quantity = ValueNotifier<int>(1);
  ValueNotifier<int> addOnQuantity = ValueNotifier<int>(0);
  // late ValueNotifier<double> totalPrice;

  @override
  void initState() {
    super.initState();
    // totalPrice = ValueNotifier<double>(
    //   double.parse(widget.sellingServicesData.price.replaceAll('\$', '')),
    // );
  }

  // void updateTotalPrice() {
  //   double basePrice =
  //       double.parse(widget.sellingServicesData.price.replaceAll('\$', ''));
  //   totalPrice.value = basePrice * (quantity.value + addOnQuantity.value);
  // }

  void increaseQuantity() {
    quantity.value++;
    // updateTotalPrice();
  }

  void increaseAddOnQuantity() {
    addOnQuantity.value++;
    // updateTotalPrice();
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      // updateTotalPrice();
    }
  }

  void decreaseAddOnQuantity() {
    if (addOnQuantity.value > 0) {
      addOnQuantity.value--;
      // updateTotalPrice();
    }
  }

  @override
  void dispose() {
    quantity.dispose();
    addOnQuantity.dispose();
    // totalPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height / 7,
            decoration: BoxDecoration(
              color: customTheme['secondaryColor'],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(widget.itemImage), fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: widget.itemName,
                  fontSize: 14,
                ),
                MainText(
                  text: widget.authorName,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                MainText(
                  text: widget.itemPrice,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['smainTextSecondaryColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: decreaseQuantity,
                          child: Icon(
                            Iconsax.minus_square4,
                            size: 20,
                            color: customTheme['primaryColor'],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: quantity,
                          builder: (context, value, child) {
                            return MainText(
                              text: '$value',
                              fontSize: 14,
                              color: customTheme['primaryColor'],
                            );
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: increaseQuantity,
                          child: Icon(
                            Iconsax.add_square4,
                            size: 20,
                            color: customTheme['primaryColor'],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: widget.deleteTap,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Container(
                          height: 28,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xFFFC392E),
                          ),
                          child: Icon(
                            Iconsax.trash,
                            size: 20,
                            color: customTheme['whiteColor'],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
