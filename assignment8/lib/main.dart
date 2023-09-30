import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return PortraitProfile();
          } else {
            return LandscapeProfile();
          }
        },
      ),
    );
  }
}

class PortraitProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/profile_image.jpg'),
        ),
        SizedBox(height: 16),
        Text(
          'John Doe',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        GalleryGrid(),
      ],
    );
  }
}

class LandscapeProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GalleryGrid(),
        ),
      ],
    );
  }
}

class GalleryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: 6, // 2 rows x 3 columns
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gallery_image$index.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(1, index.isEven ? 1.5 : 1.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
