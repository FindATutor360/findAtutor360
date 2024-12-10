import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/card/carts_card.dart';
import 'package:findatutor360/custom_widgets/card/expansion_tile.dart';
import 'package:findatutor360/custom_widgets/dialogs/delete_dialog.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/cart/check_out_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  //Getting the chartview path
  static const path = '/chartView';

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  ValueNotifier<double> cartTotal = ValueNotifier<double>(0.0);
  late BooksController booksController;

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

  @override
  Widget build(BuildContext context) {
    booksController = context.watch<BooksController>();

    updateCartTotal();

    return SafeArea(
      child: Scaffold(
        appBar: const Header(),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              booksController.cart.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 4,
                        ),
                        const Center(
                          child: MainText(text: 'Your cart is empty'),
                        ),
                      ],
                    )
                  : Column(
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
                          itemCount: booksController.cart.length,
                          itemBuilder: (context, i) {
                            final book = booksController.cart[i];
                            //returning Cart Card
                            return CartsCard(
                              book: book,
                              itemPrice: itemPrice, // Fixed price of $50
                              deleteTap: () {
                                Navigator.of(context).push(
                                  DeleteDialog(
                                    context,
                                    removeTap: () {
                                      booksController.removeFromCart(book);
                                      //Show toast
                                      Fluttertoast.showToast(
                                        msg: "${book.title} removed from cart",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor:
                                            customTheme['primaryColor'],
                                        textColor: customTheme['badgeColor'],
                                        fontSize: 16.0,
                                      );
                                      context.pop();
                                      updateCartTotal();
                                    },
                                  ),
                                );
                              },
                              onPriceChange: (d) {
                                updateCartTotal();
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
                                text: '(${booksController.cart.length})',
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
                                itemCount: booksController.cart.length,
                                itemBuilder: (context, i) {
                                  final book = booksController.cart[i];

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          style: TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.clip,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Manrope',
                                            color: customTheme[
                                                'secondaryTextColor'],
                                          ),
                                          TextSpan(
                                            text: book.title,
                                            children: [
                                              TextSpan(
                                                text: '  x${book.quantity}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      MainText(
                                        text:
                                            '\$${(itemPrice * book.quantity).toStringAsFixed(2)}',
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            customTheme['secondaryTextColor'],
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const MainText(
                                    text: 'Total',
                                    fontSize: 16,
                                  ),
                                  ValueListenableBuilder<double>(
                                    valueListenable: cartTotal,
                                    builder: (context, value, child) {
                                      return MainText(
                                        text: '\$${value.toStringAsFixed(2)}',
                                        fontSize: 18,
                                      );
                                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
