import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: const Text('Iniciar sesión')),
            ElevatedButton(
              onPressed: (){
                Get.toNamed('/panel');
            }, 
              child: const Text("Panel"))
          ],
        ),
      ),
    );
  }
}
