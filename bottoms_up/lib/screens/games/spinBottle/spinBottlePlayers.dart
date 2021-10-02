import 'package:bottoms_up/design/appbase.dart';
import 'package:bottoms_up/design/appcolors.dart';
import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_player.dart';
import 'package:bottoms_up/design/spin_the_bottle/spin_bottle_player_widget.dart';
import 'package:bottoms_up/design/spin_the_bottle/spin_the_bottle_players_button.dart';
import 'package:bottoms_up/services/size_config.dart';
import 'package:bottoms_up/services/spin_bottle_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Widget buildInsertButton(BuildContext context, SpinTheBottleManager spinTheBottleManager) {

    SizeConfig().init(context); 

    return Container(

      decoration: BoxDecoration(
        color: AppColors.sBgradientDarkRed,
        borderRadius: BorderRadius.all(Radius.circular(SizeConfig.safeBlockHorizontal * 5)),
      ),
      child: IconButton(
        iconSize: SizeConfig.safeBlockHorizontal * 10,
        icon: Icon(Icons.add),
        color: Colors.white,
        onPressed: () => insertItem(0, SpinBottlePlayer(name: "Alex"), context, spinTheBottleManager),
      ),

    );
  }

  Widget _buildItem(item, int index, Animation<double> animation, SpinTheBottleManager spinTheBottleManager) =>
      
    SpinBottlePlayerWidget(
      player: item,
      animation: animation,
      onClicked: () => removeItem(index, spinTheBottleManager),
    );


  void insertItem(int index, SpinBottlePlayer player, BuildContext context, SpinTheBottleManager spinTheBottleManager) {

    SizeConfig().init(context);

    spinTheBottleManager.players.length < 12 ? 

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 5)),
          backgroundColor: AppColors.sBgradientDarkPurple,
          content: Container(
            width: SizeConfig.blockSizeHorizontal * 55,
            height: SizeConfig.blockSizeVertical * 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.safeBlockHorizontal * 6
                      ),
                    decoration: AppBase.addPlayerTextFieldDecoration(),
                    textAlign: TextAlign.center,
                    controller: _controller,
                    validator: (String value) => spinTheBottleManager.validator(value),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: IconButton(
                    iconSize: SizeConfig.safeBlockHorizontal * 10,
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                        spinTheBottleManager.addPlayer(_controller.text, 0);
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
      ).whenComplete(() => _controller.clear())

    : null;

    // players.insert(index, player);
    // _key.currentState.insertItem(index);

  }

  void removeItem(int index, SpinTheBottleManager spinTheBottleManager) {

    // final player = players.removeAt(index);
    final player = spinTheBottleManager.removePlayer(index);

    _key.currentState.removeItem(index, (context, animation) => _buildItem(player, index, animation, spinTheBottleManager));

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {

    final SpinTheBottleManager spinTheBottleManager = Provider.of<SpinTheBottleManager>(context, listen: false);

    SizeConfig().init(context);

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

              }, SizeConfig.safeBlockHorizontal * 3.66, SizeConfig.safeBlockHorizontal * 6.66, SizeConfig.safeBlockVertical * 2),

              Container(
                width: SizeConfig.blockSizeHorizontal * 55,
                height: SizeConfig.blockSizeVertical * 15,
                child: SvgPicture.asset(
                  "assets/images/SVG/addPlayers.svg",
                  semanticsLabel: "addPlayers",
                ),
              ),

              SpinTheBottleStartButton(
                width: SizeConfig.blockSizeHorizontal * 16,
                height: SizeConfig.blockSizeHorizontal * 16,
                iconSize: SizeConfig.blockSizeHorizontal * 10,
              ),

              Padding(
                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1.5),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 100,
                  height: SizeConfig.blockSizeVertical * 50,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockVertical * 2, vertical: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 1.5),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 2, vertical: SizeConfig.safeBlockVertical * 1),
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ">= 2",
                                          style: AppBase.sBconstraintsTextStyle(spinTheBottleManager.players.length >= 2 ? Colors.white : Colors.red),
                                          textAlign: TextAlign.end,
                                        ),
                                        Text(
                                          "<= 12",
                                          style: AppBase.sBconstraintsTextStyle(spinTheBottleManager.players.length < 12 ? Colors.white : Colors.red),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: AnimatedList(
                                      key: _key,
                                      initialItemCount: spinTheBottleManager.players.length,
                                      itemBuilder: (context, index, animation) => _buildItem(spinTheBottleManager.players[index],index,animation,spinTheBottleManager)
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                        child: buildInsertButton(context, spinTheBottleManager),
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
