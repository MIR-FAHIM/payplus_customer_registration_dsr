import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:latest_payplus_agent/app/modules/eTicket/bus_ticket/views/bus_report_drawer_view.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../common/Color.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/auth_service.dart';

class BusTicketWeb extends StatefulWidget {
  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<BusTicketWeb> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  PullToRefreshController? pullToRefreshController;

  late ContextMenu contextMenu;
  String url = "";
  bool shareButton = false;
  double progress = 0;
  final urlController = TextEditingController();
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> downloadFile(String url) async {
    var request = await http.get(Uri.parse(url));
    var bytes = request.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/sample.pdf");
    await file.writeAsBytes(bytes);
    print('File downloaded at: ${file.path}');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();
        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        } else {
          Get.offAllNamed(Routes.ROOT);
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          endDrawer: BusReportDrawer(),
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text("Bus Ticket".tr),
            centerTitle: true,

          ),
          body: Stack(
            children: [
              InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  useOnDownloadStart: true,
                  transparentBackground: true,
                )),
                //
                initialUrlRequest: URLRequest(
                 // url: Uri.parse("https://shl.com.bd/ticket/bus/agent/ticket-details/639"),
                  url: WebUri("https://shl.com.bd/ticket/bus/agent"),
                  headers: {
                    "msisdn":
                        Get.find<AuthService>().currentUser.value.mobileNumber!,
                    "token": Get.find<AuthService>().currentUser.value.busToken!
                  },
                ),
                onLoadStart: (InAppWebViewController controller, url) {
                  print("i am here 11");
                  print("onLoadStart++++++++++++++++++++++++++ " +
                      url.toString());
                  if( url.toString().contains("ticket-details/")){
                    setState(() {
                      shareButton = true;
                    });
                  }
                },
                onDownloadStartRequest: (controller, url) {
                  // downloadFile(url.url.toString());
                  print("download url is ${url.url}");
                  _launchUrl(url.url);
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
              ),
              _progress < 1
                  ? Container(
                      child: LinearProgressIndicator(
                        value: _progress,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
