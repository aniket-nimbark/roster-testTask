import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roster/userprovider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      _loadmore();
    });
  }

  _loadmore() async {
    if (ref.read(getUserDataProvider.notifier).isloadmore == false && scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      ref.watch(isLoadingProvider.notifier).update((state) => true);

      await ref.read(getUserDataProvider.notifier).nextUsers();

      ref.watch(isLoadingProvider.notifier).update((state) => false);
    }
  }

  var isSelect = false;
  var isSelectTextField = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(

          backgroundColor: Colors.black,     title:commonText("Roster", Colors.white, 16, FontWeight.w600, TextAlign.center),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.withOpacity(0.5))),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        setState(() {
                          isSelect = !isSelect;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                          color: isSelect ? Colors.orange : Colors.black,
                        ),
                        child: commonText("30 Matches", Colors.white, 16, FontWeight.w600, TextAlign.center),
                        alignment: Alignment.center,
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        setState(() {
                          // isSelect = !isSelect;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                          color: isSelect ? Colors.black : Colors.orange,
                        ),
                        child: commonText("120 All Competitors", Colors.white, 16, FontWeight.w600, TextAlign.center),
                        alignment: Alignment.center,
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Flexible(
                        flex: 5,
                        child: Container(
                          height: 49,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: isSelectTextField ? Colors.orange.withOpacity(0.8) : Colors.transparent),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                              color: Colors.white),
                          child: TextField(
                            onTap: () {
                              setState(() {
                                isSelectTextField = true;
                              });
                            },
                            onChanged: (val){

                              ref.watch(isLoadingProvider.notifier).update((state) => true);
                              ref.read(getUserDataProvider.notifier).fetchUsers(searchQuery: val);
                              ref.watch(isLoadingProvider.notifier).update((state) => false);
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search by Name",
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(left: 10)),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          height: 49,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)), color: Colors.orange),
                          child: Icon(
                            Icons.search,
                            color: isSelectTextField ? Colors.white.withOpacity(0.4) : Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: ref.read(getUserDataProvider.notifier).fetchUsers(),
                builder: (context, snap) {
                  print("FGdskgjhdsfkl");
                  print(snap.connectionState);
                  if (snap.connectionState == ConnectionState.waiting && ref.read(getUserDataProvider.notifier).state.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Consumer(builder: (context, ref, _) {
                    final userData = ref.watch(getUserDataProvider);
                    final bool loading = ref.watch(isLoadingProvider);
                    print(userData);
                    print("Fdsljkfhsdklj");
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: userData.length, // Add one for the loading indicator
                            itemBuilder: (context, index) {
                              final user = userData[index];
                              print("fdsfdsfdsfsd");
                              print(user);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  // height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            commonText(user.firstName, Colors.white, 12,
                                                FontWeight.w400, TextAlign.center),
                                            commonText("David Salazar", Colors.white,
                                                12, FontWeight.w400, TextAlign.center),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      height: 100,
                                                      child: Align(
                                                        alignment: Alignment.topCenter,
                                                        child: Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration:
                                                          const BoxDecoration(
                                                              shape:
                                                              BoxShape.circle,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 4,
                                                    child: SizedBox(
                                                      height: 100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              commonText(
                                                                  "${user.weight} Ibs",
                                                                  Colors.white,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                              commonText(
                                                                  "9 Bouts",
                                                                  Colors.white,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                              commonText(
                                                                  "9 yrs",
                                                                  Colors.white,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              commonText(
                                                                  "Weight",
                                                                  Colors.grey,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                              commonText(
                                                                  "Experience",
                                                                  Colors.grey,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                              commonText(
                                                                  "Age",
                                                                  Colors.grey,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              commonText(
                                                                  "65 Ibs",
                                                                  Colors.white,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                              commonText(
                                                                  "9 Bouts",
                                                                  Colors.white,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                              commonText(
                                                                  "${user.age} yrs",
                                                                  Colors.white,
                                                                  14,
                                                                  FontWeight.w500,
                                                                  TextAlign.center),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: SizedBox(
                                                      height: 100,
                                                      child: Align(
                                                        alignment: Alignment.topCenter,
                                                        child: Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration:
                                                          const BoxDecoration(
                                                              shape:
                                                              BoxShape.circle,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            commonText("Gotcha Boxing", Colors.white,
                                                12, FontWeight.w400, TextAlign.center),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            commonText("Gym Name", Colors.grey, 12,
                                                FontWeight.w400, TextAlign.center),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            commonText("Gotcha Boxing", Colors.white,
                                                12, FontWeight.w400, TextAlign.center),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        commonText("Gym\nLocation", Colors.grey, 12,
                                            FontWeight.w400, TextAlign.center),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        commonText("Coach", Colors.grey, 12,
                                            FontWeight.w400, TextAlign.center),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            commonText("Awaiting\nApproval", Colors.red,
                                                12, FontWeight.w400, TextAlign.center),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            commonText("Status", Colors.grey, 12,
                                                FontWeight.w400, TextAlign.center),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            commonText("Awaiting\nApproval", Colors.red,
                                                12, FontWeight.w400, TextAlign.center),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        commonText("Weight of match (Lbs)", Colors.grey,
                                            14, FontWeight.w400, TextAlign.center),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        borderRadius:
                                                        BorderRadius.circular(8)),
                                                    child: commonText(
                                                        "-Ibs",
                                                        Colors.black,
                                                        14,
                                                        FontWeight.w500,
                                                        TextAlign.center),
                                                    alignment: Alignment.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  commonText(
                                                      "Minuman\nWeight",
                                                      Colors.white,
                                                      14,
                                                      FontWeight.w500,
                                                      TextAlign.center),
                                                ],
                                              ),
                                              //
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        borderRadius:
                                                        BorderRadius.circular(8)),
                                                    child: commonText(
                                                        "65 Ibs",
                                                        Colors.black,
                                                        14,
                                                        FontWeight.w500,
                                                        TextAlign.center),
                                                    alignment: Alignment.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  commonText(
                                                      "Match\nWeight",
                                                      Colors.white,
                                                      14,
                                                      FontWeight.w500,
                                                      TextAlign.center)
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        borderRadius:
                                                        BorderRadius.circular(8)),
                                                    child: commonText(
                                                        "-Ibs",
                                                        Colors.black,
                                                        14,
                                                        FontWeight.w500,
                                                        TextAlign.center),
                                                    alignment: Alignment.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  commonText(
                                                      "Max Weight",
                                                      Colors.white,
                                                      14,
                                                      FontWeight.w500,
                                                      TextAlign.center)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        commonText(
                                            "Boxer must weight between - Ib \n minimum and - Ib max during weight-in.",
                                            Colors.white,
                                            14,
                                            FontWeight.w500,
                                            TextAlign.center),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: commonText("Learn More", Colors.orange,
                                              14, FontWeight.w500, TextAlign.center),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        loading == true ? CircularProgressIndicator() : Container(),
                      ],
                    );
                  });
                },
              ),
            )
          ],
        ));
  }
}

//
// FutureBuilder(
// future: ref.read(getUserDataProvider.notifier).fetchUsers(),
// builder: (context,snap){
// print("FGdskgjhdsfkl");
// print(snap.connectionState);
// if(snap.connectionState==ConnectionState.waiting && ref.read(getUserDataProvider.notifier).state.isEmpty){
//
// return Center(child: CircularProgressIndicator(),);
// }
// return Consumer(builder: (context,ref,_){
// final userData = ref.watch(getUserDataProvider);
// final bool loading = ref.watch(isLoadingProvider);
// print(userData);
// print("Fdsljkfhsdklj");
// return Column(
// children: [
// Expanded(
// child: ListView.builder(
// controller: scrollController,
// shrinkWrap: true,
// itemCount: userData.length , // Add one for the loading indicator
// itemBuilder: (context, index) {
// final user =userData[index];
// print("fdsfdsfdsfsd");
// print(user);
// return ListTile(
// title: Text('User ${user.id}: ${user.firstName}'),
// );
//
// },
// ),
// ),
// loading==true?CircularProgressIndicator():Container(),
// ],
// );
// });
//
//
// },
//
// )

Widget commonText(String? text, Color? color, double? fontSize, FontWeight? fontWeight, TextAlign? textAlign) {
  return Text(
    text ?? "",
    style: TextStyle(color: color ?? Colors.white, fontSize: fontSize ?? 14, fontWeight: fontWeight ?? FontWeight.w400),
    textAlign: textAlign ?? TextAlign.center,
  );
}
