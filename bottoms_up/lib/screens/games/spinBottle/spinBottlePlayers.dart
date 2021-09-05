import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/apptext.dart';
import 'package:bottoms_up/design/buttons/spin_the_bottle/spin_the_bottle_players_button.dart';
import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_player.dart';
import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_player_widget.dart';
import 'package:bottoms_up/services/spin_bottle_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpinBottlePlayers extends StatefulWidget {
  const SpinBottlePlayers({Key key}) : super(key: key);

  @override
  _SpinBottlePlayersState createState() => _SpinBottlePlayersState();
}

class _SpinBottlePlayersState extends State<SpinBottlePlayers> {
  final _key = GlobalKey<AnimatedListState>();
  final _formKey = GlobalKey<FormState>();
  // final List<SpinBottlePlayer> players = [];

  final _controller = TextEditingController();

  Widget buildInsertButton(BuildContext context, MediaQueryData mediaQuery,
          SpinTheBottleManager spinTheBottleManager) =>
      Container(
        decoration: BoxDecoration(
          color: AppColors.sBgradientDarkRed,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: IconButton(
          iconSize: 40,
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () => insertItem(0, SpinBottlePlayer(name: "Alex"),
              context, mediaQuery, spinTheBottleManager),
        ),
      );

  Widget _buildItem(item, int index, Animation<double> animation,
          SpinTheBottleManager spinTheBottleManager) =>
      SpinBottlePlayerWidget(
        player: item,
        animation: animation,
        onClicked: () => removeItem(index, spinTheBottleManager),
      );

  void insertItem(int index, SpinBottlePlayer player, BuildContext context,
      MediaQueryData mediaQuery, SpinTheBottleManager spinTheBottleManager) {
    spinTheBottleManager.players.length < 12
        ? showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              backgroundColor: AppColors.sBgradientDarkPurple,
              content: Container(
                width: mediaQuery.size.width / 2,
                height: mediaQuery.size.height / 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                            decoration: AppBase.addPlayerTextFieldDecoration(),
                            textAlign: TextAlign.center,
                            controller: _controller,
                            validator: (String value) =>
                                spinTheBottleManager.validator(value),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: IconButton(
                          iconSize: 40,
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              spinTheBottleManager.addPlayer(
                                  SpinBottlePlayer(name: _controller.text), 0);
                              // players.insert(0, SpinBottlePlayer(name: _controller.text));
                              _key.currentState.insertItem(0);
                              _controller.clear();
                              Navigator.pop(context);
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ).whenComplete(() => _controller.clear())
        : null;

    // players.insert(index, player);
    // _key.currentState.insertItem(index);
  }

  void removeItem(int index, SpinTheBottleManager spinTheBottleManager) {
    // final player = players.removeAt(index);
    final player = spinTheBottleManager.removePlayer(index);

    _key.currentState.removeItem(
      index,
      (context, animation) =>
          _buildItem(player, index, animation, spinTheBottleManager),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context); //device width
    final SpinTheBottleManager spinTheBottleManager =
        Provider.of<SpinTheBottleManager>(context, listen: false);

    print("width ${mediaQuery.size.width}");
    print("height ${mediaQuery.size.height}");

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.spinTheBottleGradient, //background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBase.appPopIcon(context, () {
                spinTheBottleManager.resetSpinBottlePlayers();
                _controller.dispose();
                spinTheBottleManager.resetSpinBottlePlayers();
                Navigator.pop(context);
              }, 15.0, 15.0, 15.0),
              Container(
                //Add Players Logo
                width: mediaQuery.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ADD",
                      style: AppText.spinTheBottleTextStyle(
                          mediaQuery: mediaQuery),
                    ),
                    Text(
                      "PLAYERS",
                      style: AppText.spinTheBottleTextStyle(
                          mediaQuery: mediaQuery),
                    ),
                  ],
                ),
              ),
              SpinTheBottleStartButton(
                width: mediaQuery.size.width / 6,
                height: mediaQuery.size.width / 6,
                iconSize: mediaQuery.size.width / 4.5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height / 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ">= 2",
                                          style: AppBase.sBconstraintsTextStyle(
                                              spinTheBottleManager
                                                          .players.length >=
                                                      2
                                                  ? Colors.white
                                                  : Colors.red),
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          "<= 12",
                                          style: AppBase.sBconstraintsTextStyle(
                                              spinTheBottleManager
                                                          .players.length <
                                                      12
                                                  ? Colors.white
                                                  : Colors.red),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: AnimatedList(
                                      key: _key,
                                      initialItemCount: spinTheBottleManager
                                          .players.length,
                                      itemBuilder:
                                          (context, index, animation) =>
                                              _buildItem(
                                                  spinTheBottleManager
                                                      .players[index],
                                                  index,
                                                  animation,
                                                  spinTheBottleManager)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 25),
                        child: buildInsertButton(
                            context, mediaQuery, spinTheBottleManager),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
