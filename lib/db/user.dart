class User{
  int? id, wins, loses;
  String? date;

  User(this.wins, this.loses, this.date);
  
  User.deMap(Map<String, dynamic> map){
    id = map["id"];
    wins = map["wins"];
    loses = map["loses"];
    date = map["date"];
    
  }
  
  Map<String, dynamic> toMap(){
    return{
      "id":id,
      "wins":wins,
      "loses":loses,
      "date":date
    };
  }
}