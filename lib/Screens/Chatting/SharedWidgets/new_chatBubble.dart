
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../../../Core/APP/colors.dart';
import '../../../Core/APP/snackbar.dart';
import 'package:flutter_math_fork/flutter_math.dart';





class NewChatBubble extends StatefulWidget {
  final String text;
  final bool user;
  final bool disableAlignment;

  const NewChatBubble({super.key, required this.text, required this.user, this.disableAlignment = false});

  @override
  State<NewChatBubble> createState() => _NewChatBubbleState();
}

class _NewChatBubbleState extends State<NewChatBubble> {


  bool showCopyButton = false;


  double fontSize = 18;

  Widget buildAlignment(Widget myBubble){
    return widget.disableAlignment ?
    myBubble :
    Align(
      alignment: (widget.user ? Alignment.centerRight : Alignment.centerLeft),
      child: myBubble,
    );
  }


  @override
  Widget build(BuildContext context) {
    return buildAlignment(
        GestureDetector(
          onLongPress: () async {
            await Clipboard.setData(ClipboardData(text: widget.text));
            if(mounted){
              SnackBarManager.addNewTextSnackBar(context, text: "تم النسخ إلى الحافظة");
            }
          },

          child: Container(
            constraints: const BoxConstraints(
                maxWidth: 300
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: widget.user ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        showCopyButton = !showCopyButton;
                        fontSize = 18;
                      });
                    },
                    onDoubleTap: (){
                      setState(() {
                        fontSize = clampDouble(fontSize - 2, 10, 30);
                      });
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
                            color: widget.user ? Colors.grey.withOpacity(0.8) : MyColors.c3.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              //Alignment.centerRight : Alignment.centerLeft
                              bottomLeft:
                              widget.user ? const Radius.circular(15) : Radius.zero,
                              bottomRight:
                              widget.user ? Radius.zero : const Radius.circular(15),
                              topLeft: const Radius.circular(15),
                              topRight: const Radius.circular(15),
                            )),
                        padding: const EdgeInsets.all(15),
                        constraints: const BoxConstraints(maxWidth: 270),
                        child: Text(widget.text,style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white,fontSize: fontSize),),
                      ),
                    ),
                  ),
                ),
                showCopyButton ?
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.grey, size: 30,),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: widget.text));
                  },).animate().fade(duration: 500.milliseconds) :
                const SizedBox()
              ],
            ),
          ),
    )
    );
  }
}
