import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterappdev/helpers/loading/loading_screen_controller.dart';

class LoadingScreen {
  // create a named private constructor of the loading screen class
  LoadingScreen._shared();
  // create a static final field which is also a private field of different name and equate it to
  // the named private constructor
  static final LoadingScreen _sharedInstance = LoadingScreen._shared();
  // factory method of the class which can only be instantiated once is equated to static field
  factory LoadingScreen() => _sharedInstance;

  LoadingScreenController? controller;
  // showOverlay is going to return an instance of the loading screen controller
  void show({required BuildContext context, required String text}) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textController = StreamController<String>();
    // adding the text parameter into the stream controller
    textController.add(text);
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              // a Way to seperate the overlay from the background
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                // what this does is that it does not scroll the contents if there is enough space
                // to be displayed on the container but if the contents overflows the container
                // it gives the user the ability to scroll
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20.0),
                      StreamBuilder(
                        stream: textController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data as String,
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);
    return LoadingScreenController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
