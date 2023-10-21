import 'package:flutter/material.dart';
import 'package:hotel_bella_vista/data/services/habitacionesService.dart';

class AddHabitacionScreen extends StatelessWidget {
  const AddHabitacionScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar habitación'),
      ),
      body: const AddHabitacionForm(),
    );
  }
}

class AddHabitacionForm extends StatefulWidget {
  const AddHabitacionForm({Key? key});

  @override
  State<AddHabitacionForm> createState() => _AddHabitacionFormState();
}

class _AddHabitacionFormState extends State<AddHabitacionForm> {
  final nrohabitextController = TextEditingController();
  final tipohabTextController = TextEditingController();
  final preciNocheTextController = TextEditingController();
  final descripcionTextController = TextEditingController();
  final capacidadTextController = TextEditingController();
  bool isDisponible = false;
  final comodidadesTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: nrohabitextController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Numero de Habitación',
            ),
          ),
          TextFormField(
            controller: tipohabTextController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Tipo Habitacion',
            ),
          ),
          TextFormField(
            controller: preciNocheTextController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Precio Por Noche',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextFormField(
            controller: descripcionTextController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Descripción ',
            ),
          ),
          TextFormField(
            controller: capacidadTextController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Capacidad ',
            ),
            keyboardType: TextInputType.number, // Accepts int
          ),
          Row(
            children: [
              const Text('Disponible:'),
              Switch(
                value: isDisponible,
                onChanged: (value) {
                  setState(() {
                    isDisponible = value;
                  });
                },
              ),
            ],
          ),
          TextFormField(
            controller: comodidadesTextController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Capacidad ',
            ),
            keyboardType: TextInputType.number, // Accepts int
          ),
          ElevatedButton(
            onPressed: () {
              saveHabitacion();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void saveHabitacion() {
    var nrohabitacion = nrohabitextController.text;
    var tipohab = tipohabTextController.text;
    var precioNoche = double.tryParse(preciNocheTextController.text) ?? 0.0;
    var descripcion = descripcionTextController.text;
    var capacidad = int.tryParse(capacidadTextController.text) ?? 0;
    var comodidades = comodidadesTextController.text;

    HabitacionesService().saveHabitacion(
      nrohabitacion,
      tipohab,
      precioNoche,
      descripcion,
      capacidad,
      isDisponible, // Use isDisponible as boolean
      comodidades,
    );
  }
}
