class Evento {
  int? id;
  String? titulo;
  String? local;
  String? data;
  String? horaInicial;
  String? horaFinal;
  String? curso;
  String? coordenador;
  int? cor;
  Evento(
      {this.id,
      this.titulo,
      this.local,
      this.data,
      this.horaInicial,
      this.horaFinal,
      this.coordenador,
      this.curso,
      this.cor});

  Evento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    local = json['local'];
    data = json['data'];
    horaInicial = json['horaInicial'];
    horaFinal = json['horaFinal'];
    coordenador = json['coordenador'];
    curso = json['curso'];
    cor = json['cor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['local'] = this.local;
    data['data'] = this.data;
    data['horaInicial'] = this.horaInicial;
    data['horaFinal'] = this.horaFinal;
    data['coordenador'] = this.coordenador;
    data['curso'] = this.curso;
    data['cor'] = this.cor;
    return data;
  }
}
