class User{
  int? id, wins, loses;
  String? date, difficulty;

  User(this.wins, this.loses, this.date, this.difficulty);
  
  User.deMap(Map<String, dynamic> map){
    id = map["id"];
    wins = map["wins"];
    loses = map["loses"];
    date = map["date"];
    difficulty = map["difficulty"];
  }
  
  Map<String, dynamic> toMap(){
    return{
      "id":id,
      "wins":wins,
      "loses":loses,
      "date":date,
      "difficulty":difficulty
    };
  }
}