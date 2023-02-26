/// Dart package to use dynamic emo reaction
/// through this package you can pass the your required assets emo and add to the collection
/// if you passed emo it takes that if not it has own collection on reactions
/// visit demo page for more details and uses
/// Author : Ambika Dulal
/// Github : https://github.com/Ambikadulal
/// Assets/ icon : https://icons8.com/icons/
///Gif maker : https://giphy.com/create/gifmaker
///
///
import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SocialReactionCollection extends StatefulWidget {
  final String? likeGif;
  final String? likePng;
  final String? likeFillPng;
  final String? loveGif;
  final String? lovePng;
  final String? hahaGif;
  final String? hahaPng;
  final String? wowGif;
  final String? wowPng;
  final String? sadGif;
  final String? sadPng;
  final String? angryGif;
  final String? angryPng;
  final String? likeText;
  final String? loveText;
  final String? hahaText;
  final String? wowText;
  final String? sadText;
  final String? angryText;

  const SocialReactionCollection(
      {Key? key,
      this.likeGif,
      this.loveGif,
      this.hahaGif,
      this.wowGif,
      this.sadGif,
      this.angryGif,
      this.likePng,
      this.likeFillPng,
      this.lovePng,
      this.hahaPng,
      this.wowPng,
      this.sadPng,
      this.angryPng,
      this.likeText,
      this.loveText,
      this.hahaText,
      this.wowText,
      this.sadText,
      this.angryText})
      : super(key: key);

  @override
  createState() => SocialReactionCollectionState();
}

class SocialReactionCollectionState extends State<SocialReactionCollection> with TickerProviderStateMixin {
  late AudioPlayer audioPlayer;
  int durationAnimationBox = 500;
  int durationAnimationBtnLongPress = 150;
  int durationAnimationBtnShortPress = 500;
  int durationAnimationIconWhenDrag = 150;
  int durationAnimationIconWhenRelease = 1000;

// For long press btn collection
  late AnimationController animControlBtnLongPress, animControlBox;
  late Animation zoomIconLikeInBtn, tiltIconLikeInBtn, zoomTextLikeInBtn;
  late Animation fadeInBox;
  late Animation moveRightGroupIcon;
  late Animation pushIconLikeUp, pushIconLoveUp, pushIconHahaUp, pushIconWowUp, pushIconSadUp, pushIconAngryUp;
  late Animation zoomIconLike, zoomIconLove, zoomIconHaha, zoomIconWow, zoomIconSad, zoomIconAngry;

// For short press btn
  late AnimationController animControlBtnShortPress;
  late Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;

// For zoom icon when drag
  late AnimationController animControlIconWhenDrag;
  late AnimationController animControlIconWhenDragInside;
  late AnimationController animControlIconWhenDragOutside;
  late AnimationController animControlBoxWhenDragOutside;
  late Animation zoomIconChosen, zoomIconNotChosen;
  late Animation zoomIconWhenDragOutside;
  late Animation zoomIconWhenDragInside;
  late Animation zoomBoxWhenDragOutside;
  late Animation zoomBoxIcon;

// For jump icon when release
  late AnimationController animControlIconWhenRelease;
  late Animation zoomIconWhenRelease, moveUpIconWhenRelease;
  late Animation moveLeftIconLikeWhenRelease,
      moveLeftIconLoveWhenRelease,
      moveLeftIconHahaWhenRelease,
      moveLeftIconWowWhenRelease,
      moveLeftIconSadWhenRelease,
      moveLeftIconAngryWhenRelease;

