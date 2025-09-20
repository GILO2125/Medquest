import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/auth/presentation/pages/auth_gate.dart';
import 'package:outlined_text/outlined_text.dart';

Color backgroundcolor = Color(0xFF673596);
Color containerBackgroundColor = Color(0xFF3C006D);
Color containerStrockColor = Color.fromARGB(150, 60, 0, 109);
Color textColor = const Color.fromARGB(200, 255, 255, 255);
Color selectionColor = const Color.fromARGB(204, 20, 16, 94);
FontWeight title = FontWeight.w900;
FontWeight containerTitle = FontWeight.w800;
FontWeight containerSubTitle = FontWeight.w600;

class McqSolvingPage extends StatefulWidget {
  const McqSolvingPage({super.key});

  @override
  State<McqSolvingPage> createState() => _McqSolvingPageState();
}

class _McqSolvingPageState extends State<McqSolvingPage> {
  int counter = 0;

  int minute = 0;
  int seconds = 0;
  final List<Map<Map<String, String>, bool>> data = [
    {
      {"A": "C’est une tumeur bénigne d’origine endométriale"}: false,
      {"B": "Rare chez les femmes ménopausées"}: false,
      {"C": "Rare chez les femmes en âge de procréation"}: true,
      {"D": "Un cancer très ostéophile et hormonosensible"}: true,
      {"E": "Pas de dépistage efficace pour cette pathologie"}: false,
    },
    {
      {"A": "C’est une tumeur Maligne d’origine mammaire"}: true,
      {"B": "Possible chez les hommes"}: true,
      {"C": "Existe une dépistage efficace pour cette pathologie"}: true,
      {
        "D":
            "l'expression de HER2 est un signe de bon pronostique malgré le progress mais reste de bon pronostique"
      }: true,
    }
  ];

  Map<int, Map<List<bool>, bool>> stateMap = {};
  void function() {
    for (int i = 0; i < data.length; i++) {
      List<bool> selected =
          List.generate((data[i].entries.toList().length), (_) => false);
      stateMap[i] = {selected: false};
    }
  }

  String displayedTime() {
    if (minute < 10 && seconds < 10) {
      return "0$minute : 0$seconds";
    } else if (minute < 10 && seconds >= 10) {
      return "0$minute : $seconds";
    } else if (minute >= 10 && seconds < 10) {
      return "$minute : 0$seconds";
    } else {
      return "$minute : $seconds";
    }
  }

