import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de Contacto'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContactIcon(
                icon: Icons.phone,
                label: 'WhatsApp',
                url: 'https://wa.me/573104956725',
              ),
              SizedBox(
                height: 13,
              ),
              ContactIcon(
                icon: Icons.facebook,
                label: 'Facebook',
                url: 'https://www.facebook.com/Mateorodriguez61',
              ),
              SizedBox(
                height: 13,
              ),
              ContactIcon(
                icon: Icons.camera_alt_outlined,
                label: 'Email',
                url:
                    'https://instagram.com/mateorodriguezmobter?igshid=MzMyNGUyNmU2YQ==',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ContactIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const ContactIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: deprecated_member_use
        launch(url);
      },
      child: Column(
        children: [
          const SizedBox(height: 10),
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
