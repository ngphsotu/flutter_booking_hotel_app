// import 'package:flutter/material.dart';

// class XTextFormField extends StatefulWidget {
//   final Key key;
//   final bool enable;
//   final int maxLine;
//   final bool readOnly;
//   final FocusNode focusNode;
//   final bool autoFocus;
//   final TextEditingController controller;
//   final bool obscureText;
//   final TextInputAction textInputAction;
//   final Function onFieldSubmitted;
//   final bool border;
//   final bool contentCenter;
//   final Color textColor;
//   final String hintText;
//   final String suffixText;
//   final Widget prefixIcon;
//   final Widget suffixIcon;
//   final double verticalPadding;
//   final Function onTap;
//   final Function onFocus;
//   final Function onChanged;
//   final Function onSubmitted;
//   final Function onClickPrefix;
//   final Function onClickSuffix;
//   final Function funcValidation;
//   final TextInputType textInputType;
//   const XTextFormField({
//     super.key,
//     this.key,
//     this.maxLine = 1,
//     this.verticalPadding = 20,
//     this.enable = true,
//     this.border = true,
//     this.readOnly = false,
//     this.autoFocus = false,
//     this.obscureText = false,
//     this.contentCenter = false,
//     this.textColor = Colors.black87,
//     this.textInputType = TextInputType.text,
//     this.hintText,
//     this.suffixText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onTap,
//     this.onFocus,
//     this.onChanged,
//     this.onSubmitted,
//     this.onClickPrefix,
//     this.onClickSuffix,
//     this.funcValidation,
//     this.onFieldSubmitted,
//     this.focusNode,
//     this.textInputAction,
//     this.controller,
//   });

//   @override
//   _XTextFormFieldFocusNodeState createState() =>
//       _XTextFormFieldFocusNodeState();
// }

// class _XTextFormFieldFocusNodeState extends State<XTextFormField> {
//   late String errorText;

//   bool errorBorder = false;

//   @override
//   Widget build(BuildContext context) {
//     return Focus(
//       onFocusChange: (hasFocus) {
//         if (hasFocus) {
//           if (widget.onFocus != null) widget.onFocus();
//         }
//       },
//       child: TextFormField(
//         key: widget.key,
//         enabled: widget.enable,
//         maxLines: widget.maxLine,
//         readOnly: widget.readOnly,
//         focusNode: widget.focusNode,
//         autofocus: widget.autoFocus,
//         textAlign: (widget.contentCenter) ? TextAlign.center : TextAlign.left,
//         controller: widget.controller,
//         obscureText: widget.obscureText,
//         textInputAction: widget.textInputAction,
//         onFieldSubmitted: widget.onFieldSubmitted,
//         obscuringCharacter: '*',
//         onTap: () {
//           widget.onTap?.call();
//         },
//         style: TextStyle(
//           color: widget.textColor,
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//           decoration: TextDecoration.none,
//         ),
//         keyboardType: widget.textInputType,
//         validator: (value) {
//           if (widget.funcValidation != null) {
//             if (widget.funcValidation(value) != null) {
//               setState(() {
//                 errorText = widget.funcValidation(value);

//                 errorBorder = false;
//               });
//             } else {
//               setState(() {
//                 errorText = null;

//                 errorBorder = true;
//               });
//             }
//             return widget.funcValidation(value);
//           }
//           setState(() {
//             errorText = null;

//             errorBorder = false;
//           });
//           return null;
//         },
//         onChanged: widget.onChanged,
//         decoration: InputDecoration(
//           hintText: widget.hintText,
//           contentPadding: (widget.contentCenter)
//               ? const EdgeInsets.symmetric(
//                   vertical: 0,
//                   horizontal: 0,
//                 )
//               : EdgeInsets.symmetric(
//                   vertical: widget.verticalPadding,
//                   horizontal: 15,
//                 ),
//           hintStyle: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//             fontWeight: FontWeight.w600,
//           ),
//           prefixIcon: widget.prefixIcon,
//           suffixIcon: widget.suffixIcon,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//             borderSide: BorderSide(
//               width: 1,
//               color: AppColors.grey,
//             ),
//           ),
//           enabledBorder: (errorBorder)
//               ? OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 1,
//                     color: Colors.transparent,
//                   ),
//                 )
//               : OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 1,
//                     color: Colors.grey,
//                   ),
//                 ),
//           disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//             borderSide: BorderSide(
//               width: 1,
//               color: Colors.grey,
//             ),
//           ),
//           focusedErrorBorder: (widget.border)
//               ? const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 1,
//                     color: Colors.red,
//                   ),
//                 )
//               : OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 1,
//                     color: Colors.transparent,
//                   ),
//                 ),
//           errorBorder: (widget.border)
//               ? const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 2,
//                     color: Colors.red,
//                   ),
//                 )
//               : OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 1,
//                     color: Colors.transparent,
//                   ),
//                 ),
//           focusedBorder: (widget.border)
//               ? OutlineInputBorder(
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 2,
//                     color: AppColors.primaryColor,
//                   ),
//                 )
//               : OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                   borderSide: BorderSide(
//                     width: 2,
//                     color: Colors.transparent,
//                   ),
//                 ),
//           counterStyle: TextStyle(
//             fontSize: 12,
//           ),
//           suffixText: widget.suffixText,
//           prefixStyle: TextStyle(
//             color: Colors.black,
//           ),
//           errorStyle: TextStyle(
//             fontSize: 12,
//             color: Colors.transparent,
//           ),
//           counterText: errorText,
//           filled: true,
//           fillColor: AppColors.grey,
//         ),
//       ),
//     );
//   }
// }

