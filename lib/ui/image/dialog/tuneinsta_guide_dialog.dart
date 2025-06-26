import 'package:app/services/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TuneinstaGuideDialog extends StatelessWidget {
  const TuneinstaGuideDialog({super.key});

  static Future<bool?> show(BuildContext context) => showDialog<bool>(
        context: context,
        barrierColor: Colors.black26,
        builder: (context) => const TuneinstaGuideDialog(),
      );

  Widget buildInfoBox({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    Color titleColor = Colors.white,
    Color messageColor = Colors.white70,
    double iconSize = 16,
    double titleFontSize = 14,
    double messageFontSize = 12,
    FontWeight titleWeight = FontWeight.bold,
    FontWeight messageWeight = FontWeight.w300,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: titleWeight,
                fontSize: titleFontSize,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          message,
          style: TextStyle(
            color: messageColor,
            fontWeight: messageWeight,
            fontSize: messageFontSize,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> checkboxValueNotifier = ValueNotifier<bool>(true);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff222222),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Tuneinsta Guide",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.brown.shade50,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 160,
              child: Image.asset(
                'assets/instagram_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            buildInfoBox(
              icon: Icons.warning,
              iconColor: Colors.yellow,
              title: 'Important',
              message:
                  'Instagram does not allow automatic music embedding from third-party apps.',
            ),
            const SizedBox(height: 16),
            buildInfoBox(
              icon: Icons.check_box,
              iconSize: 18,
              iconColor: Colors.lightGreen,
              title: 'What to do',
              message:
                  'Search for the suggested song manually on Instagram then add it to your story or post as usual.',
            ),
            const SizedBox(height: 16),
            buildInfoBox(
              icon: Icons.music_note,
              iconColor: Colors.white70,
              title: 'Tuneinsta',
              message: 'We make it easy, you make it yours.',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 25,
                  height: 40,
                  child: Material(
                    color: Colors.transparent,
                    child: ValueListenableBuilder<bool>(
                        valueListenable: checkboxValueNotifier,
                        builder: (context, state, _) {
                          return Checkbox(
                            value: state,
                            checkColor: Colors.brown,
                            activeColor: Colors.brown.shade50,
                            onChanged: (hideTuneinstaGuide) {
                              // update shared prefs
                              checkboxValueNotifier.value = hideTuneinstaGuide!;
                              Get.find<AppPreferences>()
                                  .setShouldShowTuneinstaGuide(
                                      !hideTuneinstaGuide);
                            },
                          );
                        }),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      checkboxValueNotifier.value = !checkboxValueNotifier.value;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      child: const Text(
                        'Do not show again.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // if the check box is ticked, then hide.
                Get.find<AppPreferences>().setShouldShowTuneinstaGuide(
                  !checkboxValueNotifier.value,
                );
                Navigator.pop(context, true);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Share Now",
                  style: TextStyle(
                    color: Colors.brown.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