  Timer startTimer() {
    final time = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          return;
        }
        setState(
          () {
            seconds++;
            if (seconds == 60) {
              minute++;
              seconds = 0;
            }
            if (minute == 60) {
              minute++;
              seconds = 0;
            }
          },
        );
      },
    );
    return time;
  }

  double questionScore = 0;

  @override
  void initState() {
    function();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> isSelectedList = stateMap.values.toList()[counter].keys.first;
    bool isVerifier = stateMap.values.toList()[counter].values.first;
    String score() {
      int coafficente = 1;
      int selectedCorrectAnswers = 0;
      int correctAnswers = 0;
      if (isVerifier) {
        for (int i = 0; i <= isSelectedList.length - 1; i++) {
          if (isSelectedList[i] == false) {
            if (isSelectedList[i] != data[counter].values.toList()[i]) {
              correctAnswers++;
            }
          } else {
            if (isSelectedList[i] == true) {
              if (isSelectedList[i] == data[counter].values.toList()[i]) {
                selectedCorrectAnswers++;
                correctAnswers++;
              } else {
                coafficente = 0;
              }
            }
          }
        }
        if (correctAnswers != 0) {
          questionScore =
              (selectedCorrectAnswers / correctAnswers) * coafficente;
        }
      }

      if (coafficente == 0) {
        return "Incorrect! une répense fausse";
      } else {
        return selectedCorrectAnswers != correctAnswers
            ? "Partielement Correct +$selectedCorrectAnswers/$correctAnswers"
            : "Correct +1";
      }
    }

    Color colorationLogique(int index) {
      if (isVerifier == true) {
        if (data[counter].values.toList()[index] == true) {
          return const Color.fromARGB(185, 38, 172, 20);
        } else if (data[counter].values.toList()[index] == false &&
            isSelectedList[index] == true) {
          return const Color.fromARGB(160, 161, 8, 8).withValues(alpha: 0.9);
        } else {
          return containerBackgroundColor;
        }
      } else {
        if (isSelectedList[index]) {
          //return selectionColor;
          return Color.from(alpha: 0.9, red: 0.267, green: 0.082, blue: 0.278);
        } else {
          return containerBackgroundColor;
        }
      }
    }

    Color colorationStrockLogique(int index) {
      if (isVerifier == true) {
        if (data[counter].values.toList()[index] == true) {
          return const Color(0xFF007A04).withValues(alpha: 0.9);
        } else if (data[counter].values.toList()[index] == false &&
            isSelectedList[index] == true) {
          return const Color(0xFF7A0000).withValues(alpha: 0.5);
        } else {
          return containerStrockColor;
        }
      } else {
        if (isSelectedList[index]) {
          return Color.fromRGBO(61, 0, 66, 1);
        } else {
          return containerStrockColor;
        }
      }
    }

    Color colorationSelectionLogique(int index) {
      if (isSelectedList[index] ||
          (isVerifier && data[counter].values.toList()[index] == true)) {
        return backgroundcolor.withValues(alpha: 0.2);
      } else {
        return Colors.transparent;
      }
    }

    Color colorationSelectionStrokeLogique(int index) {
      return isSelectedList[index]
          ? textColor.withValues(alpha: 0.7)
          : textColor.withValues(alpha: 0.3);
    }

    return Scaffold(
        backgroundColor: backgroundcolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 75,
          backgroundColor: backgroundcolor,
          title: GestureDetector(
            child: Container(
              height: 65,
              width: 170,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: containerBackgroundColor,
                border: Border.all(
                  width: 3,
                  color: containerStrockColor,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Text(
                "MEDQUEST",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontFamily: "poppins",
                  fontSize: 28,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      startTimer().cancel();

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: containerBackgroundColor,
                        border: Border.all(
                          width: 3,
                          color: containerStrockColor,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: textColor,
                        size: 36,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                TweenAnimationBuilder(
                  duration: Durations.medium2,
                  tween: Tween<double>(begin: 0, end: counter / data.length),
                  builder: (context, value, child) => LinearProgressIndicator(
                    backgroundColor: textColor,
                    color: containerBackgroundColor,
                    value: value,
                    minHeight: 12.5,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Center(
                  child: OutlinedText(
                    text: Text(
                      "${counter + 1} / ${data.length}",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w900,
                        fontFamily: "poppins",
                        fontSize: 8,
                      ),
                    ),
                    strokes: [
                      OutlinedTextStroke(
                          color: containerBackgroundColor, width: 3)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IntrinsicWidth(
                      child: Container(
                        height: 35,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: containerBackgroundColor,
                          border: Border.all(
                            width: 3,
                            color: containerStrockColor,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                        child: Text(
                          "Clinique",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: "poppins",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Container(
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: containerBackgroundColor,
                          border: Border.all(
                            width: 3,
                            color: containerStrockColor,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                        child: Text(
                          "2025",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: "poppins",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Container(
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: containerBackgroundColor,
                          border: Border.all(
                            width: 3,
                            color: containerStrockColor,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                        child: Text(
                          "Rattrapage",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: "poppins",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Container(
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: containerBackgroundColor,
                          border: Border.all(
                            width: 3,
                            color: containerStrockColor,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                        ),
                        child: Text(
                          "Q100",
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: "poppins",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 35,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: containerBackgroundColor,
                    border: Border.all(
                      width: 3,
                      color: containerStrockColor,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  child: Text(
                    displayedTime(),
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w900,
                      fontFamily: "poppins",
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 65,
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: containerBackgroundColor,
                      border: Border.all(
                        width: 3,
                        color: containerStrockColor,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Text(
                      "Concernante le cancer du sein :",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w800,
                        fontFamily: "poppins",
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!isVerifier) {
                        isSelectedList[index] = !isSelectedList[index];
                        setState(() {});
                      }
                    },
                    child: AnimatedContainer(
                      duration: Durations.long2,
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: colorationLogique(index),
                        border: Border.all(
                          width: isSelectedList[index] ? 3.5 : 1,
                          color: colorationStrockLogique(index),
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: Durations.long1,
                            curve: Curves.easeInOut,
                            height: 42,
                            width: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colorationSelectionLogique(index),
                              border: Border.all(
                                width: isSelectedList[index] ? 3 : 0.5,
                                color: colorationSelectionStrokeLogique(index),
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                            child: AnimatedDefaultTextStyle(
                              duration: Durations.long2,
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: "poppins",
                                fontSize: isSelectedList[index] ? 14.5 : 12,
                              ),
                              child: Text(
                                data[counter]
                                    .entries
                                    .toList()[index]
                                    .key
                                    .entries
                                    .toList()
                                    .first
                                    .key,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              data[counter]
                                  .entries
                                  .toList()[index]
                                  .key
                                  .entries
                                  .toList()
                                  .first
                                  .value,
                              style: TextStyle(
                                color: textColor,
                                wordSpacing: 1,
                                letterSpacing: -0.1,
                                fontWeight: FontWeight.w800,
                                fontFamily: "poppins",
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data[counter].entries.toList().length,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (counter > 0) {
                          counter--;
                        }
                      });
                    },
                    child: Container(
                      height: 65,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: containerBackgroundColor,
                        border: Border.all(
                          width: 3,
                          color: containerStrockColor,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Text(
                        "<",
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontFamily: "poppins",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (stateMap.values
                            .toList()[counter]
                            .keys
                            .single
                            .contains(true)) {
                          stateMap.values.toList()[counter].update(
                                isSelectedList,
                                (value) => true,
                              );
                        }
                      });
                    },
                    child: Container(
                      height: 65,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: containerBackgroundColor,
                        border: Border.all(
                          width: 3,
                          color: containerStrockColor,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        isVerifier ? score() : "Vérifier",
                        style: TextStyle(
                          fontSize: 18,
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontFamily: "poppins",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        int counterStep = counter;
                        if (counterStep <= data.length - 1) {
                          if (counterStep == data.length - 1) {
                            counterStep++;
                          } else {
                            counter++;
                            counterStep++;
                          }
                        }

                        if (counterStep == data.length) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  backgroundColor: backgroundcolor,
                                  elevation: 5,
                                  title: Text(
                                    "C'est Partie !",
                                    style: TextStyle(
                                      color: textColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  content: Text(
                                    "Vous avez passer tt les questions !",
                                    style: TextStyle(
                                      color: textColor.withValues(alpha: 0.5),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => AuthGate())),
                                      child: Text(
                                        "Back to home screen",
                                        style: TextStyle(
                                          color: textColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      });
                    },
                    child: Container(
                      height: 65,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: containerBackgroundColor,
                        border: Border.all(
                          width: 3,
                          color: containerStrockColor,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Text(
                        ">",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          fontFamily: "poppins",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ]),
        ));
  }
}

class McqSelectionPage extends ConsumerWidget {
  const McqSelectionPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        backgroundColor: backgroundcolor,
        title: GestureDetector(
          child: Container(
            height: 65,
            width: 170,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: containerBackgroundColor,
              border: Border.all(
                width: 3,
                color: containerStrockColor,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Text(
              "MEDQUEST",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w900,
                fontFamily: "poppins",
                fontSize: 28,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    width: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: containerBackgroundColor,
                      border: Border.all(
                        width: 3,
                        color: containerStrockColor,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: textColor,
                      size: 36,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.maxFinite,
              height: 50,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerBackgroundColor,
                border: Border.all(
                  width: 3,
                  color: containerStrockColor,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Text(
                "",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontFamily: "poppins",
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: containerBackgroundColor,
                      border: Border.all(
                        width: 3,
                        color: containerStrockColor,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Text(
                      "Theorique",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w900,
                        fontFamily: "poppins",
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: containerBackgroundColor,
                      border: Border.all(
                        width: 3,
                        color: containerStrockColor,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Text(
                      "Clinique",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w900,
                        fontFamily: "poppins",
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height : 25,
            ),
          ],
        ),
      ),
    );
  }
}