// class XDropBoxTextFormField<T> extends StatefulWidget {
//   final Function funcValidation;

//   final String hintText;

//   final int maxLine;

//   final List<T> items;

//   final List<DropdownMenuItem<T>> dropDownItems;

//   final T initValue;

//   final Function callback;

//   final Widget prefixIcon;

//   final Key key;

//   final String idDayStart;

//   final String align;

//   final String region;

//   final String currency;

//   final String accountGroup;

//   final bool isPrefixIcon;

//   XDropBoxTextFormField({
//     this.funcValidation,
//     @required this.hintText,
//     this.maxLine = 1,
//     this.items,
//     this.dropDownItems,
//     this.initValue,
//     this.callback,
//     this.idDayStart,
//     this.prefixIcon,
//     this.key,
//     this.currency,
//     this.region,
//     this.accountGroup,
//     this.align,
//     this.isPrefixIcon = true,
//   }) : super(key: key);

//   @override
//   _XDropBoxTextFormFieldState<T> createState() => _XDropBoxTextFormFieldState();
// }

// class _XDropBoxTextFormFieldState<T> extends State<XDropBoxTextFormField> {
//   String errorText;

//   T value;

//   String name = '';

//   @override
//   void initState() {
//     super.initState();
//     if (widget.idDayStart != null) {
//       value = widget.items.firstWhere(
//           (element) => element.id == widget.idDayStart,
//           orElse: () => value = null);
//     }

//     if (widget.align != null) {
//       value = widget.items.firstWhere((element) => element.id == widget.align,
//           orElse: () => value = null);
//       if (value != null) {
//         widget.callback(value);
//       }
//     }

//     if (widget.region != null) {
//       value = widget.items.firstWhere(
//           (element) => element.name == widget.region,
//           orElse: () => value = null);
//       if (value != null) {
//         widget.callback(value);
//       }
//     }

//     if (widget.currency != null) {
//       value = widget.items.firstWhere(
//           (element) => element.name == widget.currency,
//           orElse: () => value = null);
//       if (value != null) {
//         widget.callback(value);
//       }
//     }

//     if (widget.initValue != null) value = widget.initValue;
//     print(widget.accountGroup);
//     if (widget.accountGroup != null) {
//       value = widget.items.firstWhere(
//           (element) => element.id == widget.accountGroup,
//           orElse: () => value = null);
//       if (value != null) widget.callback(value);
//     }
//   }

//   @override
//   void didUpdateWidget(covariant XDropBoxTextFormField oldWidget) {
//     if (widget.idDayStart != null) {
//       value = widget.items.firstWhere(
//           (element) => element.id == widget.idDayStart,
//           orElse: () => value = null);
//     }

//     if (widget.align != null) {
//       value = widget.items.firstWhere((element) => element.id == widget.align,
//           orElse: () => value = null);
//       if (value != null) {
//         widget.callback(value);
//       }
//     }

//     if (widget.region != null) {
//       value = widget.items.firstWhere(
//           (element) => element.name == widget.region,
//           orElse: () => value = null);
//       if (value != null) {
//         widget.callback(value);
//       }
//     }

//     if (widget.currency != null) {
//       value = widget.items.firstWhere(
//           (element) => element.name == widget.currency,
//           orElse: () => value = null);
//       if (value != null) {
//         widget.callback(value);
//       }
//     }

