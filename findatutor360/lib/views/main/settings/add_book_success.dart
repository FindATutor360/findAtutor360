import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookSuccessView extends StatelessWidget {
  const AddBookSuccessView({super.key});
  static const path = '/add_book_success';

  @override
  Widget build(BuildContext context) {
    final booksController =
        Provider.of<BooksController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Complete',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const ProgressBar(
                firstText: 'Basic',
                secondText: 'Publishing',
                thirdText: 'Condition',
                isFirstDone: true,
                isSecondActive: true,
                isSecondDone: true,
                isThirdActive: true,
                isThirdDone: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                child: Image.asset('assets/images/cart.png',
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MainText(
                    text: 'Success',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                    "Your book has been successfully added and is pending review",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Color(0xFF79848E),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              //button

              ValueListenableBuilder(
                valueListenable: booksController.isLoading,
                builder: (context, isLoading, child) {
                  return isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryButton(
                              isIconPresent: false,
                              text: 'Continue',
                              onPressed: () async {
                                booksController.isLoading.value = true;
                                Future.delayed(Duration(seconds: 2), () {
                                  booksController.isLoading.value =
                                      false; // Set loading back to false after 2 seconds
                                });
                                booksController.saveBookDetails();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            OutlineButton(
                              text: 'Undo All Edit',
                              textColor: customTheme['badgeColor'],
                              fontWeight: FontWeight.w600,
                              borderRadius: BorderRadius.circular(8),
                              buttonColor: customTheme['whiteColor'],
                              borderSideColor: customTheme['badgeColor'],
                              isIconPresent: false,
                              fontSize: 16,
                              onPressed: () {
                                booksController.resetBookDetails();
                              },
                            ),
                          ],
                        );
                },
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
