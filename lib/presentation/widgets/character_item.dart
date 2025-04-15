import 'package:flutter/material.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: MyColors.myBlack,
          alignment: Alignment.bottomCenter,
          child: Text(
            character.charName,
            style: const TextStyle(
              height: 1.3,
              color: MyColors.myWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        child: Container(
          color: MyColors.myGrey,
          child:
              character.charImage.isNotEmpty
                  ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: 'assets/images/shimmer.gif',
                    image: character.charImage,
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    'assets/images/image_not_found.gif',
                    fit: BoxFit.cover,
                  ),
        ),
      ),
    );
  }
}
