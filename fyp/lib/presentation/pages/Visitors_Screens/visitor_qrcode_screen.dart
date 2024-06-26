import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitorQrcodeScreen extends StatelessWidget {
  final String? qrToken;
  final String? visitorName;
  final String? visitorProfilePicture;

  const VisitorQrcodeScreen({
    super.key,
    required this.qrToken,
    required this.visitorName,
    required this.visitorProfilePicture,
  });

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
                          visitorName ?? 'Unknown Visitor',
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
                            child: QrImageView(
                              data: qrToken!,
                              version: QrVersions.auto,
                              size: 230,
                            )),
                      ],
                    ),
                  ),
                ),
                ClipOval(
                  child: visitorProfilePicture != null
                      ? CachedNetworkImage(
                          imageUrl: visitorProfilePicture!,
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person, size: 120),
                        )
                      : const Icon(Icons.person, size: 75, color: Colors.grey),
                ),
              ],
            ),
            const GapWidget(),
            const Text('Scan The QR Code From Security Guard'),
          ],
        ),
      ),
    );
  }
}
