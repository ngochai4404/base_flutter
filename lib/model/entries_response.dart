class EntriesResponse {
  int? count;
  List<Entries>? entries;

  EntriesResponse({this.count, this.entries});

  EntriesResponse.fromJson(Map<String, dynamic> json) {
    this.count = json["count"];
    this.entries = json["entries"]==null ? null : (json["entries"] as List).map((e)=>Entries.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["count"] = this.count;
    if(this.entries != null)
      data["entries"] = this.entries?.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Entries {
  String? description;
  bool? https;
  String? link;
  String? category;

  Entries({this.description, this.https, this.link, this.category});

  Entries.fromJson(Map<String, dynamic> json) {
    this.description = json["Description"];
    this.https = json["HTTPS"];
    this.link = json["Link"];
    this.category = json["Category"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["Description"] = this.description;
    data["HTTPS"] = this.https;
    data["Link"] = this.link;
    data["Category"] = this.category;
    return data;
  }
}