import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class ActiveCourse extends StatelessWidget {
  const ActiveCourse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // router.push('/tutor_profile');
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.27,
          decoration: BoxDecoration(
              color: customTheme['whiteColor'],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: customTheme['lightGrayColor']!)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: customTheme['secondaryColor'],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/activeImg.png'),
                        fit: BoxFit.contain),
                  ),
                  height: MediaQuery.of(context).size.height * 0.14,
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: MainText(
                    text: 'Introduction to Computer Science',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const MainText(
                        text: '1/5 Lessons',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const CustomLikeButton()
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
