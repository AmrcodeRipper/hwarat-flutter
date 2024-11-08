
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../APP/Utils.dart';
import '../APP/colors.dart';





class TextFieldAK extends StatefulWidget {
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String hintString;
  final TextInputAction textInputAction;
  final bool showObscured;
  final bool highlight;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function? onTap;

  TextFieldAK({super.key, this.prefixIcon, required this.hintString, this.textInputAction = TextInputAction.next, this.focusNode, this.nextFocusNode, this.showObscured = false, this.highlight = true, this.textEditingController, this.onChanged, this.onTap, this.onSubmitted, this.suffixIcon}):assert((prefixIcon?.icon == null || prefixIcon?.icon is Icon) && (suffixIcon?.icon == null || suffixIcon?.icon is Icon));

  @override
  State<TextFieldAK> createState() => _TextFieldAKState();
}

class _TextFieldAKState extends State<TextFieldAK> {

  bool typing = false;
  bool notObscured = true;

  late TextEditingController _tf;
  final ScrollController _tfScrollController = ScrollController();

  void toggleHighlightField(bool focused){
    if(focused){
      setState(() {
        typing = true;
      });
    }
    else{
      setState(() {
        typing = false;
      });
    }
  }

  @override
  void initState() {
    notObscured = widget.showObscured;
    if(widget.textEditingController != null){
      _tf = widget.textEditingController!;
    }
    else{
      _tf = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused){
        toggleHighlightField(focused);
      },
      child: TextField(
        controller: _tf,
        scrollController: _tfScrollController,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black,fontSize: 18),
        textInputAction: widget.textInputAction,
        focusNode: widget.focusNode,
        obscureText: notObscured,
        maxLines: widget.showObscured ? 1 : 5,
        minLines: 1,
        onTap: (){
          if(widget.onTap != null){
            widget.onTap!();
          }
        },
        onChanged: (s){
          if(widget.onChanged != null){
            widget.onChanged!(s);
          }
        },
        onSubmitted: (s){
          if(widget.nextFocusNode != null){
            FocusScope.of(context).requestFocus(widget.nextFocusNode);
          }
          else if(widget.textInputAction != TextInputAction.newline){
            FocusScope.of(context).requestFocus(FocusNode());
          }
          if(widget.onSubmitted != null){
            widget.onSubmitted!(s);
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14,horizontal: 12),
          prefixIcon: widget.prefixIcon != null ?
          IconButton(
              onPressed: (){
                if(widget.prefixIcon?.onPressed != null){
                  widget.prefixIcon!.onPressed!();
                }
              },
              icon: Icon((widget.prefixIcon?.icon as Icon).icon,color: (typing && widget.highlight) ? MyColors.c1 : Colors.grey,size: widget.prefixIcon?.iconSize,)) :
          null,
          suffixIcon: widget.suffixIcon != null ?
          IconButton(
            icon: (widget.showObscured)
                ? Icon(Icons.remove_red_eye,color: (typing && widget.highlight) ? MyColors.c1 : Colors.grey)
                : widget.suffixIcon != null ? Icon((widget.suffixIcon?.icon as Icon).icon,color: (typing && widget.highlight) ? MyColors.c1 : Colors.grey,size: widget.suffixIcon?.iconSize,) : const SizedBox(),
            onPressed: () {
              if(widget.showObscured){
                setState(() {
                  notObscured = !notObscured;
                });
              }
              if(widget.suffixIcon?.onPressed != null){
                widget.suffixIcon!.onPressed!();
              }
            },) :
          null,
          filled: true,
          fillColor: (typing && widget.highlight) ? MyColors.c1.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.c3),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: widget.hintString,
          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: (typing && widget.highlight) ? MyColors.c1 : Colors.grey,fontSize: 14),
          hintTextDirection: Utils.getTextDirection(context),
          counter: const Text(''),
        ),
      ),
    );
  }
}
