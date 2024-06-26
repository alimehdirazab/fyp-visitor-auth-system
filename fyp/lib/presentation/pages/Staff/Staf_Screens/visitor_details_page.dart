import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fyp/core/ui.dart';
import 'package:fyp/presentation/pages/Staff/Staf_Screens/widgets/zoomable_image_view.dart';
import 'package:fyp/presentation/widgets/gap_widget.dart';
import 'package:fyp/presentation/widgets/visitor_details_tile.dart';

class VisitorDetailsPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String profilePic;
  final String cnicFrontPic;
  final String cnicBackPic;

  const VisitorDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePic,
    required this.cnicFrontPic,
    required this.cnicBackPic,
  });

  @override
  _VisitorDetailsPageState createState() => _VisitorDetailsPageState();
}

class _VisitorDetailsPageState extends State<VisitorDetailsPage> {
  @override
  void initState() {
    super.initState();
    _secureScreen();
  }

  Future<void> _secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void _openImageView(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZoomableImageView(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Visitor Details', style: TextStyles.heading2),
              const SizedBox(height: 16),
              VisitorDetailsTile(
                leadingIcon: Icons.person,
                title: 'Name',
                subtitle: widget.name,
              ),
              VisitorDetailsTile(
                leadingIcon: Icons.email,
                title: 'Email',
                subtitle: widget.email,
              ),
              VisitorDetailsTile(
                leadingIcon: Icons.phone,
                title: 'Phone',
                subtitle: widget.phone,
              ),
              const GapWidget(),
              Text('Visitor Profile Picture', style: TextStyles.body2),
              const GapWidget(),
              GestureDetector(
                onTap: () => _openImageView(context, widget.profilePic),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: CachedNetworkImage(
                    imageUrl: widget.profilePic,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              const GapWidget(),
              Text('Visitor Front CNIC Picture', style: TextStyles.body2),
              const GapWidget(),
              GestureDetector(
                onTap: () => _openImageView(context, widget.cnicFrontPic),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: CachedNetworkImage(
                    imageUrl: widget.cnicFrontPic,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              const GapWidget(),
              Text('Visitor Back CNIC Picture', style: TextStyles.body2),
              const GapWidget(),
              GestureDetector(
                onTap: () => _openImageView(context, widget.cnicBackPic),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: CachedNetworkImage(
                    imageUrl: widget.cnicBackPic,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
