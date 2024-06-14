import 'package:flutter/material.dart';

TextFormField textformfield(String label, TextEditingController controller,
        {TextInputType? keyBoardType,}) =>
    TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
          label: Text(
            label,
            style: const TextStyle(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Colors.deepOrange, width: 2.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: Colors.deepOrange, width: 2.5)),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.deepOrange, width: 2.5),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 15)),
      keyboardType: keyBoardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $label';
        }else if(keyBoardType==TextInputType.phone){
          if(!value.startsWith('+91')){
            return 'phone number should start with +91';
          }else if(value.length!=13){
            return 'please enter valid phone number';
          }
        }
        return null;
      },
    );

    
