import 'package:flutter/material.dart';
import 'package:multivendor/provider/properties_pro.dart';

propertyOverviewWidget(properties_pro modelValue){

  return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Type
        PhysicalModel(
          color: const Color.fromARGB(255, 243, 243, 243),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Type",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    (modelValue.dPropertyTypeId.toString() == "1")
                        ? "Home"
                        : (modelValue.dPropertyTypeId.toString() == "2")
                            ? "Plots"
                            : (modelValue.dPropertyTypeId.toString() == "3")
                                ? "Commerical"
                                : "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //Baths
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              const Expanded(
                child: const Text(
                  "Baths",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  modelValue.dPropertyBathroom,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

//bedrooms
        PhysicalModel(
          color: const Color.fromARGB(255, 243, 243, 243),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Bedrooms",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    modelValue.dPropertyBedroom,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //Baths
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              const Expanded(
                child: const Text(
                  "Purpose",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  (modelValue.dPropertyPurpose.toString() == "1")
                      ? " Rent"
                      : (modelValue.dPropertyTypeId.toString() == "2")
                          ? " Sell"
                          : " ",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        //area
        PhysicalModel(
          color: const Color.fromARGB(255, 243, 243, 243),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Area",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${modelValue.dPropertyArea} ${(modelValue.dPropertyAreaUnit.toString() == "1") ? "Marla" : (modelValue.dPropertyAreaUnit.toString() == "2") ? "Square Feet" : (modelValue.dPropertyAreaUnit.toString() == "3") ? "Square Yards" : (modelValue.dPropertyAreaUnit.toString() == "4") ? "Square Meters" : (modelValue.dPropertyAreaUnit.toString() == "5") ? "Kanal" : ""}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

//Condition
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              const Expanded(
                child: const Text(
                  "Condition",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${modelValue.dPropertyCondition}/10",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  
  
  
  }