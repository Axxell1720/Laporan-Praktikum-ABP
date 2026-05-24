import 'package:flutter/material.dart';

void main() {
  runApp(const CinemaCribApp());
}

//Model Data Film
class Movie {
  final String title;
  final String genre;
  final String description;
  final String imageUrl;

  Movie({
    required this.title,
    required this.genre,
    required this.description,
    required this.imageUrl,
  });
}

//Data Film
final List<Movie> movieList = [
  Movie(
    title: 'Dune: Part Two',
    genre: 'Sci-Fi / Action',
    description: 'Paul Atreides bersatu dengan Chani dan Fremen untuk membalas dendam kepada para konspirator yang menghancurkan keluarganya.',
    imageUrl: 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2JGjjc9k.jpg',
  ),
  Movie(
    title: 'Oppenheimer',
    genre: 'Drama / History',
    description: 'Kisah J. Robert Oppenheimer dan perannya dalam pengembangan bom atom selama Perang Dunia II.',
    imageUrl: 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
  ),
  Movie(
    title: 'Spider-Man: Across the Spider-Verse',
    genre: 'Animation / Action',
    description: 'Miles Morales melintasi Multiverse, di mana ia bertemu dengan tim Spider-People yang ditugaskan untuk melindungi keberadaannya.',
    imageUrl: 'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
  ),
  Movie(
    title: 'The Batman',
    genre: 'Action / Crime',
    description: 'Saat seorang pembunuh berantai yang sadis mulai membunuh tokoh politik penting di Gotham, Batman terpaksa menyelidiki korupsi tersembunyi di kota tersebut.',
    imageUrl: 'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
  ),
];

class CinemaCribApp extends StatelessWidget {
  const CinemaCribApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinemaCrib',
      debugShowCheckedModeBanner: false,
      //Dark theme
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.orange,
        colorScheme: const ColorScheme.dark(
          primary: Colors.orange,
          secondary: Colors.orangeAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CinemaCrib',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
        ),
      ),
      //Menggunakan ListView
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          //Navigasi halaman saat item ditekan
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(movie: movie),
                ),
              );
            },
            //Menggunakan Container, Row/Column
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Gambar Poster film
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie.imageUrl,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80,
                        height: 120,
                        color: Colors.grey[800],
                        child: const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  //Menampilkan Judul dan Deskripsi Singkat
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.genre,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Poster Full
            Image.network(
              widget.movie.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: double.infinity,
                height: 300,
                color: Colors.grey[800],
                child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Genre: ${widget.movie.genre}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sinopsis:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const Divider(height: 40, color: Colors.grey),
                  
                  //Ulasan: Form Sederhana berisi TextField dan Button
                  const Text(
                    'Tinggalkan Ulasan Anda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _reviewController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Tulis ulasan film ini di sini...',
                      filled: true,
                      fillColor: const Color(0xFF2C2C2C),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black, //Warna teks tombol kirim ulasan
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        //Menampilkan Snackbar ketika tombol ditekan
                        if (_reviewController.text.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Ulasan untuk ${widget.movie.title} berhasil dikirim!'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          _reviewController.clear(); //Kosongkan textfield setelah kirim
                        } else {
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Ulasan tidak boleh kosong!'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Kirim Ulasan',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
