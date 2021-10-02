import 'package:playing_cards/playing_cards.dart';

//challege should match the specific card
class KingsCard {

  final PlayingCard card; //comes from local deck
  final String cardTitle;
  final String challenge; //come from firestore

  KingsCard({this.card, this.challenge, this.cardTitle});

}
//data from json
class KingsCardData{ 

  final int key;
  final String card;
  final String challenge;

  KingsCardData(this.key, this.card, this.challenge);

  KingsCardData.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        card = json['card'],
        challenge = json['challenge'];

}