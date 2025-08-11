import 'dart:async';

import 'package:flutter/material.dart';

void showCircularLoader(context, {String text = "Please wait"}) {
  showGeneralDialog(
    context: context!,
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context!).collapsedHint,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 50),
    pageBuilder:
        (
          BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation,
        ) {
          return StatefulBuilder(
            builder: (context, StateSetter setStateDialog) {
              return LoadingDialog(text: text);
            },
          );
        },
  );
}

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key, required this.text});
  final String text;
  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  String _loadingText = "";
  int _dotCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!mounted) return;
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
        _loadingText = "${widget.text}${"." * _dotCount}";
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            const ModalBarrier(dismissible: false, color: Colors.black45),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Image.asset(
                              // AppImages.appLogoBe,
                              "assets/images/logo.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                        const Center(
                          child: CircularProgressIndicator(
                            strokeAlign: 8,
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _loadingText,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
