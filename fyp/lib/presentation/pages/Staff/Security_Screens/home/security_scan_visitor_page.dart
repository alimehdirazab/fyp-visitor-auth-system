import 'package:flutter/material.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityScanVisitorPage extends StatefulWidget {
  const SecurityScanVisitorPage({super.key});

  @override
  State<SecurityScanVisitorPage> createState() =>
      _SecurityScanVisitorPageState();
}

class _SecurityScanVisitorPageState extends State<SecurityScanVisitorPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();
      final qrToken = scanData.code;

      context.read<StaffCubit>().verifyQRCode(qrCode: qrToken!);
    });
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
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
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
                    child: Text('Scanned QR Code: ${result!.code}'),
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
