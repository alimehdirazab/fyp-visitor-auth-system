import 'package:flutter/material.dart';
import 'package:fyp/presentation/pages/Staff/Security_Screens/home/security_home_screen.dart';
import 'package:fyp/presentation/widgets/custom_dialog_box.dart';
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

  void _showCustomDialog(BuildContext context, String title, String description,
      void Function() onOkPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          description: description,
          onOkPressed: onOkPressed,
        );
      },
    );
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
                _showCustomDialog(context, 'Successfully Scaned',
                    'This is Authorized Visitor', () {
                  Navigator.pushNamed(context, SecurityHomeScreen.routeName);
                });
              }
            },
            builder: (context, state) {
              if (state is VerifyQRCodeLoadingState) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
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
