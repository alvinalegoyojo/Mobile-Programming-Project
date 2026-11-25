import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'action_button.dart';
import 'custom_text.dart';

class NewsFeedCard extends StatelessWidget {
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool hasImage;
  final String profileImage;
  final String postImage;

  const NewsFeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes = 0,
    this.hasImage = false,
    this.profileImage = '',
    this.postImage = '',
  });

  Widget _buildAvatar({double radius = 18}) {
    ImageProvider? avatarImage;
    if (profileImage.isNotEmpty) {
      avatarImage = profileImage.startsWith('http')
          ? NetworkImage(profileImage)
          : AssetImage(profileImage);
    }

    return CircleAvatar(
      radius: ScreenUtil().setSp(radius),
      backgroundColor: Colors.grey[300],
      backgroundImage: avatarImage,
      child: avatarImage == null
          ? Icon(
              Icons.person,
              color: Colors.grey[700],
              size: ScreenUtil().setSp(radius),
            )
          : null,
    );
  }

  Widget _buildPostImage() {
    if (!hasImage) {
      return SizedBox(height: ScreenUtil().setHeight(5));
    }

    if (postImage.isEmpty) {
      return SizedBox(
        height: ScreenUtil().setHeight(200),
        width: double.infinity,
        child: const Placeholder(),
      );
    }

    final Widget imageWidget = postImage.startsWith('http')
        ? Image.network(
            postImage,
            fit: BoxFit.cover,
            width: double.infinity,
          )
        : Image.asset(
            postImage,
            fit: BoxFit.cover,
            width: double.infinity,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(ScreenUtil().setSp(6)),
      child: SizedBox(
        height: ScreenUtil().setHeight(220),
        width: double.infinity,
        child: imageWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setSp(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAvatar(radius: 18),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: userName,
                      fontSize: ScreenUtil().setSp(15),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: date,
                          fontSize: ScreenUtil().setSp(12),
                          color: Colors.grey,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(3)),
                        Icon(
                          Icons.public,
                          color: Colors.grey,
                          size: ScreenUtil().setSp(15),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(8)),

            // Post Content
            CustomText(
              text: postContent,
              fontSize: ScreenUtil().setSp(12),
              color: Colors.black,
            ),
            SizedBox(height: ScreenUtil().setHeight(8)),

            // Dynamic Post Image
            _buildPostImage(),
            SizedBox(height: ScreenUtil().setHeight(8)),

            // Number of Likes
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: FB_PRIMARY,
                  size: ScreenUtil().setSp(14),
                ),
                SizedBox(width: ScreenUtil().setWidth(5)),
                CustomText(
                  text: numOfLikes.toString(),
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey,
                ),
              ],
            ),
            const Divider(),

            // Widget-Based Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  icon: Icons.thumb_up_outlined,
                  label: 'Like',
                  onPressed: () {
                    print('Liked');
                  },
                ),
                ActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comment',
                  onPressed: () {
                    print('Commented');
                  },
                ),
                ActionButton(
                  icon: Icons.redo,
                  label: 'Share',
                  onPressed: () {
                    print('Shared');
                  },
                ),
              ],
            ),
            const Divider(),

            // Comment Input Bar
            Row(
              children: [
                _buildAvatar(radius: 14),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setSp(10),
                      0,
                      0,
                      0,
                    ),
                    alignment: Alignment.centerLeft,
                    height: ScreenUtil().setHeight(28),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setSp(15)),
                      ),
                    ),
                    child: CustomText(
                      text: 'Write a comment...',
                      fontSize: ScreenUtil().setSp(11),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            CustomText(
              text: 'View comments',
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}