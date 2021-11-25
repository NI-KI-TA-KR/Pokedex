import 'package:flutter/material.dart';
import 'package:poke_app/typedef.dart';
import 'package:poke_app/utils/style.dart';
import 'package:sizer/sizer.dart';

class PaginationWidget extends StatelessWidget {
  PaginationWidget({this.leftOnTap, this.rightOnTap});

  final OnTap? leftOnTap;
  final OnTap? rightOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 23.w),
      child: Row(
        children: [
          InkWell(
            onTap: leftOnTap,
            child: Text(
              "Previous",
              style: leftOnTap != null
                  ? TextStyles.styleBlack18Bold
                  : TextStyles.styleBlack18Bold.copyWith(
                      color: Colors.grey.withOpacity(0.5),
                    ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          InkWell(
            onTap: rightOnTap,
            child: Text(
              "Next",
              style: rightOnTap != null
                  ? TextStyles.styleBlack18Bold
                  : TextStyles.styleBlack18Bold.copyWith(
                      color: Colors.grey.withOpacity(0.5),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}