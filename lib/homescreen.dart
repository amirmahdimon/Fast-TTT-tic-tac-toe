// ignore_for_file: dead_code, unused_element
//GitHub: Amirmahdimon
//Instagram: ronix.dev
//LinkedIn: Amirmahdi Montazeri

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

//لیست پالت دلخواه
final Color backGroundColor = HexColor('#24293d');
final Color itemColor = HexColor('#2f3855');
final Color X = HexColor('#e090df');
final Color O = HexColor('#9308ff');
final Color Grey = HexColor('#a8bec9');

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  //ساخت لیست برای وارد کردن ایندکس درون اون
  List<String> xOrOList = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  //متغیر های مورد نیاز برای گرفتن ورودی
  int filledBoxes = 0;
  bool hasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  int tie = 0;
  int boardSize = 3;
  String winnerTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //اپ بار برنامه
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //ریست کردن بازی از بیخ و بن
              resetGame();
            },
            //یه ایکون رفرش هم دادیم بهش
            icon: Icon(Icons.refresh),
          ),
        ],
        //اینجا دیگه اضافه کاریای اپ باره
        centerTitle: true,
        elevation: 0,
        backgroundColor: backGroundColor,
        //این کانتینر رو ساختیم تا بالا بهمون بگه نوبت کدوم بازیکنه
        title: Container(
          height: 38,
          width: 150,
          decoration: BoxDecoration(
            color: itemColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: getTurn(),
          ),
        ),
      ),
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //یه فاصله گزاشتیم تا اپ بار
            SizedBox(
              height: 15,
            ),
            //اون باتنی که نوع بازی رو تغییر میده رو گزاشتیم ، منظورم 3 در 3 بودن یا 4 در 4 بودن
            dropDownButton(),
            SizedBox(
              height: 10,
            ),
            //به جدولمون یه اکسپندد اضافه کردیم که تا ته بکشونه  جدول رو تا ته
            Expanded(
              child: Padding(
                //پدینگ دادیم تا یکم فاصله های کناریشو حفظ کنه
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 20, bottom: 10),
                child: getViewBuilder(),
              ),
            ),
            //این یکی از ویجت ویزیبل استفاده میکنه یعنی حالت عادی نشون داده نمیشه مگر اینکه بازی نتیجه داشته باشه
            getResultButton(),
            SizedBox(
              height: 35,
            ),
            //حالا نتیجه بازی رو اضافه میکنیم ، اسکوربورد منظورم
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: getScoreBoard(),
            ),
          ],
        ),
      ),
    );
  }

  //مشخص کننده نوع بازی
  Widget dropDownButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 135),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem(
            child: Text(
              '3 x 3',
              style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            value: '3',
          ),
          DropdownMenuItem(
            child: Text(
              '4 x 4',
              style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            value: '4',
          ),
        ],
        onChanged: (value) {
          setState(() {
            boardSize = int.parse(value!);
          });
        },
        //یه سری ریز کاریای برنامه
        dropdownColor: backGroundColor,
        isExpanded: false,
        value: boardSize.toString(),
        iconSize: 24,
        iconEnabledColor: Colors.white,
        focusColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        underline: Container(
          height: 0,
        ),
      ),
    );
  }

  //نوبت بازی رو تنظیم میکنیم
  Widget getTurn() {
    return Text(
      //اگه نوبتش بود که هیچی بنویس نوبتشو اگر نه یه چیز دیگه بنویس
      isTurnO ? 'Turn O' : 'Turn X',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Grey,
      ),
    );
  }

  //جدولمونه این ، با ویو بیلدر میتونیم جدول بسازیم
  Widget getViewBuilder() {
    return GridView.builder(
      shrinkWrap: true,
      //میتونیم خیلی ساده بنویسیم 9 یا 16 ولی اومدیم متغیر دادیم که با هر بار تغییر توسط بازیکنان عوض شه
      itemCount: boardSize * boardSize,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: boardSize,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            //اینجا tapped رو صدا زدیم
            tapped(index);
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: itemColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                xOrOList[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 55,
                  color: xOrOList[index] == 'X' ? X : O,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//برد امتیازات
  Widget getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 85,
          width: 110,
          decoration: BoxDecoration(
            color: O,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'Player O',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '$scoreO',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 85,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'TIES',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '$tie',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 85,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: X,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'Player X',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '$scoreX',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//دریافت نتیجه و همینطور یهو نمایان شدن برنده و بازنده بازی
  Widget getResultButton() {
    return Visibility(
      visible: hasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            primary: Colors.white, side: BorderSide(color: Colors.white)),
        onPressed: () {
          setState(() {
            hasResult = false;
            clearItem();
          });
        },
        child: Text(
          '$winnerTitle, Play Again',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  //اضافه شدن اسکور به نتیجه
  void setResult(String winner, String title) {
    setState(() {
      hasResult = true;
      winnerTitle = title;

      if (winner == 'X') {
        scoreX = scoreX + 1;
      } else if (winner == "O") {
        scoreO = scoreO + 1;
      } else {
        tie += 1;
      }
    });
  }

  //حذف ایتم های داخل جدول برای موقعی که میخوای بازی ریست بشه ولی اسکوربرد ریست نشه
  void clearItem({bool deepClean = false}) {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
  }

  //وقتی که میخوای از بیخ و بن ریست کنی
  void resetGame() {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
      scoreO = 0;
      scoreX = 0;
      tie = 0;
      hasResult = false;
    });
    filledBoxes = 0;
  }

  //وقتی لمس میشه روی چیز های مختلف چه اتفاقی میفته؟
  void tapped(int index) {
    if (hasResult) {
      return;
    }
    if (xOrOList[index].isEmpty) {
      setState(
        () {
          if (isTurnO) {
            xOrOList[index] = 'O';
            filledBoxes = filledBoxes + 1;
          } else {
            xOrOList[index] = 'X';
            filledBoxes = filledBoxes + 1;
          }
          isTurnO = !isTurnO;

          cheakWinner();
        },
      );
    }
  }

  //اصل بازی و یه جورایی نوع قانون های بازی
  void cheakWinner() {
    if (boardSize == 3) {
      if (xOrOList[0] == xOrOList[1] &&
          xOrOList[1] == xOrOList[2] &&
          xOrOList[0] != '') {
        setResult(xOrOList[0], 'Winner is' + xOrOList[0]);
        return;
      }

      if (xOrOList[3] == xOrOList[4] &&
          xOrOList[4] == xOrOList[5] &&
          xOrOList[3] != '') {
        setResult(xOrOList[3], 'Winner is' + xOrOList[3]);
        return;
      }
      if (xOrOList[6] == xOrOList[7] &&
          xOrOList[7] == xOrOList[8] &&
          xOrOList[6] != '') {
        setResult(xOrOList[6], 'Winner is' + xOrOList[6]);
        return;
      }

      if (xOrOList[0] == xOrOList[3] &&
          xOrOList[3] == xOrOList[6] &&
          xOrOList[0] != '') {
        setResult(xOrOList[0], 'Winner is' + xOrOList[0]);
        return;
      }

      if (xOrOList[1] == xOrOList[4] &&
          xOrOList[4] == xOrOList[7] &&
          xOrOList[1] != '') {
        setResult(xOrOList[1], 'Winner is' + xOrOList[1]);
        return;
      }

      if (xOrOList[2] == xOrOList[5] &&
          xOrOList[5] == xOrOList[8] &&
          xOrOList[2] != '') {
        setResult(xOrOList[2], 'Winner is' + xOrOList[2]);
        return;
      }
      if (xOrOList[0] == xOrOList[4] &&
          xOrOList[4] == xOrOList[8] &&
          xOrOList[0] != '') {
        setResult(xOrOList[0], 'Winner is' + xOrOList[0]);
        return;
      }
      if (xOrOList[2] == xOrOList[4] &&
          xOrOList[4] == xOrOList[6] &&
          xOrOList[2] != '') {
        setResult(xOrOList[2], 'Winner is' + xOrOList[2]);
        return;
      }
      if (filledBoxes == 9) {
        setResult('', 'Draw');
      }
    }
    if (boardSize == 4) {
      //قانون بازی در حالت افقی
      if (xOrOList[0] == xOrOList[1] &&
          xOrOList[1] == xOrOList[2] &&
          xOrOList[2] != '') {
        setResult(xOrOList[0], 'Winner is' + xOrOList[0]);
        return;
      }
      if (xOrOList[1] == xOrOList[2] &&
          xOrOList[2] == xOrOList[3] &&
          xOrOList[3] != '') {
        setResult(xOrOList[1], 'Winner is' + xOrOList[1]);
        return;
      }
      if (xOrOList[4] == xOrOList[5] &&
          xOrOList[5] == xOrOList[6] &&
          xOrOList[6] != '') {
        setResult(xOrOList[4], 'Winner is' + xOrOList[4]);
        return;
      }
      if (xOrOList[5] == xOrOList[6] &&
          xOrOList[6] == xOrOList[7] &&
          xOrOList[7] != '') {
        setResult(xOrOList[4], 'Winner is' + xOrOList[4]);
        return;
      }
      if (xOrOList[8] == xOrOList[9] &&
          xOrOList[9] == xOrOList[10] &&
          xOrOList[10] != '') {
        setResult(xOrOList[8], 'Winner is' + xOrOList[8]);
        return;
      }
      if (xOrOList[9] == xOrOList[10] &&
          xOrOList[10] == xOrOList[11] &&
          xOrOList[11] != '') {
        setResult(xOrOList[9], 'Winner is' + xOrOList[9]);
        return;
      }
      if (xOrOList[12] == xOrOList[13] &&
          xOrOList[13] == xOrOList[14] &&
          xOrOList[14] != '') {
        setResult(xOrOList[12], 'Winner is' + xOrOList[12]);
        return;
      }
      if (xOrOList[13] == xOrOList[14] &&
          xOrOList[14] == xOrOList[15] &&
          xOrOList[15] != '') {
        setResult(xOrOList[13], 'Winner is' + xOrOList[13]);
        return;
      }
      //قانون بازی در حالت عمودی
      if (xOrOList[0] == xOrOList[4] &&
          xOrOList[4] == xOrOList[8] &&
          xOrOList[8] != '') {
        setResult(xOrOList[0], 'Winner is' + xOrOList[0]);
        return;
      }
      if (xOrOList[4] == xOrOList[8] &&
          xOrOList[8] == xOrOList[12] &&
          xOrOList[12] != '') {
        setResult(xOrOList[4], 'Winner is' + xOrOList[4]);
        return;
      }
      if (xOrOList[1] == xOrOList[5] &&
          xOrOList[5] == xOrOList[9] &&
          xOrOList[9] != '') {
        setResult(xOrOList[1], 'Winner is' + xOrOList[1]);
        return;
      }
      if (xOrOList[5] == xOrOList[9] &&
          xOrOList[9] == xOrOList[13] &&
          xOrOList[13] != '') {
        setResult(xOrOList[5], 'Winner is' + xOrOList[5]);
        return;
      }
      if (xOrOList[2] == xOrOList[6] &&
          xOrOList[6] == xOrOList[10] &&
          xOrOList[10] != '') {
        setResult(xOrOList[2], 'Winner is' + xOrOList[2]);
        return;
      }
      if (xOrOList[6] == xOrOList[10] &&
          xOrOList[10] == xOrOList[14] &&
          xOrOList[14] != '') {
        setResult(xOrOList[6], 'Winner is' + xOrOList[6]);
        return;
      }
      if (xOrOList[3] == xOrOList[7] &&
          xOrOList[7] == xOrOList[11] &&
          xOrOList[11] != '') {
        setResult(xOrOList[3], 'Winner is' + xOrOList[3]);
        return;
      }
      if (xOrOList[7] == xOrOList[11] &&
          xOrOList[11] == xOrOList[15] &&
          xOrOList[15] != '') {
        setResult(xOrOList[6], 'Winner is' + xOrOList[6]);
        return;
      }
      //قانون بازی در حالت ضربدری
      if (xOrOList[0] == xOrOList[5] &&
          xOrOList[5] == xOrOList[10] &&
          xOrOList[10] != '') {
        setResult(xOrOList[0], 'Winner is' + xOrOList[0]);
        return;
      }
      if (xOrOList[1] == xOrOList[6] &&
          xOrOList[6] == xOrOList[11] &&
          xOrOList[11] != '') {
        setResult(xOrOList[1], 'Winner is' + xOrOList[1]);
        return;
      }
      if (xOrOList[2] == xOrOList[5] &&
          xOrOList[5] == xOrOList[8] &&
          xOrOList[8] != '') {
        setResult(xOrOList[2], 'Winner is' + xOrOList[2]);
        return;
      }
      if (xOrOList[3] == xOrOList[6] &&
          xOrOList[6] == xOrOList[9] &&
          xOrOList[9] != '') {
        setResult(xOrOList[3], 'Winner is' + xOrOList[3]);
        return;
      }
      if (xOrOList[4] == xOrOList[9] &&
          xOrOList[9] == xOrOList[14] &&
          xOrOList[14] != '') {
        setResult(xOrOList[4], 'Winner is' + xOrOList[4]);
        return;
      }
      if (xOrOList[5] == xOrOList[10] &&
          xOrOList[10] == xOrOList[15] &&
          xOrOList[15] != '') {
        setResult(xOrOList[5], 'Winner is' + xOrOList[5]);
        return;
      }
      if (xOrOList[6] == xOrOList[9] &&
          xOrOList[9] == xOrOList[12] &&
          xOrOList[12] != '') {
        setResult(xOrOList[6], 'Winner is' + xOrOList[6]);
        return;
      }
      if (xOrOList[7] == xOrOList[10] &&
          xOrOList[10] == xOrOList[13] &&
          xOrOList[13] != '') {
        setResult(xOrOList[7], 'Winner is' + xOrOList[7]);
        return;
      }
      if (filledBoxes == 16) {
        setResult('', 'Draw');
        return;
      }
    }
  }
}
