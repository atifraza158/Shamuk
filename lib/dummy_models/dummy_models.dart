import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';

class ProfileModel {
  final Icon icon;
  final String title;
  ProfileModel({required this.icon, required this.title});
}

List<ProfileModel> profilemodel = [
  ProfileModel(
    icon: const Icon(
      Icons.person_outline,
      color: themewhitecolor,
    ),
    title: "Edit Profile",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.room_outlined,
      color: themewhitecolor,
    ),
    title: "Address",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.notifications_none,
      color: themewhitecolor,
    ),
    title: "Notification",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.payment,
      color: themewhitecolor,
    ),
    title: "Payment",
  ),
  // ProfileModel(
  //   icon: const Icon(
  //     Icons.security_outlined,
  //     color: themewhitecolor,
  //   ),
  //   title: "Security",
  // ),
  ProfileModel(
    icon: const Icon(
      Icons.language_outlined,
      color: themewhitecolor,
    ),
    title: "Language",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.lock_outline,
      color: themewhitecolor,
    ),
    title: "Privacy policy",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.help_outline,
      color: themewhitecolor,
    ),
    title: "Help Center",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.insert_invitation,
      color: themewhitecolor,
    ),
    title: "Invite Friends",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.logout,
      color: themewhitecolor,
    ),
    title: "Logout",
  ),
];

//temporray model

class SubCategoryModel {
  final Icon icon;
  final String title;
  SubCategoryModel({required this.icon, required this.title});
}

List<SubCategoryModel> subCategoryModelList = [
  SubCategoryModel(
    icon: const Icon(
      Icons.person_outline,
      color: themewhitecolor,
    ),
    title: "Sofa",
  ),
  SubCategoryModel(
    icon: const Icon(
      Icons.lock_outline,
      color: themewhitecolor,
    ),
    title: "Table",
  ),
  SubCategoryModel(
    icon: const Icon(
      Icons.help_outline,
      color: themewhitecolor,
    ),
    title: "Chairs",
  ),
  SubCategoryModel(
    icon: const Icon(
      Icons.insert_invitation,
      color: themewhitecolor,
    ),
    title: "Stool",
  ),
  SubCategoryModel(
    icon: const Icon(
      Icons.logout,
      color: themewhitecolor,
    ),
    title: "Cabinet",
  ),
];

class PurposeModel {
  final IconData icon;
  final String title;
  PurposeModel({required this.icon, required this.title});
}

List<PurposeModel> purposeModelList = [
  PurposeModel(
    icon: CupertinoIcons.home,
    // icon: const Icon(
    //   CupertinoIcons.home,
    //   color: themegreytextcolor,
    //                       size: 30,
    // ),
    title: "Buy",
  ),
  PurposeModel(
    icon: Icons.key,
    title: "Rent",
  ),
];

class ServicesModel {
  final String title;
  final String image;
  ServicesModel({
    required this.title,
    required this.image,
  });
}

