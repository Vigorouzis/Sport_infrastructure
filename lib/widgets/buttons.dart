import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final double width;
  final double height;
  final bool haveShadow;
  final Color color;
  final Color borderColor;
  final Color textColor;

  const DefaultButton(
      {@required this.onTap,
      this.label,
      this.width,
      this.height,
      this.haveShadow,
      this.color,
      this.borderColor,
      this.textColor,
      });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color,
              boxShadow: [
                if (haveShadow)
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.11),
                    offset: Offset(0, 0),
                    blurRadius: 11,
                  ),

              ],
              borderRadius: BorderRadius.circular(10.r)),
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: textColor ?? Colors.black),
            ),
          ),
        ),
      );
}
