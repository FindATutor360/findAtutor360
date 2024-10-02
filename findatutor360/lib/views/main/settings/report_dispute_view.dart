import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/dash_container/dash_conatiner.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/custom_widgets/textfield/expand_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/report_dispute_success_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ReportDisputeView extends StatelessWidget {
  const ReportDisputeView({super.key});
  static const path = '/report_dispute';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackIconHeader(
          header: 'Report Dispute',
          backTap: () {
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
                hint: 'Provide a title for this Report Dispute',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'ReportDispute',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const ExpandTextFormField(
                hint: 'Describe your complaint',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Fair Settlement',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const ExpandTextFormField(
                hint:
                    'What do you think is a fair and reasonable resolution to the dispute',
              ),
              const SizedBox(
                height: 12,
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
                text: 'Submit',
                isIconPresent: false,
                fontWeight: FontWeight.w600,
                borderRadius: BorderRadius.circular(8),
                onPressed: () {
                  router.push(
                    ReportDisputeSuccessView.path,
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
