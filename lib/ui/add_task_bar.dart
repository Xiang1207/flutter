import 'package:flutter/material.dart';
import 'package:flutter_work_calendar/ui/theme.dart';
import 'package:flutter_work_calendar/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_http_request.dart';
import 'package:intl/intl.dart';


class AddTaskPage extends StatefulWidget{
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime="9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  //startTime顯示目前時區 UTC 時區
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right:20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "新增行程",
                style: headingStyle,
              ),
              MyInputField(title: "標題", hint: "請輸入標題"),
              MyInputField(title: "事項", hint: "請輸入詳細事項"),
              MyInputField(title: "日期", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: (){
                    print("Hi there");
                    _getDateFromUser();
                  },
                ),),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                        title: "開始日期",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: (){
                            _gerTimeFromUser(isStarTime:true);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color:Colors.grey,
                          ),
                        ),
                      )),
                  SizedBox(width: 12,),
                  Expanded(
                      child: MyInputField(
                        title: "結束日期",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: (){

                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color:Colors.grey,
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,//將backgroundColor設置為透明
      //backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },

        child: Icon(Icons.arrow_back_ios,
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

  _getDateFromUser() async {
    DateTime? _pickerDate =await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121)
    );

    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    }else{
      print("它為空或有問題");
    }
  }

  _gerTimeFromUser({required bool isStarTime}) async {
    TimeOfDay? pickedTime = await _showTimePickerMethod();
    String _formatedTime;
    if (pickedTime == null) {
      setState(() {});
    } else {
      _formatedTime = pickedTime!.format(context);
      if (isStarTime == true) {
        _startTime = _formatedTime;
      } else if (isStarTime == false) {
        _endTime = _formatedTime;
      }
    }
  }

  _showTimePickerMethod() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: 9,
            minute: 10
        )
    );
  }

}

