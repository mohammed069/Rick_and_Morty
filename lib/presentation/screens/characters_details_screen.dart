import 'package:flutter/material.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  final Character character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: MyColors.myGrey,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.charName,
          style: TextStyle(
            color: MyColors.myWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(character.charImage, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo({
    required String title,
    required String value,
    required double endIndent,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: value,
                style: TextStyle(color: MyColors.myWhite, fontSize: 22),
              ),
            ],
          ),
        ),
        Divider(
          color: MyColors.myYellow,
          height: 30,
          endIndent: endIndent,
          thickness: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo(
                      title: 'Speces: ',
                      value: character.charSpecies,
                      endIndent: 280,
                    ),
                    characterInfo(
                      title: 'Location: ',
                      value: character.charLocationName,
                      endIndent: 265,
                    ),
                    characterInfo(
                      title: 'Origin: ',
                      value: character.charOriginName,
                      endIndent: 290,
                    ),
                    characterInfo(
                      title: 'Gender: ',
                      value: character.charGender,
                      endIndent: 280,
                    ),
                    characterInfo(
                      title: 'Status: ',
                      value: character.charStatus,
                      endIndent: 290,
                    ),
                    SizedBox(height: 430),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
