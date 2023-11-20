import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itmentor/models/user.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/appointment_screen/appointment_detail_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:itmentor/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentScreen extends StatefulWidget {
  final String token;
  const AppointmentScreen({super.key, required this.token});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  Map<String, dynamic> userData = {};

  Future<void> fetchProfile() async {
    final url = Uri.https(Constants.uri, '/user/profile');

    try {
      final response = await http.get(
        url,
        headers: {
          'Connection': 'keep-alive',
          'Authorization': 'Bearer ${widget.token}'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          userData = data;
          print('user appointment role: ${userData['role']}');
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<Map<String, dynamic>> canceledAppointments = [];
  int canceledCurrentPage = 1;
  int canceledTotalPages = 1;
  bool canceledIsLoading = false;
  bool canceledIsFirstLoad = true;

  Future<void> fetchCanceledAppointments() async {
    if (canceledIsLoading) {
      return;
    }

    setState(() {
      canceledIsLoading = true;
    });

    final apiUrl = Uri.https(Constants.uri, '/appointment/canceled',
        {'page': '$canceledCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          canceledAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          canceledIsLoading = false;
          canceledIsFirstLoad = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          canceledIsLoading = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        canceledIsLoading = false;
      });
    }
  }

  bool loadMoreCanceled = false;
  Future<void> loadMoreCanceledAppointments() async {
    if (canceledIsLoading) {
      return;
    }

    setState(() {
      loadMoreCanceled = true;
    });

    canceledCurrentPage++;

    final apiUrl = Uri.https(Constants.uri, '/appointment/canceled',
        {'page': '$canceledCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          canceledAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          loadMoreCanceled = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          loadMoreCanceled = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        loadMoreCanceled = false;
      });
    }
  }

  // pending appointments
  List<Map<String, dynamic>> pendingAppointments = [];
  int pendingCurrentPage = 1;
  int pendingTotalPages = 1;
  bool pendingIsLoading = false;
  bool pendingIsFirstLoad = true;

  Future<void> fetchPendingAppointments() async {
    if (pendingIsLoading) {
      return;
    }

    setState(() {
      pendingIsLoading = true;
    });

    final apiUrl = Uri.https(
        Constants.uri, '/appointment/pending', {'page': '$pendingCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          pendingAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          pendingIsLoading = false;
          pendingIsFirstLoad = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          pendingIsLoading = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        pendingIsLoading = false;
      });
    }
  }

  bool loadMorePending = false;
  Future<void> loadMorePendingAppointments() async {
    if (pendingIsLoading) {
      return;
    }

    setState(() {
      loadMorePending = true;
    });

    pendingCurrentPage++;

    final apiUrl = Uri.https(
        Constants.uri, '/appointment/pending', {'page': '$pendingCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          pendingAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          loadMorePending = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          loadMorePending = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        loadMorePending = false;
      });
    }
  }

  // confirmed appointments
  List<Map<String, dynamic>> confirmedAppointments = [];
  int confirmedCurrentPage = 1;
  int confirmedTotalPages = 1;
  bool confirmedIsLoading = false;
  bool confirmedIsFirstLoad = true;

  Future<void> fetchConfirmedAppointments() async {
    if (confirmedIsLoading) {
      return;
    }

    setState(() {
      confirmedIsLoading = true;
    });

    final apiUrl = Uri.https(Constants.uri, '/appointment/confirmed',
        {'page': '$confirmedCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          confirmedAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          confirmedIsLoading = false;
          confirmedIsFirstLoad = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          confirmedIsLoading = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        confirmedIsLoading = false;
      });
    }
  }

  bool loadMoreConfirmed = false;
  Future<void> loadMoreConfirmedAppointments() async {
    if (confirmedIsLoading) {
      return;
    }

    setState(() {
      loadMoreConfirmed = true;
    });

    confirmedCurrentPage++;

    final apiUrl = Uri.https(Constants.uri, '/appointment/confirmed',
        {'page': '$confirmedCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          confirmedAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          loadMoreConfirmed = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          loadMoreConfirmed = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        loadMoreConfirmed = false;
      });
    }
  }

  // finished appointments
  List<Map<String, dynamic>> finishedAppointments = [];
  int finishedCurrentPage = 1;
  int finishedTotalPages = 1;
  bool finishedIsLoading = false;
  bool finishedIsFirstLoad = true;

  Future<void> fetchFinishedAppointments() async {
    if (finishedIsLoading) {
      return;
    }

    setState(() {
      finishedIsLoading = true;
    });

    final apiUrl = Uri.https(Constants.uri, '/appointment/finished',
        {'page': '$finishedCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          finishedAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          finishedIsLoading = false;
          finishedIsFirstLoad = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          finishedIsLoading = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        finishedIsLoading = false;
      });
    }
  }

  bool loadMoreFinished = false;
  Future<void> loadMoreFinishedAppointments() async {
    if (finishedIsLoading) {
      return;
    }

    setState(() {
      loadMoreFinished = true;
    });

    finishedCurrentPage++;

    final apiUrl = Uri.https(Constants.uri, '/appointment/finished',
        {'page': '$finishedCurrentPage'});

    try {
      final response = await http.get(apiUrl, headers: {
        "Connection": "keep-alive",
        "Authorization": "Bearer ${widget.token}"
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          finishedAppointments
              .addAll(List<Map<String, dynamic>>.from(data["appointments"]));
          loadMoreFinished = false;
        });
      } else {
        print("Error: ${response.statusCode}");
        setState(() {
          loadMoreFinished = false;
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        loadMoreFinished = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // getAccessToken();
    // fetchData();
    fetchProfile();

    fetchPendingAppointments();
    fetchConfirmedAppointments();
    fetchFinishedAppointments();
    fetchCanceledAppointments();

    // _scrollController.addListener(_scrollListener);
  }

  Future<void> cancelAppointment(
      String appointmentId, dynamic appointment) async {
    final apiUrl =
        Uri.https(Constants.uri, '/appointment/$appointmentId/cancel');
    final headers = {
      'Content-Length': '0',
      'Connection': 'keep-alive',
      'Authorization': 'Bearer ${widget.token}',
    };

    final response = await http.patch(apiUrl, headers: headers);

    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        pendingAppointments
            .removeWhere((element) => element['_id'] == appointmentId);
        canceledAppointments.add(appointment);
      });
      showSnackBar(context, 'Đã huỷ lịch hẹn thành công');
    } else {
      showSnackBar(context, 'Lỗi. Không thể huỷ lịch hẹn');
    }
  }

  Future<void> confirmAppointment(
      String appointmentId, dynamic appointment) async {
    final apiUrl = Uri.https('pbl6-production.up.railway.app',
        '/appointment/$appointmentId/confirm');

    final headers = {
      'Connection': 'keep-alive',
      'Authorization': 'Bearer ${widget.token}',
    };

    try {
      final response = await http.patch(apiUrl, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Appointment confirmed successfully');
        setState(() {
          pendingAppointments
              .removeWhere((element) => element['_id'] == appointmentId);
          confirmedAppointments.add(appointment);
        });
        showSnackBar(context, 'Xác nhận lịch hẹn thành công');
      } else {
        // Handle error
        print('Failed to confirm appointment: ${response.statusCode}');
        showSnackBar(context, 'Xác nhận lịch hẹn thất bại');
      }
    } catch (e) {
      // Handle exception
      print('Error confirming appointment: $e');
      showSnackBar(context, 'Xác nhận lịch hẹn thất bại');
    }
  }

  Future<void> finishAppointment(
      String appointmentId, dynamic appointment) async {
    final apiUrl = Uri.https(
        'pbl6-production.up.railway.app', '/appointment/$appointmentId/finish');
    final headers = {
      'Connection': 'keep-alive',
      'Authorization': 'Bearer ${widget.token}',
    };

    try {
      final response = await http.patch(apiUrl, headers: headers);

      if (response.statusCode == 200) {
        print('Appointment finished successfully');
        setState(() {
          confirmedAppointments
              .removeWhere((element) => element['_id'] == appointmentId);
          finishedAppointments.add(appointment);
        });
        showSnackBar(context, 'Đã hoàn thành cuộc hẹn');
      } else {
        // Handle error
        print('Thất bại: ${response.statusCode}');
        showSnackBar(context, 'Lỗi. Vui lòng thử lại sau.');
      }
    } catch (e) {
      // Handle exception
      print('Error finishing appointment: $e');
      showSnackBar(context, 'Lỗi. Vui lòng thử lại sau.');
    }
  }

  Widget buildAppointmentsTab(List<dynamic> appointmentLists, User user) {
    if (appointmentLists.isEmpty) {
      return const Center(child: Text('Danh sách trống'));
    }

    debugPrint("pending list: ${appointmentLists.length.toString()}");

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: canceledIsFirstLoad
                ? Center(child: CircularProgressIndicator())
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!loadMorePending &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        loadMorePendingAppointments();
                        return true;
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: appointmentLists.length,
                      itemBuilder: (context, index) {
                        final appointment = appointmentLists[index];
                        final mentorName = appointment['mentor']['name'];
                        final mentorAvatar = appointment['mentor']['avatar'];
                        final mentorGender = appointment['mentor']['gender'];

                        final menteeName = appointment['mentee']['name'];
                        final menteeAvatar = appointment['mentee']['avatar'];
                        final menteeGender = appointment['mentee']['gender'];

                        final startAt =
                            appointment['schedule']?['start_at'] != null
                                ? DateTime.parse(
                                    appointment['schedule']['start_at'])
                                : DateTime.now();

                        final endAt = appointment['schedule']?['end_at'] != null
                            ? DateTime.parse(appointment['schedule']['end_at'])
                            : DateTime.now();

                        final duration = endAt.difference(startAt);
                        final minutes = duration.inMinutes;

                        final status = appointment['status'];
                        final appointmentId = appointment['_id'];

                        final mentorExpertiseName =
                            appointment['mentor']['expertise']['name'];

                        print(appointmentId);

                        String statusText = 'Chờ xác nhận';

                        String appointmentTime =
                            '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ' +
                                '${DateFormat('dd-MM-yyyy').format(startAt)}';

                        return Slidable(
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              userData['role'] == 'mentor'
                                  ? SlidableAction(
                                      icon: Icons.check,
                                      onPressed: ((context) {
                                        confirmAppointment(
                                            appointmentId, appointment);
                                        // setState(() {
                                        //   appointments.removeWhere(
                                        //       (element) => element['_id'] == appointmentId);
                                        //   appointmentLists.removeWhere(
                                        //       (element) => element['_id'] == appointmentId);
                                        // });
                                      }),
                                      label: 'Xác nhận',
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    )
                                  : SizedBox(),
                              SlidableAction(
                                icon: Icons.delete,
                                onPressed: (context) {
                                  // setState(() {
                                  //   appointments.removeWhere(
                                  //       (element) => element['_id'] == appointmentId);
                                  //   appointmentLists.removeWhere(
                                  //       (element) => element['_id'] == appointmentId);
                                  // });
                                  cancelAppointment(appointmentId, appointment);

                                  print('deleted');
                                },
                                label: 'Huỷ',
                                backgroundColor:
                                    Color.fromARGB(255, 231, 33, 23),
                                foregroundColor: Colors.white,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return AppointmentDetailScreen(
                                      accessToken: widget.token,
                                      scheduleId: appointmentId,
                                      date: appointmentTime,
                                      minutes: minutes,
                                      position: mentorExpertiseName,
                                    );
                                  }),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Lịch hẹn với',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .blueAccent, // Adjust color as needed
                                          ),
                                        ),
                                        Text(
                                          statusText,
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          userData['role'] == 'mentor'
                                              ? menteeAvatar != ''
                                                  ? menteeAvatar
                                                  : 'assets/images/blank_avatar.png'
                                              : mentorAvatar != ''
                                                  ? mentorAvatar
                                                  : 'assets/images/blank_avatar.png',
                                        ),
                                        child: const InkWell(
                                          customBorder: CircleBorder(),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(16),
                                      tileColor: Colors.white,
                                      title: Text(
                                        userData['role'] == 'mentee'
                                            ? mentorName
                                            : menteeName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          userData['role'] == 'mentee'
                                              ? Text(
                                                  'Lĩnh vực: $mentorExpertiseName')
                                              : Text('Mentee'),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.calendar_month_outlined),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                            '${DateFormat('dd-MM-yyyy').format(startAt)}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.timelapse_rounded),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('$minutes phút')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          if (loadMorePending)
            Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget buildConfirmedAppointmentsTab(
      List<dynamic> appointmentLists, User user) {
    if (appointmentLists.isEmpty) {
      return const Center(child: Text('Danh sách trống'));
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: pendingIsFirstLoad
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!loadMorePending &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        loadMoreConfirmedAppointments();
                        return true;
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: appointmentLists.length,
                      itemBuilder: (context, index) {
                        final appointment = appointmentLists[index];
                        final mentorName = appointment['mentor']['name'];
                        final mentorAvatar = appointment['mentor']['avatar'];
                        final mentorGender = appointment['mentor']['gender'];

                        final menteeName = appointment['mentee']['name'];
                        final menteeAvatar = appointment['mentee']['avatar'];
                        final menteeGender = appointment['mentee']['gender'];

                        final startAt =
                            appointment['schedule']?['start_at'] != null
                                ? DateTime.parse(
                                    appointment['schedule']['start_at'])
                                : DateTime.now();

                        final endAt = appointment['schedule']?['end_at'] != null
                            ? DateTime.parse(appointment['schedule']['end_at'])
                            : DateTime.now();

                        final duration = endAt.difference(startAt);
                        final minutes = duration.inMinutes;

                        final status = appointment['status'];
                        final appointmentId = appointment['_id'];

                        final mentorExpertiseName =
                            appointment['mentor']['expertise']['name'];

                        print(appointmentId);

                        String statusText = 'Đã xác nhận';

                        String appointmentTime =
                            '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ' +
                                '${DateFormat('dd-MM-yyyy').format(startAt)}';

                        return Slidable(
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              userData['role'] == 'mentor'
                                  ? SlidableAction(
                                      icon: Icons.check,
                                      onPressed: ((context) {
                                        finishAppointment(
                                            appointmentId, appointment);
                                        // setState(() {
                                        //   appointments.removeWhere(
                                        //       (element) => element['_id'] == appointmentId);
                                        //   appointmentLists.removeWhere(
                                        //       (element) => element['_id'] == appointmentId);
                                        // });
                                      }),
                                      label: 'Hoàn thành',
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return AppointmentDetailScreen(
                                      accessToken: widget.token,
                                      scheduleId: appointmentId,
                                      date: appointmentTime,
                                      minutes: minutes,
                                      position: mentorExpertiseName,
                                    );
                                  }),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Lịch hẹn với',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .blueAccent, // Adjust color as needed
                                          ),
                                        ),
                                        Text(statusText,
                                            style: const TextStyle(
                                              color: Colors.green,
                                            )),
                                      ],
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: userData['role'] ==
                                                'mentor'
                                            ? menteeAvatar != ''
                                                ? NetworkImage(menteeAvatar)
                                                : menteeGender == true
                                                    ? Image.asset(
                                                            'assets/images/male_avatar.jpg')
                                                        .image
                                                    : Image.asset(
                                                            'assets/images/female_avatar.png')
                                                        .image
                                            : mentorAvatar != ''
                                                ? NetworkImage(mentorAvatar)
                                                : mentorGender == true
                                                    ? Image.asset(
                                                            'assets/images/male_avatar.jpg')
                                                        .image
                                                    : Image.asset(
                                                            'assets/images/female_avatar.png')
                                                        .image,
                                        child: const InkWell(
                                          customBorder: CircleBorder(),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(16),
                                      tileColor: Colors.white,
                                      title: Text(
                                        userData['role'] == 'mentee'
                                            ? mentorName
                                            : menteeName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          userData['role'] == 'mentee'
                                              ? Text(
                                                  'Lĩnh vực: $mentorExpertiseName')
                                              : Text('Mentee'),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.calendar_month_outlined),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                            '${DateFormat('dd-MM-yyyy').format(startAt)}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.timelapse_rounded),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('$minutes phút')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          if (loadMoreConfirmed)
            Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget buildFinishedAppointmentsTab(
      List<dynamic> appointmentLists, User user) {
    if (appointmentLists.isEmpty) {
      return const Center(child: Text('Danh sách trống'));
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: finishedIsFirstLoad
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!loadMorePending &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        loadMoreFinishedAppointments();
                        return true;
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: appointmentLists.length,
                      itemBuilder: (context, index) {
                        final appointment = appointmentLists[index];
                        final mentorName = appointment['mentor']['name'];
                        final mentorAvatar = appointment['mentor']['avatar'];
                        final mentorGender = appointment['mentor']['gender'];

                        final menteeName = appointment['mentee']['name'];
                        final menteeAvatar = appointment['mentee']['avatar'];
                        final menteeGender = appointment['mentee']['gender'];

                        final startAt =
                            appointment['schedule']?['start_at'] != null
                                ? DateTime.parse(
                                    appointment['schedule']['start_at'])
                                : DateTime.now();

                        final endAt = appointment['schedule']?['end_at'] != null
                            ? DateTime.parse(appointment['schedule']['end_at'])
                            : DateTime.now();

                        final duration = endAt.difference(startAt);
                        final minutes = duration.inMinutes;

                        final status = appointment['status'];
                        final appointmentId = appointment['_id'];

                        final mentorExpertiseName =
                            appointment['mentor']['expertise']['name'];

                        print(appointmentId);

                        String statusText = 'Đã hoàn thành';

                        String appointmentTime =
                            '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ' +
                                '${DateFormat('dd-MM-yyyy').format(startAt)}';

                        return Slidable(
                          key: UniqueKey(),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return AppointmentDetailScreen(
                                      accessToken: widget.token,
                                      scheduleId: appointmentId,
                                      date: appointmentTime,
                                      minutes: minutes,
                                      position: mentorExpertiseName,
                                    );
                                  }),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Lịch hẹn với',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .blueAccent, // Adjust color as needed
                                          ),
                                        ),
                                        Text(
                                          statusText,
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: userData['role'] ==
                                                'mentor'
                                            ? menteeAvatar != ''
                                                ? NetworkImage(menteeAvatar)
                                                : menteeGender == true
                                                    ? Image.asset(
                                                            'assets/images/male_avatar.jpg')
                                                        .image
                                                    : Image.asset(
                                                            'assets/images/female_avatar.png')
                                                        .image
                                            : mentorAvatar != ''
                                                ? NetworkImage(mentorAvatar)
                                                : mentorGender == true
                                                    ? Image.asset(
                                                            'assets/images/male_avatar.jpg')
                                                        .image
                                                    : Image.asset(
                                                            'assets/images/female_avatar.png')
                                                        .image,
                                        child: const InkWell(
                                          customBorder: CircleBorder(),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(16),
                                      tileColor: Colors.white,
                                      title: Text(
                                        userData['role'] == 'mentee'
                                            ? mentorName
                                            : menteeName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          userData['role'] == 'mentee'
                                              ? Text(
                                                  'Lĩnh vực: $mentorExpertiseName')
                                              : Text('Mentee'),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.calendar_month_outlined),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                            '${DateFormat('dd-MM-yyyy').format(startAt)}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.timelapse_rounded),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('$minutes phút')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          if (loadMoreFinished)
            Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget buildCanceledAppointmentsTab(
      List<dynamic> appointmentLists, User user) {
    if (appointmentLists.isEmpty) {
      return const Center(child: Text('Danh sách trống'));
    }

    print(appointmentLists.length);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: canceledIsFirstLoad
                ? Center(child: CircularProgressIndicator())
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!loadMoreCanceled &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        loadMoreCanceledAppointments();
                        return true;
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: appointmentLists.length,
                      itemBuilder: (context, index) {
                        final appointment = appointmentLists[index];
                        final mentorName = appointment['mentor']['name'];
                        final mentorAvatar = appointment['mentor']['avatar'];
                        final mentorGender = appointment['mentor']['gender'];

                        final menteeName = appointment['mentee']['name'];
                        final menteeAvatar = appointment['mentee']['avatar'];
                        final menteeGender = appointment['mentee']['gender'];

                        final startAt =
                            appointment['schedule']?['start_at'] != null
                                ? DateTime.parse(
                                    appointment['schedule']['start_at'])
                                : DateTime.now();

                        final endAt = appointment['schedule']?['end_at'] != null
                            ? DateTime.parse(appointment['schedule']['end_at'])
                            : DateTime.now();

                        final duration = endAt.difference(startAt);
                        final minutes = duration.inMinutes;

                        final status = appointment['status'];
                        final appointmentId = appointment['_id'];

                        final mentorExpertiseName =
                            appointment['mentor']['expertise']['name'];

                        String statusText = 'Đã huỷ';

                        String appointmentTime =
                            '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ' +
                                '${DateFormat('dd-MM-yyyy').format(startAt)}';

                        return Slidable(
                          key: UniqueKey(),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return AppointmentDetailScreen(
                                      accessToken: widget.token,
                                      scheduleId: appointmentId,
                                      date: appointmentTime,
                                      minutes: minutes,
                                      position: mentorExpertiseName,
                                    );
                                  }),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Lịch hẹn với',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .blueAccent, // Adjust color as needed
                                          ),
                                        ),
                                        Text(
                                          statusText,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: userData['role'] ==
                                                'mentor'
                                            ? menteeAvatar != ''
                                                ? NetworkImage(menteeAvatar)
                                                : menteeGender == true
                                                    ? Image.asset(
                                                            'assets/images/male_avatar.jpg')
                                                        .image
                                                    : Image.asset(
                                                            'assets/images/female_avatar.png')
                                                        .image
                                            : mentorAvatar != ''
                                                ? NetworkImage(mentorAvatar)
                                                : mentorGender == true
                                                    ? Image.asset(
                                                            'assets/images/male_avatar.jpg')
                                                        .image
                                                    : Image.asset(
                                                            'assets/images/female_avatar.png')
                                                        .image,
                                        child: const InkWell(
                                          customBorder: CircleBorder(),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(16),
                                      tileColor: Colors.white,
                                      title: Text(
                                        userData['role'] == 'mentee'
                                            ? mentorName
                                            : menteeName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          userData['role'] == 'mentee'
                                              ? Text(
                                                  'Lĩnh vực: $mentorExpertiseName')
                                              : Text('Mentee'),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.calendar_month_outlined),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${DateFormat('HH:mm').format(startAt)} - ${DateFormat('HH:mm').format(endAt)}, ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                            '${DateFormat('dd-MM-yyyy').format(startAt)}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Icon(Icons.timelapse_rounded),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('$minutes phút')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          if (loadMoreCanceled)
            Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
        ],
      ),
    );
  }

  List<dynamic> emptyList = [];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 94, 157, 144),
          elevation: 0,
          title: const Text('Lịch hẹn'),
          bottom: const TabBar(
            isScrollable: true, // Set isScrollable to true
            tabs: [
              Tab(
                text: 'Chờ xác nhận',
              ),
              Tab(
                text: 'Đã xác nhận',
              ),
              Tab(
                text: 'Đã hoàn thành',
              ),
              Tab(
                text: 'Đã huỷ',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // isLoading
            //     ? const Center(child: CircularProgressIndicator())
            //     : buildCanceledAppointmentsTab(canceledAppointments, user),
            // isLoading
            //     ? const Center(child: CircularProgressIndicator())
            //     : buildCanceledAppointmentsTab(canceledAppointments, user),
            // isLoading
            //     ? const Center(child: CircularProgressIndicator())
            //     : buildCanceledAppointmentsTab(canceledAppointments, user),
            pendingIsLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : buildAppointmentsTab(pendingAppointments, user),
            confirmedIsLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : buildConfirmedAppointmentsTab(confirmedAppointments, user),
            finishedIsLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : buildFinishedAppointmentsTab(finishedAppointments, user),
            canceledIsLoading
                ? const Center(child: CircularProgressIndicator())
                : buildCanceledAppointmentsTab(canceledAppointments, user),
          ],
        ),
      ),
    );
  }
}
