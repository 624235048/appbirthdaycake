class CartModel {
  int id;
  String cake_id;
  String cake_size;
  String cake_img;
  String cake_date;
  String cake_text;
  String amount;
  String price;
  String sum;
  String time;

  CartModel(
      {this.id,
      this.cake_id,
      this.cake_size,
      this.cake_img,
      this.cake_date,
      this.cake_text,
      this.price,
      this.amount,
      this.sum,
      this.time});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cake_id = json['cake_id'];
    cake_size = json['cake_size'];
    cake_img = json['cake_img'];
    cake_date = json['cake_date'];
    cake_text = json['cake_text'];
    amount = json['amount'];
    price = json['price'];
    sum = json['sum'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cake_id'] = this.cake_id;
    data['cake_size'] = this.cake_size;
    data['cake_img'] = this.cake_img;
    data['cake_date'] = this.cake_date;
    data['cake_text'] = this.cake_text;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['sum'] = this.sum;
    data['time'] = this.time;
    return data;
  }
}
