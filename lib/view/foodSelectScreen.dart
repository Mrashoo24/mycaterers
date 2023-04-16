import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycaterers/data/model/CategoryMode.dart';
import 'package:mycaterers/data/model/foodModel.dart';
import 'package:mycaterers/utils/common/colors.dart';
import 'package:collection/collection.dart';

class FoodSelectScreen extends StatefulWidget {
  const FoodSelectScreen({Key? key}) : super(key: key);

  @override
  State<FoodSelectScreen> createState() => _FoodSelectScreenState();
}

class _FoodSelectScreenState extends State<FoodSelectScreen> {
  var openedIndex = -1;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<_FoodSelectScreenState> expansionTile = new GlobalKey();

  List<CategoryModel> listoFSelectedFoods = [];

  var catList = [
    CategoryModel(id: '0', index: 0, name: 'Starters', listOfFoods: [
      FoodModel(id: '0', name: 'Chicken Salaami', catid: '0'),
      FoodModel(id: '2', name: 'Chicken Kabab', catid: '0')
    ], selectedFoods: []),
    CategoryModel(id: '1', index: 1, name: 'Gravy', listOfFoods: [
      FoodModel(id: '100', name: 'Chicken Angaara', catid: '1'),
      FoodModel(id: '101', name: 'Chicken Butter', catid: '1')
    ], selectedFoods: [])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Foods'),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    var selectedCatList = catList
                        .where((element) => element.selectedFoods!.isNotEmpty)
                        .toList();

                    return StatefulBuilder(
                      builder: (context,dialogState) {

                        return AlertDialog(
                          content: Container(
                            height: 300,
                            width: 200,
                            child: ListView.builder(
                                itemCount: selectedCatList.length,
                                itemBuilder: (context, index) {
                                  var currentCat = selectedCatList[index];

                                  return ExpansionTile(
                                      iconColor: kgreen,
                                      key: GlobalKey(),
                                      initiallyExpanded: openedIndex == index,
                                      onExpansionChanged: (opened) {
                                        setState(() {
                                          openedIndex = index;
                                        });
                                      },
                                      title: Text(
                                        currentCat.name!,
                                        style: TextStyle(color: korangeColor),
                                      ),
                                      children: currentCat.selectedFoods!
                                          .mapIndexed((index, element) {
                                        FoodModel? currentFoodinList = currentCat
                                            .selectedFoods!
                                            .firstWhereOrNull(
                                                (e) => e.id == element.id);

                                        return InkWell(
                                          onTap: () {

                                            setState(() {
                                              currentCat.selectedFoods!
                                                  .remove(element);
                                            });
                                            dialogState(() {
                                              currentCat.selectedFoods!
                                                  .remove(element);
                                            });

                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(element.name!),
                                                currentFoodinList == null
                                                    ? Icon(
                                                        Icons.check_box_outline_blank)
                                                    : Icon(
                                                        Icons.check_box,
                                                        color: kgreen,
                                                      )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList());
                                }),
                          ),
                        );
                      }
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kgreen,
                ),
                child: Row(
                  children: [
                    Text('View Cart'),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.remove_red_eye_outlined)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          _scrollController.animateTo(2 * 60.0,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        });
      }),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: catList.length,
          itemBuilder: (context, index) {
            var currentCat = catList[index];

            return ExpansionTile(
                iconColor: kgreen,
                key: GlobalKey(),
                initiallyExpanded: openedIndex == index,
                onExpansionChanged: (opened) {
                  setState(() {
                    openedIndex = index;
                  });
                },
                title: Text(
                  currentCat.name!,
                  style: TextStyle(color: korangeColor),
                ),
                children: currentCat.listOfFoods!.mapIndexed((index, element) {
                  FoodModel? currentFoodinList = currentCat.selectedFoods!
                      .firstWhereOrNull((e) => e.id == element.id);

                  return InkWell(
                    onTap: () {
                      if (currentFoodinList == null) {
                        currentCat.selectedFoods!.add(element);

                        var addedList = catList[index].selectedFoods!;

                        setState(() {
                          // listoFSelectedFoods.add(catList[index].copyWith(selectedFoods: addedList));
                        });
                      } else {
                        currentCat.selectedFoods!.remove(element);
                        var addedList = catList[index].selectedFoods!;

                        setState(() {
                          // listoFSelectedFoods.add(catList[index].copyWith(selectedFoods: addedList));
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(element.name!),
                          currentFoodinList == null
                              ? Icon(Icons.check_box_outline_blank)
                              : Icon(
                                  Icons.check_box,
                                  color: kgreen,
                                )
                        ],
                      ),
                    ),
                  );
                }).toList());
          }),
    );
  }
}
