import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/app_states.dart';
import '../../bloc/cubit.dart';
import '../size_config.dart';
import '../theme.dart';

class DefaultTextFormField extends StatefulWidget {
  final bool isPassword;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIconPressed;
  final Function? onPressSuffixIcon;
  final Function? onFilledSubmit;
  final Function? onChange;
  final Function validator;
  final double? borderRadius;
  final Widget? widget;
  const DefaultTextFormField(
      {Key? key,
        required this.isPassword,
        required this.textInputType,
        required this.controller,
        required this.validator,
        this.labelText,
        this.hintText,
        this.onFilledSubmit,
        this.onChange,
        this.borderRadius,
        this.onPressSuffixIcon,
        this.suffixIcon,
        this.suffixIconPressed,
        this.prefixIcon,
        required this.readOnly,
        this.widget})
      : super(key: key);
  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  FocusNode? _focusNode;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // ignore: sized_box_for_whitespace
    return BlocConsumer<AppCubit, AppStates>(

      listener: (context, state) {},
      builder:(context, state) {
        AppCubit cubit=AppCubit.get(context);
        return SizedBox(
          // color: !cubit.moodl? darkHeaderClr:Colors.white,
          height: 60,
          width: SizeConfig.screenWidth,
          child: TextFormField(
            readOnly: widget.readOnly,
            focusNode: _focusNode,
            style: Themes.bodyStyle,
            obscureText: widget.isPassword && hidePassword,
            controller: widget.controller,
            keyboardType: widget.textInputType,
            onFieldSubmitted: (String? value) {
              if (widget.onFilledSubmit != null) {
                widget.onFilledSubmit!();
              }
            },
            onChanged: (String? value) {
              if (widget.onChange != null) {
                widget.onChange!(value);
              }
            },
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(_focusNode);
              });
            },
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator(value);
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor:
              !cubit.model ? Theme.of(context).backgroundColor  : Colors.white,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? 10,
                ),
              ),
              labelText: widget.labelText,
              hintText: widget.hintText,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: (_focusNode!.hasFocus)
                      ? !cubit.model
                      ? Colors.white
                      : Colors.black
                      : Colors.grey.shade600),
              hintStyle: TextStyle(
                color: !cubit.model ? Colors.grey : Colors.black54,
              ),
              suffixIcon: widget.widget != null
                  ? widget.widget
                  : (widget.isPassword == true)
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                  hidePassword
                      ? widget.suffixIcon
                      : widget.suffixIconPressed,
                  color: _focusNode!.hasFocus ? primaryClr : Colors.grey,
                ),
              )
                  : widget.suffixIcon != null
                  ? IconButton(
                onPressed: () {
                  widget.onPressSuffixIcon!();
                },
                icon: Icon(widget.suffixIcon,
                    color: _focusNode!.hasFocus
                        ? primaryClr
                        : Colors.grey),
              )
                  : null,
              /* prefixIcon: Icon(
              widget.prefixIcon,
              color: _focusNode!.hasFocus ?primaryClr : Colors.grey,
            ),*/
            ),
          ),
        );
      },
    );
  }
}
