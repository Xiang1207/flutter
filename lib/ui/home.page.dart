import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_work_calendar/services/theme_services.dart';
import 'package:flutter_work_calendar/ui/add_task_bar.dart';
import 'package:flutter_work_calendar/ui/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/notification_serivce.dart';
import 'package:flutter_work_calendar/ui/theme.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  late NotifyHelper notifyHelper;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          //_addDateBar
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: DatePicker(
               DateTime.now(),
              height:100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                )
              ),
              dayTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey
                    )
                ),
              monthTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey
                    )
                ),
              onDateChange: (date){
                 _selectedDate=date;
              },
            ),
          )
          //_addDateBar
        ],
      ),
    );
  }
}
//_addDateBar(){ }_addDateBar加上去_selectedDate=date;會出現未知錯誤
_addTaskBar(){
  return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle,
                  ),
                  Text("Today",
                    style: headingStyle,
                  )
                ],
              )
          ),
          MyButton(label: "+新增行程", onTap: ()=>Get.to(AddTaskPage()))
        ],
      )
  );
}

_appBar(){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,//將backgroundColor設置為透明
    //backgroundColor: context.theme.backgroundColor,
    leading: GestureDetector(
      onTap: () {
        ThemeService().switchTheme();
        var notifyHelper = NotifyHelper(); // 初始化 NotifyHelper 物件
        notifyHelper.initializeNotification(); // 執行初始化通知的方法

        notifyHelper.displayNotification(
            title: "主題已更改",
            body: Get.isDarkMode ? "亮色主題" : "暗色主題"
        );

        notifyHelper.scheduledNotification();
      },

      child: Icon(Get.isDarkMode?Icons.wb_sunny_outlined:Icons.nightlight_round,
      //左上角月亮太陽圖案變更
          size: 20,
        color: Get.isDarkMode? Colors.white:Colors.black
      ),
    ),
    actions: [
      CircleAvatar(
        backgroundImage: AssetImage(
          "images/profile.png"
        ),
      ),
      SizedBox(width: 20,),
    ],
  );
}