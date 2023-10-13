import 'package:flutter/material.dart';
//import 'package:hotel_bella_vista/ui/pages/PanelPrincipal/widgets/reservation_card.dart';
import 'package:hotel_bella_vista/ui/pages/PanelPrincipal/widgets/room_card.dart';

class PanelView extends StatelessWidget {
  const PanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(150.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            RoomCard(),
            Spacer()
          ],
              ),
        ),
      
    );

  }
}