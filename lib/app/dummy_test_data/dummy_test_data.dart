import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';
import 'package:dr_purple/features/home/presentation/blocs/book_appointment_bloc/book_appointment_bloc.dart';
import 'package:dr_purple/features/home/presentation/screens/widgets/clinic_visit_component.dart';
import 'package:dr_purple/features/home/presentation/screens/widgets/confirm_appointment_component.dart';
import 'package:dr_purple/features/home/presentation/screens/widgets/appointment_time_component.dart';
import 'package:flutter/material.dart';

List<NotificationData> notificationDataList() {
  List<NotificationData> list = [];
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title: 'an appointment has been canceled',
      time: '3m ago',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title: 'an appointment has been canceled',
      time: '3m ago',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title: 'Vitamins are essential to human health.',
      time: 'Today at 2.20 AM',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title:
          'Hey Sedra, This email confirms your Service Name appointment on Appointment Date Time Client',
      time: 'Today at 11.20 AM',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title:
          'Hey Sedra, This email confirms your Service Name appointment on Appointment Date Time Client',
      time: '3m ago',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title: 'an appointment has been canceled',
      time: '3m ago',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title: 'an appointment has been canceled',
      time: '3m ago',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title: 'Vitamins are essential to human health.',
      time: 'Today at 2.20 AM',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title:
          'Hey Sedra, This email confirms your Service Name appointment on Appointment Date Time Client',
      time: 'Today at 11.20 AM',
    ),
  );
  list.add(
    NotificationData(
      image: Image.asset(ImageAssets.doctorImage, fit: BoxFit.fill),
      title:
          'Hey Sedra, This email confirms your Service Name appointment on Appointment Date Time Client',
      time: '3m ago',
    ),
  );
  return list;
}

class NotificationData {
  Image image;
  String title;
  String time;

  NotificationData(
      {required this.image, required this.title, required this.time});
}

/// appointments

List<AppointmentData> appointmentDataList() {
  List<AppointmentData> list = [];
  list.add(
    AppointmentData(
      date: '10',
      month: 'February',
      doctor: 'Dr. Sedra Sedra',
      department: 'Cosmetologist',
      patient: 'Sedra Sedra',
      service: 'Filler',
    ),
  );
  list.add(
    AppointmentData(
      date: '12',
      month: 'February',
      doctor: 'Dr. Sedra Sedra',
      department: 'Cosmetologist',
      patient: 'Sedra Sedra ',
      service: 'Liposuction',
    ),
  );
  list.add(
    AppointmentData(
      date: '10',
      month: 'January',
      doctor: 'Dr. Sedra Sedra',
      department: 'Cosmetologist',
      patient: 'Sedra Sedra ',
      service: 'Filler',
    ),
  );
  list.add(
    AppointmentData(
      date: '12',
      month: 'January',
      doctor: 'Dr. Sedra Sedra',
      department: 'Cosmetologist',
      patient: 'Sedra Sedra ',
      service: 'Nose reshaping',
    ),
  );
  list.add(
    AppointmentData(
      date: '10',
      month: 'January',
      doctor: 'Dr. Sedra Sedra',
      department: 'Cosmetologist',
      patient: 'Sedra Sedra ',
      service: 'Facelift',
    ),
  );
  return list;
}

class AppointmentData {
  String service;
  String date;
  String month;
  String doctor;
  String patient;
  String department;

  AppointmentData({
    required this.service,
    required this.date,
    required this.month,
    required this.doctor,
    required this.patient,
    required this.department,
  });
}

/// departments
List<DepartmentData> departmentsDataList() {
  List<DepartmentData> list = [];
  list.add(DepartmentData(
    image: ImageAssets.departmentOne,
    title: 'Face Care',
    subtitle: '647 Doctor',
  ));
  list.add(DepartmentData(
    image: ImageAssets.departmentTwo,
    title: 'Body Care',
    subtitle: '324 Doctor',
  ));
  list.add(DepartmentData(
    image: ImageAssets.departmentThree,
    title: 'General Care',
    subtitle: '647 Doctor',
  ));
  return list;
}

class DepartmentData {
  final String image;
  final String title;
  final String subtitle;
  final String? price;

  DepartmentData({
    required this.image,
    required this.title,
    required this.subtitle,
    this.price,
  });
}

/// create appointment
List<BookAppointmentData> bookAppointmentDataList(
  List<ServiceModel> services,
  BookAppointmentBloc bookAppointmentBloc,
) {
  List<BookAppointmentData> list = [];
  list.add(BookAppointmentData(
    id: '1',
    title: AppStrings.selectService,
    widget: ClinicVisitComponent(
      services: services,
      bookAppointmentBloc: bookAppointmentBloc,
    ),
    progress: 0.33,
  ));
  list.add(BookAppointmentData(
    id: '2',
    title: AppStrings.appointmentTime,
    widget: AppointmentTimeComponent(
      bookAppointmentBloc: bookAppointmentBloc,
    ),
    progress: 0.66,
  ));
  list.add(BookAppointmentData(
    id: '3',
    title: AppStrings.confirmAppointment,
    widget: ConfirmAppointmentComponent(
      bookAppointmentBloc: bookAppointmentBloc,
      services: services,
    ),
    progress: 1.0,
  ));
  return list;
}

class BookAppointmentData {
  final String id;
  final String title;
  final Widget widget;
  final double progress;

  BookAppointmentData({
    required this.id,
    required this.title,
    required this.widget,
    required this.progress,
  });
}

/// doctors
List<DoctorData> doctorListDataList() {
  List<DoctorData> list = [];
  list.add(DoctorData(
    title: 'Dr. Sedra Sedra',
    subtitle: 'Cosmetologist',
    rating: '4.8',
    fees: 'SP 10000',
    image: ImageAssets.doctorImage,
  ));
  list.add(DoctorData(
    title: 'Dr. Sedra Sedra',
    subtitle: 'Cosmetologist',
    rating: '4.8',
    fees: 'SP 10000',
    image: ImageAssets.doctorImage,
  ));
  list.add(DoctorData(
    title: 'Dr. Sedra Sedra',
    subtitle: 'Cosmetologist',
    rating: '4.8',
    fees: 'SP 10000',
    image: ImageAssets.doctorImage,
  ));
  list.add(DoctorData(
    title: 'Dr. Sedra Sedra',
    subtitle: 'Cosmetologist',
    rating: '4.8',
    fees: 'SP 10000',
    image: ImageAssets.doctorImage,
  ));
  return list;
}

class DoctorData {
  final String title;
  final String subtitle;
  final String image;
  final String rating;
  final String fees;

  DoctorData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.fees,
  });
}

///schedule
List<String?> mlScheduleTimeList() {
  List<String?> list = [];
  list.add('8:00 AM - 9:00 AM');
  list.add('9:00 AM - 10:00 AM');
  list.add('10:00 AM - 11:00 AM');
  list.add('11:00 AM - 12:00 AM');
  list.add('1:00 AM - 2:00 AM');
  list.add('2:00 AM - 3:00 AM');
  list.add('3:00 AM - 4:00 AM');
  list.add('4:00 AM - 5:00 AM');
  return list;
}
