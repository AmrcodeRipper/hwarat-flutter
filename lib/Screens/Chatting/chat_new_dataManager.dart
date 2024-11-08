import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:hwarat/Core/API_Endpoint/APICallCenter.dart';

import 'SharedWidgets/chatBubble.dart';
import 'SharedWidgets/new_chatBubble.dart';




class SpecificChatDataController {

  static SpecificChatDataController instance = SpecificChatDataController();

  static List<Widget> messages = [];


  ValueNotifier<bool> newMessage = ValueNotifier(false);

  bool initialized = false;

  Future<void> init(String chatId) async {
    if(initialized){
      return;
    }
    initialized = true;
    await ApiCall.createThread();
    await ApiCall.generateIBMToken();
    generatePlaceHolderMessages();
  }


  void generatePlaceHolderMessages(){
    messages.clear();
    messages.add(const NewChatBubble(text:"مرحباً",user:true));
    messages.add(const NewChatBubble(text:"أهلاً وسهلاً \nهذا مساعد الذكاء الاصطناعي ياسر الحزيمي تستطيع محادثتي وكأنك تتحدث إليه",user:false));
    messages.add(const NewChatBubble(text:"مثلاً: ما هي النصيحة التي يكرهها الإنسان؟",user:false));
  }

  void clearPlaceHolders(){
    messages.clear();
  }


  void parseData(){
    messages.add(
        const SizedBox(
          width: double.infinity,
          child: Align(
              alignment: "user" == "user"
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: ChatBubble(text: "", user: "user" == "user" ? true : false,)),
        ).animate().fadeIn()
    );
    SpecificChatDataController.instance.newMessage.value = !SpecificChatDataController.instance.newMessage.value;
  }

}