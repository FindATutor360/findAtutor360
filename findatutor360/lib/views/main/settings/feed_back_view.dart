import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/dash_container/dash_conatiner.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/custom_widgets/textfield/expand_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/feed_back_success_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FeedBackView extends StatelessWidget {
  const FeedBackView({super.key});
  static const path = '/feed_back';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackIconHeader(
          header: 'Feedback',
          backTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              MainText(
                text: 'Title',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'Provide a title for this feedback',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Nature of feedback',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const ExpandTextFormField(
                hint: 'Nature of feedback',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Propose a change',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const ExpandTextFormField(
                hint: 'What changes would you like to see?',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Upload Propose Image',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: CustomPaint(
                  painter: DashedRectanglePainter(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      children: [
                        Icon(
                          Iconsax.image5,
                          color: customTheme['primaryColor'],
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Click to ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: customTheme['mainTextColor'],
                            ),
                            children: [
                              TextSpan(
                                text: 'Upload file',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: customTheme['primaryColor'],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        MainText(
                          text: 'PNG, JPG, , PDF upto 5MB',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: customTheme['secondaryTextColor'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'Send',
                isIconPresent: false,
                fontWeight: FontWeight.w600,
                borderRadius: BorderRadius.circular(8),
                onPressed: () {
                  router.push(
                    FeedBackSuccessView.path,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
