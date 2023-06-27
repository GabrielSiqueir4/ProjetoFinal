import 'package:calendarioprova/Widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/Evento_controller.dart';
import '../models/Evento.dart';

class EventoTile extends StatelessWidget {
  final _eventoController = Get.put(EventoController());
  final Evento? evento;
  EventoTile(this.evento);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGclr(evento?.cor ?? 0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento?.titulo ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              Get.isDarkMode ? Colors.white : Colors.grey[200]),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Get.isDarkMode
                                ? Colors.white
                                : Colors.grey[200],
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${evento!.horaInicial} - ${evento!.horaFinal}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.grey[200]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    evento?.local ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color:
                              Get.isDarkMode ? Colors.white : Colors.grey[200]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[100]!.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }

  _getBGclr(int no) {
    switch (no) {
      case 0:
        return greenClr;
      case 1:
        return pinkClr;
      case 2:
        return blueClr;
      case 3:
        return ambarClr;
      case 4:
        return orageClr;
      default:
        return greenClr;
    }
  }
}
