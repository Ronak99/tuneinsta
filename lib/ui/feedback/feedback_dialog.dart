import 'package:app/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({super.key});

  static show({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const FeedbackDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String? email;
    String? feedback;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Provide Feedback",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address.';
                    }
                    // Basic email validation
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email Address",
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                TextFormField(
                  maxLines: 8,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please provide your feedback';
                    }
                    if (value.trim().length < 15) {
                      return 'Man of a few words? It would help if you could be a bit more verbose on this feedback.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    feedback = value;
                  },
                  decoration: const InputDecoration(
                    hintText:
                        "Thank you for taking the time out. Your feedback is invaluable to me.\n\nPlease provide a valid email, so that I can reach out to you in case I need more clarification on your requirements or feature suggestions.",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    errorMaxLines: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            Get.find<DbService>().saveFeedback(
                              email: email!,
                              feedback: feedback!,
                            );

                            // show snackbar that the feedback has been submitted
                            const snackBar = SnackBar(
                              content: Text("Thank you for your feedback 😁"),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
