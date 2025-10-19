import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latest_payplus_agent/common/ui.dart';


/// Maps connectivity status to:
/// 0 = No Internet, 1 = Wi-Fi/LAN/VPN/Other, 2 = Mobile
class ConnectivityController extends GetxController {
  final RxInt connectionType = 0.obs;

  final Connectivity _connectivity = Connectivity();

  // Since connectivity_plus v6, the stream emits List<ConnectivityResult>
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    // Get initial state
    getConnectionType();
    // Listen for subsequent changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  /// Checks the current connectivity and updates state.
  Future<void> getConnectionType() async {
    try {
      final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
      _updateState(results);
    } on PlatformException catch (e) {
      // Surface a non-blocking error toast; keep previous state.
      // You can also log this to Crashlytics/Sentry if you use them.
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          title: 'Connectivity check failed',
          message: e.message ?? e.toString(),
        ),
      );
    }
  }

  /// Applies prioritization when multiple transports are active.
  /// Priority: Wi-Fi > Mobile > (Ethernet/VPN/Bluetooth/Other) > None
  void _updateState(List<ConnectivityResult> results) {
    // Normalize: empty list means "none"
    final set = results.toSet();

    if (set.contains(ConnectivityResult.none) || set.isEmpty) {
      connectionType.value = 0;
    } else if (set.contains(ConnectivityResult.wifi)) {
      connectionType.value = 1;
    } else if (set.contains(ConnectivityResult.mobile)) {
      connectionType.value = 2;
    } else if (set.contains(ConnectivityResult.ethernet) ||
        set.contains(ConnectivityResult.vpn) ||
        set.contains(ConnectivityResult.bluetooth) ||
        set.contains(ConnectivityResult.other)) {
      // Treat all other network types as "connected" and group them with Wi-Fi = 1
      connectionType.value = 1;
    } else {
      // Extremely defensive fallback; notify the user once.
      connectionType.value = 0;
      Get.showSnackbar(
        Ui.ErrorSnackBar(
          title: 'Unknown network type',
          message: 'Please check your internet connection and try again.',
        ),
      );
    }

    // Notify GetBuilder/Obx consumers if you’re using GetBuilder<> patterns.
    update();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
