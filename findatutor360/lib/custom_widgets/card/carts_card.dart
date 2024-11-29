import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CartsCard extends StatefulWidget {
  const CartsCard({
    required this.book,
    required this.itemPrice,
    this.deleteTap,
    required this.onPriceChange,
    super.key,
  });

  final Book book;
  final double itemPrice;
  final VoidCallback? deleteTap;
  final Function(double) onPriceChange;

  @override
  State<CartsCard> createState() => _CartsCardState();
}

class _CartsCardState extends State<CartsCard> {
  int quantity = 1;

  late BooksController booksController;

  void increaseQuantity() {
    setState(() {
      quantity++;
      booksController.updateBookQuantity(widget.book, quantity);
      widget.onPriceChange(widget.itemPrice);
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        booksController.updateBookQuantity(widget.book, quantity);
        widget.onPriceChange(-widget.itemPrice);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    booksController = context.watch<BooksController>();

    final isFile = widget.book.thumbnail != null &&
        File(widget.book.thumbnail!).existsSync();
    final isUrl = widget.book.thumbnail != null &&
        Uri.tryParse(widget.book.thumbnail!)?.hasAbsolutePath == true;
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isFile
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: customTheme['fieldColor'],
                    image: DecorationImage(
                      image: FileImage(
                        File(widget.book.thumbnail ?? ''),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height / 7.5,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: widget.book.thumbnail ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                        color: customTheme['secondaryColor'],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.book.thumbnail ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, image) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                    );
                  },
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: widget.book.title ?? '',
                    fontSize: 14,
                    softWrap: true,
                  ),
                  MainText(
                    text: widget.book.author ?? 'Unknown',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: customTheme['secondaryTextColor'],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Display the total price
                  MainText(
                    text:
                        '\$${(widget.itemPrice * quantity).toStringAsFixed(2)}',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: customTheme['smainTextSecondaryColor'],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
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
                          MainText(
                            text: '$quantity',
                            fontSize: 14,
                            color: customTheme['primaryColor'],
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
                      const Spacer(),
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
          ),
        ],
      ),
    );
  }
}