  Duration durationLongPress = const Duration(milliseconds: 250);
  late Timer holdTimer;
  bool isLongPress = false;
  bool isLiked = false;

// 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int whichIconUserChoose = 0;

// 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int currentIconFocus = 0;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();

// Button Like
    initAnimationBtnLike();

// Box and Icons
    initAnimationBoxAndIcons();

// Icon when drag
    initAnimationIconWhenDrag();

// Icon when drag outside
    initAnimationIconWhenDragOutside();

// Box when drag outside
    initAnimationBoxWhenDragOutside();

// Icon when first drag
    initAnimationIconWhenDragInside();

// Icon when release
    initAnimationIconWhenRelease();
  }

  initAnimationBtnLike() {
// long press
    animControlBtnLongPress =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn = Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
    tiltIconLikeInBtn = Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
    zoomTextLikeInBtn = Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

    zoomIconLikeInBtn.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn.addListener(() {
      setState(() {});
    });
    zoomTextLikeInBtn.addListener(() {
      setState(() {});
    });

// short press
    animControlBtnShortPress =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 = Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 = Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationBox));

// General
    moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 1.0)),
    );
    moveRightGroupIcon.addListener(() {
      setState(() {});
    });

// Box
    fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.7, 1.0)),
    );
    fadeInBox.addListener(() {
      setState(() {});
    });

// Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );

    pushIconLikeUp.addListener(() {
      setState(() {});
    });
    zoomIconLike.addListener(() {
      setState(() {});
    });
    pushIconLoveUp.addListener(() {
      setState(() {});
    });
    zoomIconLove.addListener(() {
      setState(() {});
    });
    pushIconHahaUp.addListener(() {
      setState(() {});
    });
    zoomIconHaha.addListener(() {
      setState(() {});
    });
    pushIconWowUp.addListener(() {
      setState(() {});
    });
    zoomIconWow.addListener(() {
      setState(() {});
    });
    pushIconSadUp.addListener(() {
      setState(() {});
    });
    zoomIconSad.addListener(() {
      setState(() {});
    });
    pushIconAngryUp.addListener(() {
      setState(() {});
    });
    zoomIconAngry.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDrag() {
    animControlIconWhenDrag =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));

    zoomIconChosen = Tween(begin: 1.0, end: 1.8).animate(animControlIconWhenDrag);
    zoomIconNotChosen = Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
    zoomBoxIcon = Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

    zoomIconChosen.addListener(() {
      setState(() {});
    });
    zoomIconNotChosen.addListener(() {
      setState(() {});
    });
    zoomBoxIcon.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragOutside() {
    animControlIconWhenDragOutside =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragOutside = Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
    zoomIconWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxWhenDragOutside() {
    animControlBoxWhenDragOutside =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomBoxWhenDragOutside = Tween(begin: 40.0, end: 50.0).animate(animControlBoxWhenDragOutside);
    zoomBoxWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside = Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  initAnimationIconWhenRelease() {
    animControlIconWhenRelease =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenRelease));

    zoomIconWhenRelease = Tween(begin: 1.8, end: 0.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveUpIconWhenRelease = Tween(begin: 180.0, end: 0.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveLeftIconLikeWhenRelease = Tween(begin: 20.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconLoveWhenRelease = Tween(begin: 68.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconHahaWhenRelease = Tween(begin: 116.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconWowWhenRelease = Tween(begin: 164.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconSadWhenRelease = Tween(begin: 212.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconAngryWhenRelease = Tween(begin: 260.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));

    zoomIconWhenRelease.addListener(() {
      setState(() {});
    });
    moveUpIconWhenRelease.addListener(() {
      setState(() {});
    });

    moveLeftIconLikeWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconLoveWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconHahaWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconWowWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconSadWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconAngryWhenRelease.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEndBoxIcon,
      onHorizontalDragUpdate: onHorizontalDragUpdateBoxIcon,
      child: Column(
        children: <Widget>[
// top space container
          const SizedBox(
            width: double.infinity,
            height: 100.0,
          ),

// main content
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
// Area of the content can drag
// decoration:  BoxDecoration(border: Border.all(color: Colors.grey)),
            width: double.infinity,
            height: 350.0,
            child: Stack(
              children: <Widget>[
// Box and icons
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
// Box
                    renderBox(),

// Icons
                    renderIcons(),
                  ],
                ),

// Button like
                renderBtnLike(),

// Icons jump places
// Icon like
                whichIconUserChoose == 1 && !isDragging
                    ? Container(
                        margin: EdgeInsets.only(
                          top: processTopPosition(moveUpIconWhenRelease.value),
                          left: moveLeftIconLikeWhenRelease.value,
                        ),
                        child: Transform.scale(
                          scale: zoomIconWhenRelease.value,
                          child: Image.asset(
                            widget.likeGif ??
                                'packages/social_feed_reaction/packages/social_feed_reaction/images/like.gif',
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      )
                    : const SizedBox(),

// Icon love
                whichIconUserChoose == 2 && !isDragging
                    ? Container(
                        margin: EdgeInsets.only(
                          top: processTopPosition(moveUpIconWhenRelease.value),
                          left: moveLeftIconLoveWhenRelease.value,
                        ),
                        child: Transform.scale(
                          scale: zoomIconWhenRelease.value,
                          child: Image.asset(
                            widget.loveGif ?? 'packages/social_feed_reaction/images/love.gif',
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      )
                    : const SizedBox(),

// Icon haha
                whichIconUserChoose == 3 && !isDragging
                    ? Container(
                        margin: EdgeInsets.only(
                          top: processTopPosition(moveUpIconWhenRelease.value),
                          left: moveLeftIconHahaWhenRelease.value,
                        ),
                        child: Transform.scale(
                          scale: zoomIconWhenRelease.value,
                          child: Image.asset(
                            widget.hahaGif ?? 'packages/social_feed_reaction/images/haha.gif',
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      )
                    : const SizedBox(),

// Icon Wow
                whichIconUserChoose == 4 && !isDragging
                    ? Container(
                        margin: EdgeInsets.only(
                          top: processTopPosition(moveUpIconWhenRelease.value),
                          left: moveLeftIconWowWhenRelease.value,
                        ),
                        child: Transform.scale(
                          scale: zoomIconWhenRelease.value,
                          child: Image.asset(
                            widget.wowGif ?? 'packages/social_feed_reaction/images/wow.gif',
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      )
                    : const SizedBox(),

// Icon sad
                whichIconUserChoose == 5 && !isDragging
                    ? Container(
                        margin: EdgeInsets.only(
                          top: processTopPosition(moveUpIconWhenRelease.value),
                          left: moveLeftIconSadWhenRelease.value,
                        ),
                        child: Transform.scale(
                          scale: zoomIconWhenRelease.value,
                          child: Image.asset(
                            widget.sadGif ?? 'packages/social_feed_reaction/images/sad.gif',
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      )
                    : const SizedBox(),

// Icon angry
                whichIconUserChoose == 6 && !isDragging
                    ? Container(
                        margin: EdgeInsets.only(
                          top: processTopPosition(moveUpIconWhenRelease.value),
                          left: moveLeftIconAngryWhenRelease.value,
                        ),
                        child: Transform.scale(
                          scale: zoomIconWhenRelease.value,
                          child: Image.asset(
                            widget.angryGif ?? 'packages/social_feed_reaction/images/angry.gif',
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderBox() {
    return Opacity(
      opacity: fadeInBox.value,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey.shade300, width: 0.3),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
// LT-RB
                offset: Offset.lerp(const Offset(0.0, 0.0), const Offset(0.0, 0.5), 10.0)!),
          ],
        ),
        width: 300.0,
        height: isDragging
            ? (previousIconFocus == 0 ? zoomBoxIcon.value : 40.0)
            : isDraggingOutside
                ? zoomBoxWhenDragOutside.value
                : 50.0,
        margin: const EdgeInsets.only(bottom: 130.0, left: 10.0),
      ),
    );
  }

  Widget renderIcons() {
    return Container(
      width: 300.0,
      height: 250.0,
      margin: EdgeInsets.only(left: moveRightGroupIcon.value, top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
// icon like
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 1
                    ? zoomIconChosen.value
                    : (previousIconFocus == 1
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconLike.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconLikeUp.value),
              width: 40.0,
              height: currentIconFocus == 1 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 1
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.likeText ?? 'Like',
                            style: const TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                  Image.asset(
                    widget.likeGif ?? 'packages/social_feed_reaction/images/like.gif',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

// icon love
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 2
                    ? zoomIconChosen.value
                    : (previousIconFocus == 2
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconLove.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconLoveUp.value),
              width: 40.0,
              height: currentIconFocus == 2 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 2
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0), color: Colors.black.withOpacity(0.3)),
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.loveText ?? 'Love',
                            style: const TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                  Image.asset(
                    widget.loveGif ?? 'packages/social_feed_reaction/images/love.gif',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

// icon haha
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 3
                    ? zoomIconChosen.value
                    : (previousIconFocus == 3
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconHaha.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconHahaUp.value),
              width: 40.0,
              height: currentIconFocus == 3 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 3
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0), color: Colors.black.withOpacity(0.3)),
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.hahaText ?? 'Haha',
                            style: const TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                  Image.asset(
                    widget.hahaGif ?? 'packages/social_feed_reaction/images/haha.gif',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

// icon wow
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 4
                    ? zoomIconChosen.value
                    : (previousIconFocus == 4
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconWow.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconWowUp.value),
              width: 40.0,
              height: currentIconFocus == 4 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 4
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0), color: Colors.black.withOpacity(0.3)),
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.wowText ?? 'Wow',
                            style: const TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                  Image.asset(
                    widget.wowGif ?? 'packages/social_feed_reaction/images/wow.gif',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

// icon sad
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 5
                    ? zoomIconChosen.value
                    : (previousIconFocus == 5
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconSad.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconSadUp.value),
              width: 40.0,
              height: currentIconFocus == 5 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 5
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.sadText ?? 'Sad',
                            style: const TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                  Image.asset(
                    widget.sadGif ?? 'packages/social_feed_reaction/images/sad.gif',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

// icon angry
          Transform.scale(
            scale: isDragging
                ? (currentIconFocus == 6
                    ? zoomIconChosen.value
                    : (previousIconFocus == 6
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconAngry.value,
            child: Container(
              margin: EdgeInsets.only(bottom: pushIconAngryUp.value),
              width: 40.0,
              height: currentIconFocus == 6 ? 70.0 : 40.0,
              child: Column(
                children: <Widget>[
                  currentIconFocus == 6
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.angryText ?? 'Angry',
                            style: const TextStyle(fontSize: 8.0, color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                  Image.asset(
                    widget.angryGif ?? 'packages/social_feed_reaction/images/angry.gif',
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
// uncomment here to see area of draggable
// color: Colors.amber.withOpacity(0.5),
    );
  }

  Widget renderBtnLike() {
    return Container(
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        border: Border.all(color: getColorBorderBtn()),
      ),
      margin: const EdgeInsets.only(top: 190.0),
      child: GestureDetector(
        onTapDown: onTapDownBtn,
        onTapUp: onTapUpBtn,
        onTap: onTapBtn,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
// Icon like
              Transform.scale(
                scale:
                    !isLongPress ? handleOutputRangeZoomInIconLike(zoomIconLikeInBtn2.value) : zoomIconLikeInBtn.value,
                child: Transform.rotate(
                  angle:
                      !isLongPress ? handleOutputRangeTiltIconLike(tiltIconLikeInBtn2.value) : tiltIconLikeInBtn.value,
                  child: Image.asset(
                    getImageIconBtn(),
                    width: 25.0,
                    height: 25.0,
                    fit: BoxFit.contain,
                    color: getTintColorIconBtn(),
                  ),
                ),
              ),

// Text like
              Transform.scale(
                scale:
                    !isLongPress ? handleOutputRangeZoomInIconLike(zoomIconLikeInBtn2.value) : zoomTextLikeInBtn.value,
                child: Text(
                  getTextBtn(),
                  style: TextStyle(
                    color: getColorTextBtn(),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTextBtn() {
    if (isDragging) {
      return widget.likeText ?? 'Like';
    }
    switch (whichIconUserChoose) {
      case 1:
        return widget.likeText ?? 'Like';
      case 2:
        return widget.loveText ?? 'Love';
      case 3:
        return widget.hahaText ?? 'Haha';
      case 4:
        return widget.wowText ?? 'Wow';
      case 5:
        return widget.sadText ?? 'Sad';
      case 6:
        return widget.angryText ?? 'Angry';
      default:
        return widget.likeText ?? 'Like';
    }
  }

  Color getColorTextBtn() {
    if ((!isLongPress && isLiked)) {
      return const Color(0xff3b5998);
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return const Color(0xff3b5998);
        case 2:
          return const Color(0xffED5167);
        case 3:
        case 4:
        case 5:
          return const Color(0xffFFD96A);
        case 6:
          return const Color(0xffF6876B);
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }

  String getImageIconBtn() {
    if (!isLongPress && isLiked) {
      return widget.likeFillPng ?? 'packages/social_feed_reaction/images/ic_like_fill.png';
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return widget.likeFillPng ?? 'packages/social_feed_reaction/images/ic_like_fill.png';
        case 2:
          return widget.lovePng ?? 'packages/social_feed_reaction/images/love2.png';
        case 3:
          return widget.hahaPng ?? 'packages/social_feed_reaction/images/haha2.png';
        case 4:
          return widget.wowPng ?? 'packages/social_feed_reaction/images/wow2.png';
        case 5:
          return widget.sadPng ?? 'packages/social_feed_reaction/images/sad2.png';
        case 6:
          return widget.angryPng ?? 'packages/social_feed_reaction/images/angry2.png';
        default:
          return widget.likePng ?? 'packages/social_feed_reaction/images/ic_like.png';
      }
    } else {
      return widget.likePng ?? 'packages/social_feed_reaction/images/ic_like.png';
    }
  }

  Color? getTintColorIconBtn() {
    if (!isLongPress && isLiked) {
      return const Color(0xff3b5998);
    } else if (!isDragging && whichIconUserChoose != 0) {
      return null;
    } else {
      return Colors.grey;
    }
  }

  double processTopPosition(double value) {
// margin top 100 -> 40 -> 160 (value from 180 -> 0)
    if (value >= 120.0) {
      return value - 80.0;
    } else {
      return 160.0 - value;
    }
  }

  Color getColorBorderBtn() {
    if ((!isLongPress && isLiked)) {
      return const Color(0xff3b5998);
    } else if (!isDragging) {
      switch (whichIconUserChoose) {
        case 1:
          return const Color(0xff3b5998);
        case 2:
          return const Color(0xffED5167);
        case 3:
        case 4:
        case 5:
          return const Color(0xffFFD96A);
        case 6:
          return const Color(0xffF6876B);
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey.shade400;
    }
  }

  void onHorizontalDragEndBoxIcon(DragEndDetails dragEndDetail) {
    isDragging = false;
    isDraggingOutside = false;
    isJustDragInside = true;
    previousIconFocus = 0;
    currentIconFocus = 0;

    onTapUpBtn(null);
  }

  void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
// return if the drag is drag without press button
    if (!isLongPress) return;

// the margin top the box is 150
// and plus the height of toolbar and the status bar
// so the range we check is about 200 -> 500

    if (dragUpdateDetail.globalPosition.dy >= 200 && dragUpdateDetail.globalPosition.dy <= 500) {
      isDragging = true;
      isDraggingOutside = false;

      if (isJustDragInside && !animControlIconWhenDragInside.isAnimating) {
        animControlIconWhenDragInside.reset();
        animControlIconWhenDragInside.forward();
      }

      if (dragUpdateDetail.globalPosition.dx >= 20 && dragUpdateDetail.globalPosition.dx < 83) {
        if (currentIconFocus != 1) {
          handleWhenDragBetweenIcon(1);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 83 && dragUpdateDetail.globalPosition.dx < 126) {
        if (currentIconFocus != 2) {
          handleWhenDragBetweenIcon(2);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 126 && dragUpdateDetail.globalPosition.dx < 180) {
        if (currentIconFocus != 3) {
          handleWhenDragBetweenIcon(3);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 180 && dragUpdateDetail.globalPosition.dx < 233) {
        if (currentIconFocus != 4) {
          handleWhenDragBetweenIcon(4);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 233 && dragUpdateDetail.globalPosition.dx < 286) {
        if (currentIconFocus != 5) {
          handleWhenDragBetweenIcon(5);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 286 && dragUpdateDetail.globalPosition.dx < 340) {
        if (currentIconFocus != 6) {
          handleWhenDragBetweenIcon(6);
        }
      }
    } else {
      whichIconUserChoose = 0;
      previousIconFocus = 0;
      currentIconFocus = 0;
      isJustDragInside = true;

      if (isDragging && !isDraggingOutside) {
        isDragging = false;
        isDraggingOutside = true;
        animControlIconWhenDragOutside.reset();
        animControlIconWhenDragOutside.forward();
        animControlBoxWhenDragOutside.reset();
        animControlBoxWhenDragOutside.forward();
      }
    }
  }

  void handleWhenDragBetweenIcon(int currentIcon) {
    playSound('icon_focus.mp3');
    whichIconUserChoose = currentIcon;
    previousIconFocus = currentIconFocus;
    currentIconFocus = currentIcon;
    animControlIconWhenDrag.reset();
    animControlIconWhenDrag.forward();
  }

  void onTapDownBtn(TapDownDetails tapDownDetail) {
    holdTimer = Timer(durationLongPress, showBox);
  }

  void onTapUpBtn(TapUpDetails? tapUpDetail) {
    if (isLongPress) {
      if (whichIconUserChoose == 0) {
        playSound('box_down.mp3');
      } else {
        playSound('icon_choose.mp3');
      }
    }

    Timer(Duration(milliseconds: durationAnimationBox), () {
      isLongPress = false;
    });

    holdTimer.cancel();

    animControlBtnLongPress.reverse();

    setReverseValue();
    animControlBox.reverse();

    animControlIconWhenRelease.reset();
    animControlIconWhenRelease.forward();
  }

// when user short press the button
  void onTapBtn() {
    if (!isLongPress) {
      if (whichIconUserChoose == 0) {
        isLiked = !isLiked;
      } else {
        whichIconUserChoose = 0;
      }
      if (isLiked) {
        playSound('short_press_like.mp3');
        animControlBtnShortPress.forward();
      } else {
        animControlBtnShortPress.reverse();
      }
    }
  }

  double handleOutputRangeZoomInIconLike(double value) {
    if (value >= 0.8) {
      return value;
    } else if (value >= 0.4) {
      return 1.6 - value;
    } else {
      return 0.8 + value;
    }
  }

  double handleOutputRangeTiltIconLike(double value) {
    if (value <= 0.2) {
      return value;
    } else if (value <= 0.6) {
      return 0.4 - value;
    } else {
      return -(0.8 - value);
    }
  }

  void showBox() {
    playSound('box_up.mp3');
    isLongPress = true;

    animControlBtnLongPress.forward();

    setForwardValue();
    animControlBox.forward();
  }

// We need to set the value for reverse because if not
// the angry-icon will be pulled down first, not the like-icon
  void setReverseValue() {
// Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );
  }

// When set the reverse value, we need set value to normal for the forward
  void setForwardValue() {
// Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.4, 0.9)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: const Interval(0.5, 1.0)),
    );
  }

  /// under construction this sides
  /// sound effect is not fully functional
  Future playSound(String nameSound) async {
// Sometimes multiple sound will play the same time, so we'll stop all before play the newest
    AudioPlayer player = AudioPlayer();
    await audioPlayer.stop();
    final file = File('${(await getTemporaryDirectory()).path}/$nameSound');
    await file.writeAsBytes((await loadAsset(nameSound)).buffer.asUint8List());
    audioPlayer.play(player.source!);
  }

  Future loadAsset(String nameSound) async {
    return await rootBundle.load('sounds/$nameSound');
  }
}
