import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/add_course_success.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:time_scheduler_table/time_scheduler_table.dart';

class AddCoursePricingView extends StatefulWidget {
  const AddCoursePricingView({super.key});
  static const path = '/add_course_pricing';

  @override
  State<AddCoursePricingView> createState() => _AddCoursePricingViewState();
}

class _AddCoursePricingViewState extends State<AddCoursePricingView> {
  String typeDropdown = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Add New course',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0XFF0476AF)),
                        child: Icon(
                          Icons.check,
                          size: 12,
                          color: customTheme['whiteColor'],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      MainText(
                          text: 'General Information',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: customTheme['primaryColor']),
                    ],
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, right: 20),
                      child: Divider(
                        thickness: 2,
                        color: customTheme['primaryColor'],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0XFF0476AF),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: customTheme['primaryColor'],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      MainText(
                          text: 'Pricing',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: customTheme['secondaryTextColor']),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: customTheme['primaryColor'],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                      text: 'Availability',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: customTheme['whiteColor'],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            height: MediaQuery.sizeOf(context).height / 19,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0XFF68AED3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: [timeFormatter],
                                    decoration: InputDecoration(
                                      hintText: 'HH:MM', // Placeholder text
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: customTheme['whiteColor']!
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    keyboardType: TextInputType
                                        .datetime, // Ensures numeric keyboard with ":"
                                    style: TextStyle(
                                      color: customTheme['whiteColor'],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.sizeOf(context).height / 19,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0XFF68AED3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: [timeFormatter],
                                    decoration: InputDecoration(
                                      hintText: 'HH:MM', // Placeholder text
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: customTheme['whiteColor']!
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    keyboardType: TextInputType
                                        .datetime, // Ensures numeric keyboard with ":"
                                    style: TextStyle(
                                      color: customTheme['whiteColor'],
                                    ),
                                    // Optionally: Add input formatter for time formatting (optional)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.sizeOf(context).height / 19,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0XFF68AED3),
                            ),
                            child: Align(
                              child: MainText(
                                text: 'GMT',
                                fontSize: 14,
                                color: customTheme['whiteColor'],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height / 15.5,
                            child: DropdownButtonFormField(
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: customTheme['whiteColor'],
                              ),
                              dropdownColor: customTheme['primaryColor'],
                              decoration: InputDecoration(
                                fillColor: const Color(0XFF68AED3),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(141, 150, 159, 1),
                                        width: 1)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(4, 118, 175, 1))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(241, 4, 4, 1),
                                        width: 1)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(4, 118, 175, 1))),
                                hintText: 'Choose a category',
                                hintStyle: TextStyle(
                                  color: customTheme['whiteColor'],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: "Option 1",
                                  child: MainText(
                                    text: 'Option 1',
                                    color: customTheme['whiteColor'],
                                    fontSize: 16,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Option 2",
                                  child: MainText(
                                    text: 'Option 2',
                                    color: customTheme['whiteColor'],
                                    fontSize: 16,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Option 3",
                                  child: MainText(
                                    text: 'Option 3',
                                    color: customTheme['whiteColor'],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  typeDropdown = value.toString();
                                });
                              },
                              validator: (value) {
                                if (typeDropdown.isEmpty) {
                                  return "Choose a category";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                elevation: 0,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height *
                                          0.7, // Limit bottom sheet height
                                ),
                                backgroundColor: customTheme['whiteColor'],
                                context: context,
                                builder: (BuildContext context) {
                                  return ScheduleList();
                                },
                              );
                            },
                            child: Icon(
                              Iconsax.timer,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              MainText(
                text: 'Fee',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'Enter fee for each month',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Fee Duration',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'Number of Months',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Final Fee',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'Calculated based on fee and duration',
              ),
              const SizedBox(
                height: 44,
              ),
              PrimaryButton(
                text: 'Save and Continue',
                isIconPresent: false,
                fontWeight: FontWeight.w600,
                borderRadius: BorderRadius.circular(8),
                onPressed: () {
                  router.push(
                    AddCourseSuccessView.path,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OutlineButton(
                text: 'Cancel',
                textColor: customTheme['primaryColor'],
                fontWeight: FontWeight.w600,
                borderRadius: BorderRadius.circular(8),
                buttonColor: customTheme['whiteColor'],
                isIconPresent: false,
                fontSize: 16,
                onPressed: () {
                  context.pop();
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final timeFormatter = MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );
}

class ScheduleList extends StatelessWidget {
  ScheduleList({super.key});

  final List<Event> eventList = [
    Event(
      title: "Flutter Project",
      columnIndex: 0, // Monday
      rowIndex: 3, // 08:00
      color: Colors.orange,
    ),
    Event(
      title: "Deep Learning Course",
      columnIndex: 1, // Tuesday
      rowIndex: 6, // 13:00
      color: Colors.pink,
    ),
    Event(
      title: "Violin & Piano Course",
      columnIndex: 4, // Friday
      rowIndex: 8, // 16:00
      color: Colors.green,
    ),
    Event(
      title: "Sport",
      columnIndex: 3, // Thursday
      rowIndex: 1, // 09:00
      color: Colors.deepPurpleAccent,
    ),
    Event(
      title: "Algorithm and Data Structures",
      columnIndex: 2, // Wednesday
      rowIndex: 11, // 19:00
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      height: MediaQuery.sizeOf(context)
          .height, // Set a fixed height for the modal bottom sheet
      child: TimeSchedulerTable(
        cellHeight: 52,
        cellWidth: 64,
        columnLabels: const ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"],
        currentColumnTitleIndex: DateTime.now().weekday - 1,
        rowLabels: const [
          '08:00 - 09:00',
          '09:00 - 10:00',
          '10:00 - 11:00',
          '11:00 - 12:00',
          '12:00 - 13:00',
          '13:00 - 14:00',
          '14:00 - 15:00',
          '15:00 - 16:00',
          '16:00 - 17:00',
          '17:00 - 18:00',
          '18:00 - 19:00',
          '19:00 - 20:00',
          '20:00 - 21:00',
        ],
        eventList: eventList,
        eventAlert: EventAlert(
          addAlertTitle: "Add Event",
          editAlertTitle: "Edit",
          addButtonTitle: "ADD",
          deleteButtonTitle: "DELETE",
          updateButtonTitle: "UPDATE",
          hintText: "Event Name",
          textFieldEmptyValidateMessage: "Cannot be empty!",
          addOnPressed: (event) {
            // Handle event added
          },
          updateOnPressed: (event) {
            // Handle event updated
          },
          deleteOnPressed: (event) {
            // Handle event deleted
          },
        ),
      ),
    );
  }
}
