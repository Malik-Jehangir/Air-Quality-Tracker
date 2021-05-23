// To parse this JSON data, do
//
//     final airModel = airModelFromJson(jsonString);

import 'dart:convert';

AirModel airModelFromJson(String str) => AirModel.fromJson(json.decode(str));

String airModelToJson(AirModel data) => json.encode(data.toJson());

class AirModel {
  AirModel({
    this.results,
  });

  Results results;

  factory AirModel.fromJson(Map<String, dynamic> json) => AirModel(
        results: Results.fromJson(json["Results"]),
      );

  Map<String, dynamic> toJson() => {
        "Results": results.toJson(),
      };
}

class Results {
  Results({
    this.output1,
  });

  Output1 output1;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        output1: Output1.fromJson(json["output1"]),
      );

  Map<String, dynamic> toJson() => {
        "output1": output1.toJson(),
      };
}

class Output1 {
  Output1({
    this.type,
    this.value,
  });

  String type;
  Value value;

  factory Output1.fromJson(Map<String, dynamic> json) => Output1(
        type: json["type"],
        value: Value.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value.toJson(),
      };
}

class Value {
  Value({
    this.columnNames,
    this.columnTypes,
    this.values,
  });

  List<String> columnNames;
  List<String> columnTypes;
  List<List<String>> values;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        columnNames: List<String>.from(json["ColumnNames"].map((x) => x)),
        columnTypes: List<String>.from(json["ColumnTypes"].map((x) => x)),
        values: List<List<String>>.from(
            json["Values"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "ColumnNames": List<dynamic>.from(columnNames.map((x) => x)),
        "ColumnTypes": List<dynamic>.from(columnTypes.map((x) => x)),
        "Values": List<dynamic>.from(
            values.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
