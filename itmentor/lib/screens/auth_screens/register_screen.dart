import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itmentor/screens/auth_screens/login_screen.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:itmentor/utils/constant.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  bool isMale = false;
  bool isFemale = false;
  bool isGenderSelected = false;

  DateTime? selectedDate;
  bool isDateSelected = false;

  bool isMentor = false;
  bool isMentee = false;
  bool isRoleSelected = false;

  bool isAvatarSelected = false;

  final AuthServices authServices = AuthServices();

  File? _image;

  final imagePicker = ImagePicker();

  Future getImageFromGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future getImageFromCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void signUpUser() {
    authServices.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      gender: isMale == true ? true : false,
      phone: _phoneController.text,
      avatar: '',
      dateOfBirth: selectedDate.toString(),
      role: isMentor == true ? 'mentor' : 'mentee',
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isDateSelected = true;
      });
    }
  }

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: const Text('Vui lòng chọn đủ thông tin.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      signUpUser();
    }
    if (isGenderSelected == false ||
        isDateSelected == false ||
        isRoleSelected == false) {
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: Constants.backgroundColor),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 250,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      final emailRegExp =
                          RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Mật khẩu',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      if (value.length < 6) {
                        return 'Mật khẩu cần ít nhất 6 ký tự';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Nhập lại mật khẩu',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập lại mật khẩu';
                      }
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        return 'Mật khẩu không khớp';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Họ tên',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập họ tên';
                      }
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 50),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: const [
                              Text(
                                'Giới tính:',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Radio(
                        value: true,
                        groupValue: isMale,
                        onChanged: (bool? value) {
                          setState(() {
                            isGenderSelected = true;
                            isMale = value!;
                            isFemale = !value;
                          });
                        },
                      ),
                      const Text('Nam'),
                      Radio(
                        value: true,
                        groupValue: isFemale,
                        onChanged: (bool? value) {
                          setState(() {
                            isGenderSelected = true;
                            isFemale = value!;
                            isMale = !value;
                          });
                        },
                      ),
                      const Text('Nữ'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1369B2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text('Chọn ngày sinh'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      selectedDate != null
                          ? "${selectedDate?.toLocal()}".split(' ')[0]
                          : 'Chưa chọn ngày',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 50, bottom: 10, right: 50),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Số điện thoại',
                      labelStyle: const TextStyle(
                        color: Color(0xFF1BB55C),
                      ),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      if (value.length < 9) {
                        return 'Số điện thoại phải là 10 chữ số';
                      }
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 50),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: const [
                              Text(
                                'Chọn vai trò:',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Radio(
                        value: true,
                        groupValue: isMentor,
                        onChanged: (bool? value) {
                          setState(() {
                            isRoleSelected = true;
                            isMentor = value!;
                            isMentee = !value;
                          });
                        },
                      ),
                      const Text('Mentor'),
                      Radio(
                        value: true,
                        groupValue: isMentee,
                        onChanged: (bool? value) {
                          setState(() {
                            isRoleSelected = true;
                            isMentee = value!;
                            isMentor = !value;
                          });
                        },
                      ),
                      const Text('Mentee'),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image == null
                        ? Text('Chưa chọn ảnh')
                        : Image.file(_image!),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Chọn ảnh từ:'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Thư viện ảnh'),
                                  onPressed: () {
                                    getImageFromGallery();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Mở camera'),
                                  onPressed: () {
                                    getImageFromCamera();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Chọn Avatar'),
                    ),
                  ],
                ),
                isAvatarSelected
                    ? Image.file(
                        _image!,
                        cacheHeight: 66,
                        cacheWidth: 50,
                      )
                    : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                    ),
                    const Text(
                      'Tôi đồng ý với các điều \n khoản dịch vụ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: isChecked ? submitForm : (() {}),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isChecked ? const Color(0xFF1369B2) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'ĐĂNG KÝ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Đã có tài khoản?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const LoginScreen())));
                      },
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Color(0xFF024075),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '© IT Mentor',
                  style: TextStyle(
                    color: Color(0xFF18BEBC),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
  }
}
