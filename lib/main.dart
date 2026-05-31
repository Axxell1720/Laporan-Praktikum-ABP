import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery Kamera',
      theme: ThemeData.dark(),
      home: const GalleryPage(),
    );
  }
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  final List<XFile> _photos = [];

  Future<void> _ambilFoto() async {

    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );

    if (photo != null) {

      setState(() {
        _photos.add(photo);
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text(
          "Gallery Kamera",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _ambilFoto,
        backgroundColor: const Color(0xFF6366F1),
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: _photos.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
                      Icons.photo_library_outlined,
                      size: 80,
                      color: Colors.white.withOpacity(0.5),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Belum ada foto",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Tekan tombol + untuk mengambil foto",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              )

            : GridView.builder(

                itemCount: _photos.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),

                itemBuilder: (context, index) {

                  return Stack(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),

                        child: Image.file(
                          File(_photos[index].path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      Positioned(
                        top: 8,
                        right: 8,

                        child: GestureDetector(

                          onTap: () {

                            setState(() {
                              _photos.removeAt(index);
                            });

                          },

                          child: Container(
                            padding: const EdgeInsets.all(6),

                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}