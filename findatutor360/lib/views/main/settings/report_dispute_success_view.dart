import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportDisputeSuccessView extends StatelessWidget {
  const ReportDisputeSuccessView({super.key});
  static const path = '/report_dispute_success';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackIconHeader(
          header: 'Report Dispute',
          showIcon: false,
          backTap: () {
            context.pop();
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    text: 'Successful',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                    "Dispute has been received. We will get back to you soon",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Color(0xFF79848E),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              //button
              PrimaryButton(
                isIconPresent: false,
                text: 'Continue',
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
