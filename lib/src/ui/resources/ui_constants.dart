import 'package:flutter/material.dart';

const compactSize = 600.0; /// phone
const mediumSize = 840.0; /// tablet
const largeSize = 1080.0; //large screen sized such as desktop


enum ScreenSize{
  compact, medium, expanded
}



const gapW4 = SizedBox(width: Sizes.p4);
const gapW8 = SizedBox(width: Sizes.p8);
const gapW12 = SizedBox(width: Sizes.p12);
const gapW16 = SizedBox(width: Sizes.p16);
const gapW32 = SizedBox(width: Sizes.p32);
const gapW64 = SizedBox(width: Sizes.p64);

const gapH4 = SizedBox(height: Sizes.p4);
const gapH8 = SizedBox(height: Sizes.p8);
const gapH12 = SizedBox(height: Sizes.p12);
const gapH16 = SizedBox(height: Sizes.p16);
const gapH32 = SizedBox(height: Sizes.p32);
const gapH64 = SizedBox(height: Sizes.p64);


class Sizes{
  static const double p4 = 4;
  static const double p8 = 8;
  static const double p12 = 12;
  static const double p16 = 16;
  static const double p32 = 32;
  static const double p64 = 64;
}