// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_label

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSCreens extends StatefulWidget {
  const HomeSCreens({super.key});

  @override
  State<HomeSCreens> createState() => _HomeSCreensState();
}

class _HomeSCreensState extends State<HomeSCreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Index',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 160.h),
              Image.asset(
                'assets/images/indexscreenimages.png',
                height: 280.h,
                width: 280.w,
              ),
              Text(
                'What do you want to do today?',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Tap + to add your tasks',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Bu yerda isScrollControlled ni qo'shdik
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: 310,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Task',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(width: 20.w),
                                Text(
                                  'Do math homework',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        TextField(
                          style: TextStyle(color: Colors.grey.shade400),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Description",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.timer_outlined,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      CupertinoIcons.tag,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      CupertinoIcons.flag,
                                      color: Colors.white,
                                    )),
                                // IconButton(onPressed: () {}, icon: Icon(Icons.tag_faces)),
                                // IconButton(onPressed: () {}, icon: Icon(Icons.flag)),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: Color(0xFF8687E7),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 25.sp,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF8687E7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        color: Colors.grey.shade800,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.r),
              child: Column(
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.home,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Index',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 70.r),
              child: Column(
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Calendar',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.r),
              child: Column(
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    icon: Icon(
                      Icons.access_time,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Focuse',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.r),
              child: Column(
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.person,
                      size: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
