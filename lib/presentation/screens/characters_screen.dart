import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/presentation/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lottie/lottie.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<dynamic> allCharacters;
  late List<dynamic> searchedCharacters;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        hintStyle: const TextStyle(color: MyColors.myGrey, fontSize: 20),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 15),
      onChanged: (value) {
        setState(() {
          searchedCharacters =
              allCharacters
                  .where(
                    (character) => character.charName.toLowerCase().contains(
                      value.toLowerCase(),
                    ),
                  )
                  .toList();
        });
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear, color: MyColors.myGrey),
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
            setState(() {
              _isSearching = false;
            });
          },
        ),
      ];
    } else {
      return [IconButton(icon: Icon(Icons.search), onPressed: _startSearch)];
    }
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      searchedCharacters = [];
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          // searchedCharacters = [];
          return buildLoadedListWidget();
        } else if (state is CharactersError) {
          return showErrorMessage(state.message);
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget _buildNoInternet() {
    return Center(
      child: Lottie.asset(
        'assets/images/no_internet_animation.json',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.myYellow),
    );
  }

  Widget showErrorMessage(String message) {
    return Center(
      child: Text(message, style: TextStyle(color: Colors.red, fontSize: 18)),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(children: [buildCharactersList()]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount:
          _searchController.text.isEmpty
              ? allCharacters.length
              : searchedCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character:
              _searchController.text.isEmpty
                  ? allCharacters[index]
                  : searchedCharacters[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Text('Characters', style: TextStyle(color: MyColors.myGrey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          return connected ? buildBlocWidget() : _buildNoInternet();
        },
        child: buildBlocWidget(),
      ),
    );
  }
}
