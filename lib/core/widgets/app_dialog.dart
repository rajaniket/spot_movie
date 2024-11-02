import 'dart:ui';

import 'package:flutter/material.dart';

Future<void> customDialog({
  required BuildContext context,
  String? title = 'Your Title',
  String? content = 'write something here',
  String yesButtonText = 'OK',
  String noButtonText = 'Cancel',
  void Function()? onNoPress,
  void Function()? onYesPress,
  bool barrierDismissible = true,
}) {
  return showDialog<String>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => Dialog(
      backgroundColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.white.withOpacity(0).withAlpha(60),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: title != null,
                  child: FittedBox(
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: content != null,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(content!),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: onNoPress != null,
                      child: TextButton(
                        onPressed: onNoPress,
                        child: Text(noButtonText),
                      ),
                    ),
                    Visibility(
                      visible: onYesPress != null,
                      child: TextButton(
                        onPressed: onYesPress,
                        child: Text(yesButtonText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
