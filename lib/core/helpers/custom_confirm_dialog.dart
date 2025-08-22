import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

Future<void> showCustomConfirmationDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onConfirmed,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: const Color(0xFF2C2E3E),
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Are you sure?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style: AppStyles.styleRegular16(
                      context,
                    ).copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        // backgroundColor: ColorsData.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirmed();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF3A3C4A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
