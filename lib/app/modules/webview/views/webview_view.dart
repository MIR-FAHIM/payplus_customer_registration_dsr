import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/common/ui.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/webview_controller.dart';
import 'package:flutter/cupertino.dart';

class WebviewView extends GetView<WebviewController> {
  final GlobalKey webViewKey = GlobalKey();

  // InAppWebViewController? webViewController;
  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //     crossPlatform: InAppWebViewOptions(
  //       useShouldOverrideUrlLoading: true,
  //       mediaPlaybackRequiresUserGesture: false,
  //     ),
  //     android: AndroidInAppWebViewOptions(
  //       useHybridComposition: true,
  //     ),
  //     ios: IOSInAppWebViewOptions(
  //       allowsInlineMediaPlayback: true,
  //     ));

  String url = "";

  var source = '''
<input type="tel"/>
  inputs = document.querySelectorAll("input[type=tel]");
   input = document.querySelectorAll("input[type=tel]");
''';

  @override
  Widget build(BuildContext context) {
    var Url = controller.paymentUrl.value;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Get.theme.splashColor,
      appBar: PreferredSize(
        preferredSize: Size(65, 65),
        child: AppBar(
          backgroundColor: Color(0xFF652981),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(controller.title.value.tr),
          elevation: 0,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios),
          //   onPressed: () => Get.offAllNamed(Routes.ROOT),
          // ),
        ),
      ),
      body: WillPopScope(onWillPop: () {
        Get.offAllNamed(Routes.ROOT);
        return Future.value(false);
      }, child: Obx(() {
        return Stack(
          children: <Widget>[
            WebView(
              initialUrl: controller.paymentUrl.value,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) async {
                controller.webcontroller.complete(webViewController);
              },
              onPageStarted: (String string) async {
                print("my page url is $string");
              },
              onPageFinished: (finish) {
                print(finish);

                controller.isLoaded.value = true;
              },
              onWebResourceError: (error) {
                print(error.description);
              },
            ),
            controller.isLoaded.isFalse ? Center(child: Ui.customLoader()) : Wrap(),
          ],
        );
      })

          // InAppWebView(
          //   key: webViewKey,
          //   initialUrlRequest:
          //       URLRequest(url: Uri.parse(controller.paymentUrl.value)),
          //
          //   initialOptions: InAppWebViewGroupOptions(
          //       android: AndroidInAppWebViewOptions(
          //           mixedContentMode:
          //               AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW)),
          //
          //   onWebViewCreated: (controller) {
          //     webViewController = controller;
          //     webViewController!.evaluateJavascript(source: source);
          //   },
          //
          //   androidOnPermissionRequest: (controller, origin, resources) async {
          //     return PermissionRequestResponse(
          //         resources: resources,
          //         action: PermissionRequestResponseAction.GRANT);
          //   },
          //   onLoadStart: (webViewController, Url) async {
          //     var result =
          //         await webViewController.evaluateJavascript(source: "1 + 1");
          //     print(result.runtimeType); // int
          //     print(result); // 2
          //   },
          //   //   onProgressChanged: (wcontroller, progress) {
          //   //     if (progress == 100) {}
          //   //     controller.progress.value = 1.0;
          //   //   },
          //   //   onConsoleMessage: (controller, consoleMessage) {
          //   //     print(consoleMessage);
          //   //   },
          //   // ),
          //   // controller.progress.value < 1.0
          //   //     ? Center(
          //   //         child: Container(
          //   //           height: 100,
          //   //           width: 100,
          //   //           child: CircularProgressIndicator(),
          //   //         ),
          //   //       )
          //   //     : Container(),
          // ),
          ),

      // InAppWebView(
      //   initialUrlRequest: URLRequest(url: Uri.parse(controller.paymentUrl.value)),
      //   initialOptions: InAppWebViewGroupOptions(android: AndroidInAppWebViewOptions(mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW)),
      // ),
    );
  }
}
