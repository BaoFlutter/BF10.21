import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_flutter/controllers/information_controller.dart';
import 'package:widget_flutter/resources/strings.dart';
import 'package:widget_flutter/resources/widgets/common_widget.dart';
import 'package:widget_flutter/views/information_from_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
// 1. Tạo ra State , 2. Gán State - Context , context đại diện cho 1 widget
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController? usernameController, birthYearController;
  String userName = NOT_DEFINE;
  String age = NOT_DEFINE;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final informationController = Get.put(InformationController()) ;



// 3 . khởi tạo state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController();
    birthYearController = TextEditingController();
   // 1. khởi tạo state
    // 2. được dùng để đặt các lệnh thực thi trước khi build : load dữ liệu từ cơ sở dữ liệu
    // 3. context không hoạt động
  }

  // 4. Chạy khi load Dependency và khi Dependency thay đổi , lúc này Widget có context
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  // 6. Gọi khi Widget configuration thay đổi
  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  //8 . Xoá State khỏi Tree , xảy ra khi huỷ widget đó
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  // 9. huỷ state đi
  @override
  void dispose() {
    // TODO: implement dispose
    print("Hàm dispose được chaỵ, state bị xoá");
    if(!mounted) { print ("Biến mounted là false "); }

    super.dispose();
    usernameController!.dispose();
    birthYearController!.dispose();
  }

// 5. Hàm build
  @override
  Widget build(BuildContext context) {
    // 2. mounted = true ;
    if(mounted) {print("Mounted đã tạo ra");}
    print("Hàm build được chạy ") ;

    return Scaffold(

      appBar: AppBar(
        title: Text(USER_INFORMATION),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Tên Widget
              textInputWidget(
                  labelText: USER_NAME,
                  hintText: USER_NAME_HERE,
                  controller: usernameController),
              // Năm sinh Widget
              textInputWidget(
                  labelText: BIRTH_YEAR,
                  hintText: BIRTH_YEAR_HERE,
                  controller: birthYearController),
              // Xac nhan Buttons
              ElevatedButton(onPressed: (){
                // 7. Hàm setState : Build lại toàn bộ các Widget , kể cả các widget không liên quan
                setState(() {
                  userName = usernameController!.text;
                  age = (DateTime.now().year - int.parse(birthYearController!.text)).toString();
                });
                informationController.updateInformation(userName: userName, age: age);

              }, child: Text(CONFIRM)),
              /*
              confirmationButton(
                  onPressed: (){
                   setState(() {
                     userName = usernameController!.text;
                     age = (DateTime.now().year - int.parse(birthYearController!.text)).toString();
                   });
                  },
                  lableButton: "Xác nhận"),

               */
              // Information Widget
              informationWidget(
                  userNameContent: userName,
                  ageContent: age),
              // Next Page Button Widget
              TextButton(
                  onPressed: (){
                    Get.to(()=>InformationFromController());
                  },
                  child: Text(NEXT_PAGE))

            ],
          ) ,
        ),
      )
    );
  }

}
