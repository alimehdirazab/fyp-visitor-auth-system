import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';

class VisitorQrcodeScreen extends StatelessWidget {
  const VisitorQrcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        const GapWidget(
                          size: 30,
                        ),
                        Text(
                          'Ali Mehdi Raza',
                          style: TextStyles.body1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Verified Visitor',
                          style: TextStyle(color: Colors.white),
                        ),
                        const GapWidget(size: 20),
                        Container(
                          color: Colors.white,
                          child: Image.asset(
                            'assets/images/smiu_qrcode.png',
                            height: 230,
                            width: 230,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/images/ali_mehdi_raza.jpg',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            const GapWidget(),
            const Text('Scan The QR Code From Security Guard')
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: Center(
      //     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //       Image.asset('assets/images/smiu_qrcode.png'),
      //       const Text(
      //           'Show This QrCode To Security Guard To Enter In University\n\n'),
      //       const Text(
      //         'Note This Qr Code will only Activate Before 15 mints form Your Meeting Time',
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       ),
      //     ]),
      //   ),
      // ),
    );
  }
}
