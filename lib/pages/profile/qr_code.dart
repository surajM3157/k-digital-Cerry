import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piwotapp/pages/profile/qrcode_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../repository/api_repo.dart';
import '../../responses/qrcode_response.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width - 30
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 10,
        borderLength: 35,
        borderWidth: 17,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print('Scanned Code: ${scanData.code}');
      controller.pauseCamera();
      _handleScanResult(scanData);
    });
  }

  void _handleScanResult(Barcode scanData) async {
    String? scannedCode = scanData.code;
    if (scannedCode != null && scannedCode.isNotEmpty) {
      print('Barcode Code scanned: $scannedCode');

      try {
        QRCodeResponse qrDetails = await ApiRepo().getQRCodeDetails(scannedCode);

        print('API Response: ${qrDetails.toString()}');

        if (qrDetails.status == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRDetailsScreen(qrCodeDetails: qrDetails),
            ),
          );
        } else {
          EasyLoading.showToast(
            'No details found for the scanned code.',
            dismissOnTap: true,
            duration: const Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.center,
          );
        }
      } catch (e) {
        print('Error fetching details: $e');
        EasyLoading.showToast(
          'Error fetching details.',
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center,
        );
      }
    } else {
      print('Invalid code');
      EasyLoading.showToast(
        'Invalid QR Code.',
        dismissOnTap: true,
        duration: const Duration(seconds: 1),
        toastPosition: EasyLoadingToastPosition.center,
      );
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1464),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 60),
            child: Text(
              "Scan QR Code",
              style: TextStyle(
                color: Colors.white, // Title text color
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _buildQrView(context),
        ],
      ),
    );
  }
}
