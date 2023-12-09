import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

extension AppGradient on Gradient {
  static LinearGradient settingsGradient() {
    return LinearGradient(
        colors: <Color>[
          AppColors.pastelPurple,
          AppColors.deepBlue,
          AppColors.darkBlue,
          AppColors.deepBlue,
          AppColors.pastelPurple,
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter
    );
  }
  static LinearGradient cardGradient(){
    return LinearGradient(
        colors: <Color>[
          AppColors.pastelPurple,
          AppColors.deepBlue,
        ]
    );
  }
  static LinearGradient backgroundGradient(){
    return LinearGradient(
        colors: <Color>[
          AppColors.paleGrey,
          AppColors.paleBlue,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
    );
  }
  static LinearGradient backgroundGradient2(){
    return LinearGradient(
        colors: <Color>[
          AppColors.paleBlue,
          AppColors.paleGrey,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
    );
  }
}