//     if (widget.initValue != null) value = widget.initValue;
//     print(widget.accountGroup);
//     if (widget.accountGroup != null) {
//       value = widget.items.firstWhere(
//           (element) => element.id == widget.accountGroup,
//           orElse: () => value = null);
//       if (value != null) widget.callback(value);
//     }
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ((widget.items == null || widget.items.isEmpty) &&
//             (widget.dropDownItems == null || widget.dropDownItems.isEmpty))
//         ? XTextFormField(
//             enable: false,
//             hintText: (value != null) ? name : widget.hintText,
//             suffixIcon: Icon(
//               Icons.keyboard_arrow_down,
//               color: widget.isPrefixIcon ? Colors.grey : Colors.transparent,
//             ),
//             prefixIcon: widget.prefixIcon,
//           )
//         : DropdownButtonFormField<T>(
//             value: value,
//             isExpanded: true,
//             focusColor: AppColors.grey,
//             icon: Icon(
//               Icons.keyboard_arrow_down,
//               color: widget.isPrefixIcon
//                   ? AppColors.primaryColor
//                   : Colors.transparent,
//             ),
//             items: widget.dropDownItems ??
//                 widget.items.map((e) {
//                   return DropdownMenuItem<T>(
//                     value: e,
//                     child: Text(e.name, overflow: TextOverflow.ellipsis),
//                   );
//                 }).toList(),
//             onChanged: (newValue) {
//               value = newValue;
//               widget.callback(value);
//             },
//             decoration: InputDecoration(
//               prefixIcon: widget.prefixIcon,
//               contentPadding: EdgeInsets.symmetric(
//                 vertical: 5,
//                 horizontal: (widget.prefixIcon != null) ? 5 : 15,
//               ),
//               hintText: widget.hintText,
//               hintStyle: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(5),
//                 ),
//                 borderSide: BorderSide(
//                   width: 2,
//                   color: AppColors.grey,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 borderSide: BorderSide(
//                   width: 2,
//                   color: AppColors.grey,
//                 ),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 borderSide: BorderSide(
//                   width: 2,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 borderSide: BorderSide(
//                   width: 2,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               counterStyle: TextStyle(
//                 fontSize: 13,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//               counterText: errorText,
//             ),
//           );
//   }
// }

// class XDropDown2 extends StatefulWidget {
//   final List<ItemModel> list;

//   final Function callBack;

//   final ItemModel init;

//   final String hintText;

//   XDropDown2({
//     this.list,
//     this.callBack,
//     this.init,
//     this.hintText = 'Choose',
//   });

//   @override
//   _XDropDown2State createState() => _XDropDown2State();
// }

// class _XDropDown2State extends State<XDropDown2> {
//   ItemModel itemModel;

//   @override
//   void initState() {
//     widget.list.forEach((element) {
//       if (widget.init != null &&
//           (element.id == widget.init.id || element.name == widget.init.name)) {
//         itemModel = element;
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.grey,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10, right: 10),
//         child: Center(
//           child: DropdownButton<ItemModel>(
//             underline: SizedBox(),
//             isExpanded: true,
//             value: itemModel,
//             hint: Text(widget.hintText),
//             onChanged: (ItemModel value) {
//               setState(() {
//                 itemModel = value;
//               });
//               widget.callBack(itemModel);
//             },
//             items: widget.list.map((ItemModel user) {
//               return DropdownMenuItem<ItemModel>(
//                 value: user,
//                 child: Text(
//                   user.name,
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }



/**
class ReuseduceTextFormField extends StatefulWidget {
  final int? maxLine;
  final bool? border;
  final bool? enabled;
  final bool readOnly;
  final bool autoFocus;
  final bool obscureText;
  final Color? textColor;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onTap;
  final Function? onFocus;
  final Function? onSubmitted;
  final Function? onClickPrefix;
  final Function? onClickSuffix;
  final Function? funcValidation;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  const ReuseduceTextFormField({
    super.key,
    this.maxLine = 1,
    this.textColor = AppColors.black,
    this.border = true,
    this.enabled = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.obscureText = false,
    this.onTap,
    this.onFocus,
    this.onChanged,
    this.labelText,
    this.focusNode,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
    this.keyboardType,
    this.onClickPrefix,
    this.onClickSuffix,
    this.funcValidation,
    this.textInputAction,
    required InputDecoration decoration,
  });

  @override
  State<ReuseduceTextFormField> createState() =>
      _ReuseduceTextFormFieldFocusNodeState();
}

class _ReuseduceTextFormFieldFocusNodeState
    extends State<ReuseduceTextFormField> {
  //late final Key key;
  //late String errorText;
  bool errorBorder = false;
  bool contentCenter = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          if (widget.onFocus != null) widget.onFocus!();
        }
      },
      child: TextFormField(
        onTap: () {
          widget.onTap?.call();
        },
        enabled: widget.enabled,
        maxLines: widget.maxLine,
        readOnly: widget.readOnly,
        autofocus: widget.autoFocus,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        textAlign: contentCenter ? TextAlign.center : TextAlign.left,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        // validator: (value) {
        //   if (widget.funcValidation != null) {
        //     if (widget.funcValidation!(value) != null) {
        //       setState(() {
        //         errorText = widget.funcValidation!(value);
        //         errorBorder = false;
        //       });
        //     } else {
        //       setState(() {
        //         errorText = '';
        //         errorBorder = true;
        //       });
        //     }
        //     return widget.funcValidation!(value);
        //   }
        //   setState(() {
        //     errorText = '';
        //     errorBorder = false;
        //   });
        //   return null;
        // },
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.deepOrange),
          ),
        ),
      ),
    );
  }
}
 */