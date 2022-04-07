class ActividadModel {
   int? id;
   String nombre;
   String descripcion;
   int edadMin;
   int edadMax;

  ActividadModel({
    this.id ,
    required this.nombre,
    this.descripcion = '',
    this.edadMin = 6,
    this.edadMax = 99,
  });

  factory ActividadModel.fromJson(Map<String, dynamic> json) => ActividadModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        edadMin: json["edadMin"],
        edadMax: json["edadMax"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "edadMin": edadMin,
        "edadMax": edadMax
      };
}
