import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import 'package:hwarat/Core/APP/Utils.dart';

import '../../../Core/API_Endpoint/APICallCenter.dart';
import '../../../Core/APP/colors.dart';
import '../../../Core/APP/snackbar.dart';
import '../../../Core/Models/DataModels.dart';






class IncomingMessage extends StatefulWidget {
  final Function callback;
  final int functionNumber;
  const IncomingMessage({super.key,  required this.callback, required this.functionNumber,});

  @override
  State<IncomingMessage> createState() => _IncomingMessageState();
}

class _IncomingMessageState extends State<IncomingMessage> with AutomaticKeepAliveClientMixin{

  late StreamController<String> _stringStreamController;

  @override
  bool get wantKeepAlive => true;

  String changeableString = '';

  String changeableStringEnhanced = '';
  String changeableStringSaved = '';

  Stream? responseStream;

  double fontSize = 18;

  bool waitingStream = true;

  String callState = "IDLE";


  Future<void> processData(String data2) async {
  if (data2.contains("event:") && data2.contains("thread.message.delta")) {

    //Best Approach Regular expression to extract everything including the curly braces
    RegExp regExp = RegExp(r'\{.*?\}');

    String result = regExp.stringMatch(data2) ?? '';

    result = Utils.fixClosures(result);


    String decoded = "";


    try {
      decoded = jsonDecode(result)["delta"]["content"][0]["text"]["value"];
    } catch (e) {

      if (kDebugMode) {
        print("Failed to parse data $data2");
        print(result);
        print(e);
      }


    }
    changeableString += decoded;
    if (kDebugMode) {
      print(data2);
    }
    _stringStreamController.add(changeableString);
  }
  else if(data2.contains("event:") && data2.contains("thread.message.completed")){
    //Best Approach Regular expression to extract everything including the curly braces
    RegExp regExp = RegExp(r'\{.*?\}');

    String result = regExp.stringMatch(data2) ?? '';

    result = Utils.fixClosures(result);

    String decoded = "";
    try {
      decoded = jsonDecode(result)["content"][0]["text"]["value"];
    } catch (e) {
      if (kDebugMode) {
        print("Failed to parse data $data2");
        print(data2.codeUnits);
      }
    }

    changeableStringSaved = changeableString;

    setState(() {
      changeableString = decoded.replaceAll("†", "-").replaceAll("**", "");
    });
  }
  else if(data2.contains("[DONE]")){
    callState = "STREAM DONE";
    if(widget.functionNumber == 2){
      enhanceAnswerByAllam();
    }
    widget.callback(true);
  }
}

  Future<void> enhanceAnswerByAllam() async {
    callState = "ENHANCING";

    DetailedAPIResponse res = await ApiCall.askAllam(
        prompt: "<s> [INST]<<SYS>>fix any typos or grammar errors and answer in Arabic. اكتب الجواب باللهجة السعودية<</SYS>>\n\n $changeableString ً[/INST]");
    if(res.overriddenResponseCode == 200){
      callState = "ENHANCED";
      if (kDebugMode) {
        print(res.response!.data.toString());
      }

      changeableStringEnhanced = res.response!.data["results"][0]["generated_text"];

      setState(() {
        changeableString = changeableStringEnhanced;
      });
    }
    else{
      callState = "ENHANCING Failed";
      SnackBarManager.addNewTextSnackBar(context, text: res.uiMessage);
    }
  }

  Future<void> sendMessageToChatStream() async {


    if(widget.functionNumber == 1 || widget.functionNumber == 2){

      callState = "STREAM RECEIVE";

      responseStream = await ApiCall.runTheThreadStream();


      if (responseStream != null) {

        responseStream?.listen((event) async{

          waitingStream = false;


          String data2 = utf8.decode(event);


          await processData(data2);


        });

      } else {
        widget.callback(true);
        changeableString = 'حدث خطأ 1001 في الخادم يرجى إعادة الإرسال';
        if (kDebugMode) {
          print("Failed to handle response customIncomingMessage widget");
        }
      }
    }


  }

  Future<void> sendMessageToChatStreamFake() async {

    waitingStream = false;
    Stream.fromIterable(['مرحباً! ','كيف ','يمككني ','مساعدتك ','اليوم', '؟'])
        .asyncMap(
            (event) async {
              print('event');
              await Future.delayed(500.milliseconds);
              changeableString += event;
              _stringStreamController.add(event);

    }).listen((_){});



  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _stringStreamController = StreamController<String>();
    sendMessageToChatStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: _stringStreamController.stream,
        builder: (context,snapshot){
          Widget messageBubble = GestureDetector(
            onLongPress: () async {
              await Clipboard.setData(ClipboardData(text: changeableString));
              if(mounted){
                SnackBarManager.addNewTextSnackBar(context, text: "تم النسخ إلى الحافظة");
              }
            },
            onTap: (){
              if(fontSize != 18){
                setState(() {
                  fontSize = 18;
                });
              }
              SnackBarManager.addNewTextSnackBar(context, text: callState);
            },
            onDoubleTap: (){
              
            },
            onScaleUpdate: (details){
              setState(() {
                fontSize = clampDouble(fontSize * details.scale, 10, 30);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          MyColors.c2.withOpacity(0.8),
                          Colors.blueAccent[100]!
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    ),
                    borderRadius: const BorderRadius.only(
                      //Alignment.centerRight : Alignment.centerLeft
                      bottomLeft:
                      Radius.zero,
                      bottomRight:
                      Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                padding: const EdgeInsets.all(15),
                constraints: const BoxConstraints(maxWidth: 300),
                child: Directionality(
                  textDirection: material.TextDirection.rtl,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                      width: 300,
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(text: snapshot.hasError ? 'حدث خطأ في الخادم يرجى إعادة الإرسال' : changeableString,),
                            ]),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white,fontSize: fontSize),).animate().fadeIn(duration: 2.seconds),
                    ),
                  ),
                ),
              ),
            ),
          );

          if(snapshot.hasData){
            return messageBubble;
          }

          if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
            return Image.asset("assets/images/loader1.gif",fit: BoxFit.scaleDown,width: 200,height: 100,alignment: Alignment.centerLeft,);
          }

          changeableString = 'حدث خطأ في الخادم يرجى إعادة الإرسال';
          widget.callback(false);
          return messageBubble;
        }
    );
  }

}