import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_bella_vista/data/services/habitacionesService.dart';
import 'package:hotel_bella_vista/data/state/state.dart';
import 'package:hotel_bella_vista/domain/models/habitacion.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/addhabitacion_screen.dart';
import 'package:hotel_bella_vista/ui/pages/habitacion/detalle_habitacion_screen.dart';

class HabitacionkshelfScreen extends StatelessWidget {
  const HabitacionkshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HabshelfBloc, HabitacionShelState>(
        builder: (context, habitacionshelfState) {
          var widget = habitacionshelfState.habIds.isEmpty
              ? Center(
                  child: Text(
                    'Aun No tiene Habitaciones Favoritas Agregadas',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                )
              : Myhabitacion(habitacionshelfState.habIds);
          return Column(
            children: [
              Expanded(child: widget),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/listahabitaciones');
                },
                child: const Text('Agregar favoritos ❤️'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _navigateToAddBookScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EditHabitacionScreen()));
  }
}

class Myhabitacion extends StatelessWidget {
  final List<String> habitacionIds;
  const Myhabitacion(this.habitacionIds, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: habitacionIds.length,
        itemBuilder: (BuildContext context, int index) {
          return HabitacionCoverItem(habitacionIds[index]);
        },
      ),
    );
  }
}

class HabitacionCoverItem extends StatefulWidget {
  final String _bookId;
  const HabitacionCoverItem(this._bookId, {super.key});

  @override
  State<HabitacionCoverItem> createState() => HabitacionCoverItemState();
}

class HabitacionCoverItemState extends State<HabitacionCoverItem> {
  HabitacionHotel? _habitacion;

  @override
  void initState() {
    super.initState();
    _getBook(widget._bookId);
  }

  void _getBook(String bookId) async {
    var book = await HabitacionesService().getHabitacion(bookId);
    setState(() {
      _habitacion = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_habitacion == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return InkWell(
      onTap: () {
        _openHabitacionDetails(context, _habitacion!);
      },
      child: Ink.image(
        fit: BoxFit.fill,
        image: _getImageWidget(_habitacion!.imagenes),
      ),
    );
  }

  void _openHabitacionDetails(BuildContext context, HabitacionHotel habi) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HabitacionDetailsScreen(
                  habitacion: habi,
                )));
  }

  _getImageWidget(String coverUrl) {
    if (coverUrl.startsWith('http')) {
      return NetworkImage(coverUrl);
    } else {
      return AssetImage(coverUrl);
    }
  }
}
