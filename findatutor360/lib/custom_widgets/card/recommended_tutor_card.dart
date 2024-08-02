import 'package:cached_network_image/cached_network_image.dart';
import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/card/card_status.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class RecommededTutorCard extends StatelessWidget {
  const RecommededTutorCard({
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
                const SizedBox(height: 10),
                CachedNetworkImage(
                  width: 64,
                  height: 75,
                  imageUrl:
                      'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
                  placeholder: (context, url) => CircleAvatar(
                    backgroundColor: customTheme['secondaryColor']!,
                    radius: 20,
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    backgroundColor: customTheme['secondaryColor']!,
                    radius: 20,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 10),
                const MainText(
                  text: 'Miss Elsie Smith',
                  fontSize: 14,
                ),
                const SizedBox(height: 5),
                MainText(
                  text: 'Economics',
                  fontSize: 12,
                  color: customTheme['secondaryTextColor']!,
                ),
                const SizedBox(height: 5),
                const CardStatus(
                  isOnline: false,
                ),
                const SizedBox(height: 5),
                const CustomRatingBar(),
                // const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const MainText(
                        text: '2 Courses',
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
