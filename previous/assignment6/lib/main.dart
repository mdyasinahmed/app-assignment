import 'package:flutter/material.dart';

void main() {
  runApp(PhotoGalleryApp());
}

class PhotoGalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoGalleryHomePage(),
    );
  }
}

class PhotoGalleryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome to our Photo Gallery!',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter something...',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Image $index clicked!'),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.network('https://via.placeholder.com/150'),
                          Text('Image $index'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Sample Photo 1'),
              subtitle: Text('Subtitle 1'),
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Sample Photo 2'),
              subtitle: Text('Subtitle 2'),
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Sample Photo 3'),
              subtitle: Text('Subtitle 3'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Photos Uploaded Successfully!'),
                  ),
                );
              },
              child: Text('Upload Photos'),
            ),
          ],
        ),
      ),
    );
  }
}
