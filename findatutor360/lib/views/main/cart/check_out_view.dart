import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/cart/edit_address_view.dart';
import 'package:findatutor360/views/main/cart/payment_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});
  static const path = '/checkOutView';

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  late BooksController booksController;
  late AuthController _authController;
  ValueNotifier<double> cartTotal = ValueNotifier<double>(0.0);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const double itemPrice = 50.0;

  void updateCartTotal() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // cartTotal.value += booksController.cart.length * itemPrice;

      double total = 0.0;
      for (var book in booksController.cart) {
        total += book.quantity * itemPrice; // Use the book's quantity
      }
      cartTotal.value = total;
    });
  }

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    booksController = context.watch<BooksController>();
    _authController = context.read<AuthController>();

    Color dynamicColor = (Theme.of(context).brightness != Brightness.dark
        ? Colors.black
        : Colors.white);

    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Checkout',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const ProgressBar(
                firstText: 'Checkout',
                secondText: 'Payment',
                thirdText: 'Done',
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MainText(
                    text: 'Delivery Information',
                    fontSize: 16,
                  ),
                  InkWell(
                    onTap: () {
                      router.push(EditAddressView.path);
                    },
                    child: MainText(
                      text: 'Edit',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: customTheme['secondaryTextColor'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              StreamBuilder<Users?>(
                  stream: _authController.getUserInfo(_auth.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final user = snapshot.data;
                    final isFile = user?.photoUrl != null &&
                        File(user!.photoUrl!).existsSync();

                    if (user == null) {
                      return const Center(
                          child: Text('No user data available.'));
                    }
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: !isFile
                          ? CircleAvatar(
                              backgroundColor: customTheme['primaryColor'],
                              radius: 20,
                              backgroundImage: NetworkImage(
                                user.photoUrl ??
                                    'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: customTheme['primaryColor'],
                              radius: 20,
                              backgroundImage: FileImage(
                                File(
                                  user.photoUrl ?? '',
                                ),
                              ),
                            ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: const Color(0xFFFDEFD5)),
                            child: const Align(
                              child: MainText(
                                text: 'Home',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFF7AD2B),
                              ),
                            ),
                          ),
                          MainText(
                            text: user.fullName ?? 'Martinelli',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            text: user.phoneNumber == null
                                ? user.phoneNumber ?? '+62 8123-4567-8910'
                                : '+62 8123-4567-8910',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MainText(
                            text: '871 kenangan Street',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: customTheme['secondaryTextColor'],
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MainText(
                    text: 'Order Summary',
                    fontSize: 16,
                  ),
                  MainText(
                    text: 'Edit',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: customTheme['secondaryTextColor'],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      width: 12,
                    );
                  },
                  itemCount: booksController.cart.length,
                  itemBuilder: (context, i) {
                    final book = booksController.cart[i];

                    final isFile = book.thumbnail != null &&
                        File(book.thumbnail!).existsSync();

                    return Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: dynamicColor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isFile
                              ? RepaintBoundary(
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.35,
                                    height:
                                        MediaQuery.sizeOf(context).height / 7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: customTheme['fieldColor'],
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(book.thumbnail ?? ''),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                7.5,
                                      ),
                                    ),
                                  ),
                                )
                              : RepaintBoundary(
                                  child: CachedNetworkImage(
                                    imageUrl: book.thumbnail ?? '',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.35,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                        decoration: BoxDecoration(
                                          color: customTheme['secondaryColor'],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                book.thumbnail ?? ''),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, image) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                        color: Colors.grey,
                                        child: const Icon(
                                          Icons.error_outline_sharp,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MainText(
                                    text: book.title ??
                                        'The science of leadership',
                                    fontSize: 12,
                                    softWrap: true,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                3.8,
                                        child: MainText(
                                          text: book.author ??
                                              book.authorName ??
                                              'Marcelos Ramequin',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          softWrap: true,
                                          color:
                                              customTheme['secondaryTextColor'],
                                        ),
                                      ),
                                      MainText(
                                        text: 'x${book.quantity}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        softWrap: true,
                                        color:
                                            customTheme['secondaryTextColor'],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  MainText(
                                    text:
                                        '\$${(itemPrice * book.quantity).toStringAsFixed(2)}',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    softWrap: true,
                                    color:
                                        customTheme['smainTextSecondaryColor'],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const MainText(
                text: 'Voucher',
                fontSize: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      prefixIcon: Icon(
                        Iconsax.receipt_disscount4,
                        color: customTheme['fieldColor'],
                      ),
                      hint: 'Enter Voucher Code',
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: customTheme['primaryColor'],
                    ),
                    child: Align(
                      child: MainText(
                        text: 'Use',
                        fontSize: 18,
                        color: customTheme['whiteColor'],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'Proceed to Payment',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                isIconPresent: false,
                onPressed: () {
                  router.push(
                    PaymentView.path,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OutlineButton(
                text: 'Cancel',
                buttonColor: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                isIconPresent: false,
                textColor: customTheme['primaryColor'],
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
