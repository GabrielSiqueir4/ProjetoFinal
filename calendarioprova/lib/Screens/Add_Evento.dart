import 'package:calendarioprova/Widgets/Button.dart';
import 'package:calendarioprova/Widgets/Input_field.dart';
import 'package:calendarioprova/Widgets/theme.dart';
import 'package:calendarioprova/controller/Evento_controller.dart';
import 'package:calendarioprova/models/Evento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class addTarefa extends StatefulWidget {
  const addTarefa();

  @override
  State<addTarefa> createState() => _addTarefaState();
}

// ignore: camel_case_types
class _addTarefaState extends State<addTarefa> {
  final EventoController _eventoController = Get.put(EventoController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _localController = TextEditingController();
  final TextEditingController _coordenadorController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();
  

  DateTime _selectDate = DateTime.now();
  // ignore: unused_field
  String _tempoFinal = '09:30 PM';
  String _tempoInicial =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _corSelecionada = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Adicionar Evento",
                style: TituloStyle,
              ),
              MyInputFild(
                title: "Titulo",
                hint: "Digite o Titulo aqui",
                controller: _titleController,
              ),
              MyInputFild(
                title: "Local",
                hint: "Digite o Local aqui",
                controller: _localController,
              ),
              MyInputFild(
                hint: DateFormat('dd/MM/yyyy').format(_selectDate),
                title: 'Data',
                controller: null,
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDataDoUsuario();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputFild(
                      title: "Hora Inicial:",
                      hint: _tempoInicial,
                      controller: null,
                      widget: IconButton(
                        onPressed: () {
                          _getHoraDoUsuario(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyInputFild(
                      title: "Hora Final:",
                      hint: _tempoFinal,
                      widget: IconButton(
                        onPressed: () {
                          _getHoraDoUsuario(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputFild(
                title: "Curso",
                hint: "Informe o Nome do Curso",
                controller: _cursoController,
              ),
              MyInputFild(
                title: "Coordenador",
                hint: "Informe o Nome do Coordenador ",
                controller: _coordenadorController,
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _paletaDeCor(),
                  Button(
                    label: "+ Criar Evento",
                    onTap: () => _validarData(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validarData() {
    if (_titleController.text.isNotEmpty &&
        _localController.text.isNotEmpty &&
        _coordenadorController.text.isNotEmpty &&
        _cursoController.text.isNotEmpty) {
      _addEventoNoDB();
      Get.back();
    } else if (_titleController.text.isEmpty ||
        _localController.text.isEmpty ||
        _coordenadorController.text.isEmpty ||
        _cursoController.text.isEmpty) {
      Get.snackbar(
        "Atenção !",
        'Todos os campos são Obrigatórios !',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
        ),
      );
    }
  }

  _addEventoNoDB() async {
    int value = await _eventoController.addEvento(
      evento: Evento(
          cor: _corSelecionada,
          local: _localController.text,
          titulo: _titleController.text,
          coordenador: _coordenadorController.text,
          curso: _cursoController.text,
          horaInicial: _tempoInicial,
          horaFinal: _tempoFinal,
          data: DateFormat("d 'de' MMM 'de' y").format(
            _selectDate,
          ),    
          ),
    );
  }

  _paletaDeCor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cor Do Evento",
          style: Titulo,
        ),
        const SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(
            5,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _corSelecionada = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? greenClr
                        : index == 1
                            ? pinkClr
                            : index == 2
                                ? blueClr
                                : index == 3
                                    ? ambarClr
                                    : orageClr,
                    child: _corSelecionada == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 18,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  _getDataDoUsuario() async {
    DateTime? pegarData = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2129),
    );
    if (pegarData != null) {
      setState(() {
        _selectDate = pegarData;
      });
    } else {
      print("Informe uma data!");
    }
  }

  _getHoraDoUsuario({required bool isStartTime}) async {
    var pegarHora = await _exibirHora();
    String formatarHora = pegarHora.format(context);
    if (pegarHora == null) {
    } else if (isStartTime == true) {
      setState(() {
        _tempoInicial = formatarHora;
      });
    } else if (isStartTime == false) {
      setState(() {
        _tempoFinal = formatarHora;
      });
    }
  }

  _exibirHora() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(_tempoInicial.split(":")[0]),
          minute: int.parse(_tempoInicial.split(":")[1].split(" ")[0])),
    );
  }
}
