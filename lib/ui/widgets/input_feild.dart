import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_app/bloc/app_states.dart';
import 'package:sqflite_app/bloc/cubit.dart';
import 'package:sqflite_app/ui/size_config.dart';

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
  final Function? validator;
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

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? labelText;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final String? hintText;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? cursorColor;
  final double radius;
  final double? height;
  final int? maxLines;
  final double horizontalPadding;
  final InputBorder? inputBorder;
  final InputBorder? inputEnabledBorder;
  final InputBorder? inputFocusedBorder;
  final InputBorder? inputDisabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final AlignmentGeometry? containerAlignment;
  final BoxConstraints? suffixIconConstraints;
  final bool readOnly;
  final int? maxLength;
  final int? errorMaxLines;
  final TextDirection? textDirection;
  final TextAlign textAlign;

  const DefaultFormField(
      {Key? key,
        required this.controller,
        this.validator,
        this.onTap,
        this.labelText,
        required this.keyboardType,
        this.onFieldSubmitted,
        this.onEditingComplete,
        this.onChanged,
        this.obscureText = false,
        this.prefixIcon,
        this.suffixIcon,
        this.initialValue,
        this.hintText,
        this.backgroundColor,
        this.height,
        this.radius = 30.0,
        this.maxLines,
        this.enabled = true,
        this.inputBorder =
        const OutlineInputBorder(borderSide: BorderSide(width: 1)),
        this.inputEnabledBorder,
        this.inputFocusedBorder,
        this.inputDisabledBorder,
        this.horizontalPadding = 0,
        this.textColor,
        this.labelColor = bluishClr,
        this.contentPadding,
        this.containerAlignment,
        this.suffixText,
        this.suffixTextStyle,
        this.suffixIconConstraints,
        this.readOnly = false,
        this.cursorColor,
        this.maxLength,
        this.errorMaxLines = 2,
        this.textDirection = TextDirection.ltr,
        this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: containerAlignment,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
      child: TextFormField(
        maxLength: maxLength,
        readOnly: readOnly,
        cursorColor: cursorColor,
        enabled: enabled,
        textAlignVertical: TextAlignVertical.center,
        textAlign: textAlign,
        maxLines: maxLines,
        textDirection: textDirection,
        initialValue: initialValue,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onTap: onTap,
        obscureText: obscureText,
        style: TextStyle(
          color: textColor,
        ),
        decoration: InputDecoration(
          counterText: '',
          suffixStyle: suffixTextStyle,
          suffixText: suffixText,
          errorMaxLines: errorMaxLines,
          contentPadding: contentPadding,
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIconConstraints: suffixIconConstraints,
          labelStyle: Theme.of(context).textTheme.caption!.copyWith(
            color: labelColor,
          ),
          labelText: labelText,
          border: inputBorder,
          enabledBorder: inputEnabledBorder,
          disabledBorder: inputDisabledBorder,
          focusedBorder: inputFocusedBorder,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          hintTextDirection: TextDirection.ltr,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  FocusNode? _focusNode;
  bool hintPassword = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SizedBox(
          height: 60,
          width: SizeConfig.screenWidth,
          child: TextFormField(
              readOnly: widget.readOnly,
              focusNode: _focusNode,
              style: Themes.bodyStyle,
              obscureText: widget.isPassword && hintPassword,
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
                  return widget.validator!(value);
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: !cubit.model
                      ? Theme.of(context).backgroundColor
                      : Colors.white,
                  border: UnderlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 10),
                  ),
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: (_focusNode!.hasFocus)
                        ? !cubit.model
                            ? Colors.white
                            : Colors.black
                        : Colors.grey.shade600,
                  ),
                  hintStyle: TextStyle(
                      color: !cubit.model ? Colors.grey : Colors.black54),
                  suffixIcon: widget.widget != null
                      ? widget.widget
                      : (widget.isPassword == true)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  hintPassword = !hintPassword;
                                });
                              },
                              icon: Icon(
                                hintPassword
                                    ? widget.suffixIcon
                                    : widget.suffixIconPressed,
                              ),
                              color:
                                  _focusNode!.hasFocus ? primaryClr : Colors.grey)
                          : null)),
        );
      },
    );
  }
}
