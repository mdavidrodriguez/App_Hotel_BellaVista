import 'package:flutter/material.dart';
//import 'package:hotel_bella_vista/ui/pages/PanelPrincipal/widgets/reservation_card.dart';
import 'package:hotel_bella_vista/ui/pages/PanelPrincipal/widgets/room_card.dart';

class PanelView extends StatelessWidget {
  const PanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cards'),
        ),
        body: const CardsView());
  }
}
