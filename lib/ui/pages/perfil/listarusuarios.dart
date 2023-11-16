import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/domain/controller/user_services.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/inputs_campos.dart';

class ListarUsuarios extends StatelessWidget {
  const ListarUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    UserController uc = Get.find();
    uc.consultarUsuarios();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
        backgroundColor: colors.primary,
      ),
      body: Stack(
        children: [
          const FondoFormulario(urlimage: 'assets/images/fondo_lista.jpeg'),
          Obx(() => ListView.builder(
                itemCount: uc.listafinal?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: uc.listafinal![index].imagen.isNotEmpty
                            ? Image.network(
                                uc.listafinal![index].imagen,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/camara.jpeg', // Replace with your default image asset path
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    title: Text(uc.listafinal![index].identificacion),
                    subtitle: Text(
                        "${uc.listafinal![index].nombre} ${uc.listafinal![index].apellido}"),
                    // trailing: IconButton(
                    //     onPressed: () {}, icon: const Icon(Icons.check))
                  );
                },
              )),
        ],
      ),
    );
  }
}