const Service = [
  "Select Type",
  "Plumber",
  "Carpenter",
  "Electrician",
  "HVAC Technician",
  "Painter",
  "Mason",
  "Roofing Contractor",
  "Locksmith",
  "Plasterer/Drywaller",
  "Landscaper",
  "Flooring Installer",
  "Pest Control Technician",
  "Appliance Repair Technician",
  "Handyman",
  "Window Installer",
  "Tiler",
  "Insulation Installer",
  "Glazier",
  "Septic Tank Service Technician",
  "Fence Installer"
];
// List<ServicesModel> servicesmodel = [
//   ServicesModel(
//     title: "Plumber",
//     image:
//          "assets/images/jpg/Plumber.jpg",),
//   ServicesModel(
//     title: "Carpenter",
//     image:
//        "assets/images/jpg/Carpenter.jpg", ),
//   ServicesModel(
//     title: "Electrician",
//     image:
//         "assets/images/jpg/Electrician.jpg",  ),
//   ServicesModel(
//     title: "HVAC Technician",
//     image:
//        "assets/images/jpg/HVAC_Technician.jpg",),
//   ServicesModel(
//     title: "Painter",
//     image:
//         "assets/images/jpg/Painter.jpg",),
//   ServicesModel(
//     title: "Mason",
//     image:
//         "assets/images/jpg/Mason.jpg", ),
//   ServicesModel(
//     title: "Roofing Contractor",
//     image:
//          "assets/images/jpg/Roofing_Contractor.jpg",),
//   ServicesModel(
//     title: "Locksmith",
//     image:
//         "assets/images/jpg/Locksmith.jpg", ),
//   ServicesModel(
//     title: "Plasterer/Drywaller",
//     image:
//          "assets/images/jpg/Plasterer_Drywaller.jpg",
//          ),
//   ServicesModel(
//     title: "Landscaper",
//     image:
//         "assets/images/jpg/Landscaper.jpg",
//   ),
//   ServicesModel(
//     title: "Flooring Installer",
//     image:
//          "assets/images/jpg/Flooring.jpg",
//   ),
//   ServicesModel(
//     title: "Pest Control Technician",
//     image:
//          "assets/images/jpg/Pest_Control_Technician.jpg",
//   ),
//   ServicesModel(
//     title: "Appliance Repair Technician",
//     image:
//          "assets/images/jpg/Appliance_Repair_Technician.jpg",
//   ),
//   ServicesModel(
//     title: "Handyman",
//     image:
//          "assets/images/jpg/Handyman.jpg",
//   ),
//   ServicesModel(
//     title: "Window Installer",
//     image:
//          "assets/images/jpg/Window_Installer.jpg",
//   ),
//   ServicesModel(
//     title: "Tiler",
//     image:
//          "assets/images/jpg/Tiler.jpg",
//   ),
//   ServicesModel(
//     title: "Insulation Installer",
//     image:
//          "assets/images/jpg/Insulation_Installer.jpg",
//   ),
//   ServicesModel(
//     title: "Glazier",
//     image:
//          "assets/images/jpg/Glazier.jpg",
//   ),
//   ServicesModel(
//     title: "Septic Tank Service Technician",
//     image:
//          "assets/images/jpg/Septic_Tank_Service_Technician.jpg",
//   ),
//   ServicesModel(
//     title: "Fence Installer",
//     image:
//          "assets/images/jpg/Fence_Installer.jpg",
//   ),
// ];
List<ServicesModel> servicesmodel = [
  ServicesModel(
    title: "Interior Designers & Decorators",
    image: "assets/images/jpg/interior-designer.jpg",
  ),
  ServicesModel(
    title: "Kitchen & Bathroom Remodelers",
    image: "assets/images/jpg/kitchen-bathroom.jpg",
  ),
  ServicesModel(
    title: "Hardwood Flooring Dealers",
    image: "assets/images/jpg/hardwood-florring.jpg",
  ),
  ServicesModel(
    title: "Architects & Building Designers",
    image: "assets/images/jpg/architect-buildings.jpg",
  ),
  ServicesModel(
    title: "Home Builders",
    image: "assets/images/jpg/home-builder.jpg",
  ),
  ServicesModel(
    title: "Painter",
    image: "assets/images/jpg/painters.jpg",
  ),
  ServicesModel(
    title: "Design-Build Firms",
    image: "assets/images/jpg/Mason.jpg",
  ),
  ServicesModel(
    title: "Roofing & Gutters",
    image: "assets/images/jpg/roofing-gutters.jpg",
  ),
  ServicesModel(
    title: "Kitchen & Bathroom Designers",
    image: "assets/images/jpg/kitchen-bathroom-p.jpg",
  ),
  ServicesModel(
    title: "Cabinets & Cabinetry",
    image: "assets/images/jpg/cabinets-cabinetry.jpg",
  ),
  ServicesModel(
    title: "Landscaper",
    image: "assets/images/jpg/landscaper-picture.jpg",
  ),
  ServicesModel(
    title: "Landscape Architects & Landscape Designers",
    image: "assets/images/jpg/landscape-architects.jpg",
  ),
  ServicesModel(
    title: "Appliance Repair Technician",
    image: "assets/images/jpg/Pest_Control_Technician.jpg",
  ),
  ServicesModel(
    title: "General Contractors",
    image: "assets/images/jpg/general-contractors.jpg",
  ),
  ServicesModel(
    title: "Tile & Stone",
    image: "assets/images/jpg/black-stones-tiled-floor.jpg",
  ),
  ServicesModel(
    title: "Home Stagers",
    image: "assets/images/jpg/home-stagers.jpg",
  ),
  ServicesModel(
    title: "Swimming Pool Builders",
    image: "assets/images/jpg/swimming-pool.jpg",
  ), //
  ServicesModel(
    title: "Plumbers",
    image: "assets/images/jpg/plumber-image.jpg",
  ),
  ServicesModel(
    title: "Event Planner",
    image: "assets/images/jpg/event-patner.jpg",
  ),
  ServicesModel(
    title: "Digital Solutions",
    image: "assets/images/jpg/digital-solutions.jpg",
  ),
  ServicesModel(
    title: "Travel Partners",
    image: "assets/images/jpg/event-planner.jpg",
  ),
  ServicesModel(
    title: "Solar Solutions",
    image: "assets/images/jpg/solar.jpg",
  ),
  ServicesModel(
    title: "Others",
    image: "",
  ),
];



