class CoffeeItems{
  String _name, _price;

  CoffeeItems(this._name, this._price);

  factory CoffeeItems.fromJSON(Map<String, dynamic> json){
    if(json == null){
      return null;
    }else{
      return CoffeeItems(json["name"],json["price "]);
    }
  }

  get name => this._name;
  get price => this._price;
}