import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/awards/edit_awards_detail.dart';
import 'package:itmentor/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/utils/utils.dart';

class EditAwards extends StatefulWidget {
  final List<dynamic> awards;
  final String token;
  final Function(String) onAwardDelete;
  const EditAwards(
      {super.key,
      required this.awards,
      required this.token,
      required this.onAwardDelete});

  @override
  State<EditAwards> createState() => _EditAwardsState();
}

class _EditAwardsState extends State<EditAwards> {
  void deleteAward(String awardId) async {
    final url = Uri.https(Constants.uri, '/award/$awardId');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );

    if (response.statusCode == 200) {
      print('Awards data deleted successfully.');
      widget.onAwardDelete(awardId);
      showSnackBar(context, 'Đã xoá giải thưởng thành công');
      Navigator.of(context).pop();
    } else {
      print('Failed to delete awards data: ${response.statusCode}');
    }
  }

  Future<void> _confirmDeleteAward(String awardId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xoá'),
          content: const Text('Bạn có muốn xoá học vấn này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteAward(awardId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 63, 143, 125),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Xoá giải thưởng',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.awards.length,
              itemBuilder: (context, index) {
                final award = widget.awards[index];
                final date = DateFormat('dd-MM-yyyy')
                    .format(DateTime.parse(award['date']));
                print('award: $award');
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.cyanAccent,
                      child: Icon(
                        Icons.military_tech,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      award['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${award['description']}\nNgày nhận: $date',
                    ),
                    onTap: () {},
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: ((context) {
                        //   return EditAwardsDetail(
                        //     awards: award,
                        //     token: widget.token,
                        //   );
                        // })));
                        _confirmDeleteAward(award['_id']);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
