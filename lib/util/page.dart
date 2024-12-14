/// page
class Page {
  int count = 0;
  List<dynamic> data = [];

  Page(this.count, this.data);

  Page.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> page = <String, dynamic>{};
    page['count'] = count;
    page['data'] = data.map((v) => v.toJson()).toList();
    return page;
  }
}
