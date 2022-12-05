import 'package:buy_idea/component/common/account/sign_up_id_text_form.dart';
import 'package:buy_idea/component/common/account/sign_up_nickname_text_form.dart';
import 'package:buy_idea/component/common/account/sign_up_password_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SignUpFormField extends StatefulWidget {
  SignUpFormField({Key? key}) : super(key: key);

  @override
  State<SignUpFormField> createState() => _SignUpFormFieldState();
}

class _SignUpFormFieldState extends State<SignUpFormField> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();

  bool checkedValue = false;

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SizedBox(
          height: 644,
          child: Column(
            children: [
              SignUpIdTextForm(controller: idController),
              SizedBox(height: 20),
              SignUpPasswordTextForm(
                  controller: passwordController,
                  confirmController: confirmPasswordController),
              SizedBox(height: 20),
              SignUpNicknameTextForm(
                  controller: nicknameController, textFieldName: "닉네임"),
              SizedBox(height: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "약관동의",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 500,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "약관동의 테스트 1\n"
                                  "약관동의 테스트 2\n"
                                  "약관동의 테스트 3\n"
                                  "약관동의 테스트 4\n"
                                  "약관동의 테스트 5\n"
                                  "약관동의 테스트 6\n"
                                  "약관동의 테스트 7\n"
                                  "약관동의 테스트 8\n",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            )),
                      )
                    ],
                  ))),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "위 내용에 동의합니다.",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                        value: checkedValue,
                        onChanged: (value) {
                          setState(() {
                            checkedValue = value!;
                          });
                        })
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Color(0xff2F4F4F),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (SignUpIdTextForm.buttonStateValue == true &&
                        SignUpNicknameTextForm.buttonStateValue == true) {
                      var validation = null;
                      // MemberSpringApi().singUp(UserSingUpRequest(
                      //     idController.text,
                      //     confirmPasswordController.text,
                      //     nicknameController.text));
                      validation.then((value) {
                        if (value.success == true) {
                          //추후 페이지 연결
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectSignInPage()));
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Text(
                                    "오류",
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                              color: Color(0xFF2F4F4F)),
                                        ))
                                  ],
                                );
                              });
                        }
                      });
                    }
                  }
                },
                child: Text("가입하기", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ));
  }
}
