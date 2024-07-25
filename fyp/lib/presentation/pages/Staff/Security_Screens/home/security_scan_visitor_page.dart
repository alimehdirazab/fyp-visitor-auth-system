import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';

class SecurityScanVisitorPage extends StatefulWidget {
  const SecurityScanVisitorPage({super.key});

  @override
  State<SecurityScanVisitorPage> createState() =>
      _SecurityScanVisitorPageState();
}

class _SecurityScanVisitorPageState extends State<SecurityScanVisitorPage> {
  Barcode? result;
  MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final barcode = capture.barcodes.first;
    setState(() {
      result = barcode;
    });

    controller.stop();
    final qrToken = barcode.rawValue;

    if (qrToken != null) {
      context.read<StaffCubit>().verifyQRCode(qrCode: qrToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Scan Visitor'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: controller,
              onDetect: (BarcodeCapture capture) => _onDetect(capture),
            ),
          ),
          BlocConsumer<StaffCubit, StaffState>(
            listener: (context, state) {
              if (state is VerifyQRCodeSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('QR Code is valid!')),
                );
              } else if (state is VerifyQRCodeErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is VerifyQRCodeLoadingState) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is VerifyQRCodeSuccessState) {
                return Expanded(
                  child: Center(
                    child: Text('Scanned QR Code: ${result?.rawValue}'),
                  ),
                );
              } else {
                return const Expanded(
                  child: Center(
                    child: Text('Scan a QR code'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
