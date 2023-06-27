import 'package:calendarioprova/Screens/Add_Evento.dart';
import 'package:calendarioprova/Services/Theme_Service.dart';
import 'package:calendarioprova/Widgets/Button.dart';
import 'package:calendarioprova/Widgets/theme.dart';
import 'package:calendarioprova/controller/Evento_controller.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../Widgets/Event_Box.dart';
import '../models/Evento.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _eventoController = Get.put(EventoController());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _addDate(),
          _addTarefa(),
          SizedBox(height: 15),
          _exibirEventos(),
        ],
      ),
    );
  }

  _exibirEventos() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _eventoController.eventoList.length,
          itemBuilder: (_, index) {
            Evento evento = _eventoController.eventoList[index];
            
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, evento);
                        },
                        child: EventoTile(evento),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }));
  }

  _showBottomSheet(BuildContext context, Evento evento) {
    Get.bottomSheet(
      Container(
        height: 200,
        color: Get.isDarkMode ? Colors.grey[900] : Colors.grey[200],
        child: Column(
          children: [
            SizedBox(height: 8),
            Container(
              height: 6,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[500],
              ),
            ),
            Spacer(),
            _botao(
              label: 'Apagar Evento',
              onTap: () {
                _eventoController.delete(evento);
                _eventoController.getEvento();
                Get.back();
              },
              clr: Colors.red[500]!,
            ),
            SizedBox(height: 20),
            _botao(
              label: 'Voltar',
              onTap: () {
                Get.back();
              },
              estafechado: true,
              clr: Colors.transparent,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _botao({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool estafechado = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            const EdgeInsetsDirectional.symmetric(horizontal: 40, vertical: 10),
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: estafechado == true ? Colors.grey[400]! : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: estafechado == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: estafechado ? Titulo : Titulo.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDate() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.green,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTarefa() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("d 'de' MMM 'de' y").format(
                    DateTime.now(),
                  ),
                  style: subTituloStyle,
                ),
                Text(
                  "Hoje",
                  style: TituloStyle,
                ),
              ],
            ),
          ),
          Button(
              label: '+ Novo Evento',
              onTap: () async {
                await Get.to(() => addTarefa());
                _eventoController.getEvento();
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      title: Text(
        'Agenda FAG',
        style: TituloStyle,
      ),
      centerTitle: true,
      actions: [
        Icon(
          Icons.person,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
