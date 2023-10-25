import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/user_services.dart';

class Userscreen extends StatelessWidget {
  const Userscreen({Key? key});

  @override
  Widget build(BuildContext context) {
    UserController sc = Get.find();
    sc.consultarServicio();
    return Scaffold(
      body: Obx(() {
        if (sc.listafinal == null || sc.listafinal!.isEmpty) {
          return Center(
            child: Text('No hay elementos para mostrar'),
          );
        } else {
          return ListView.builder(
            itemCount: sc.listafinal!.length,
            itemBuilder: (context, position) {
              return Text(sc.listafinal![position].nombre);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/creararticulos');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
