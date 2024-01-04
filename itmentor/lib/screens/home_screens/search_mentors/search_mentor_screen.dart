import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itmentor/screens/home_screens/mentor_list/mentors/mentor_profile/mentor_profile_detail.dart';
import 'package:itmentor/utils/constant.dart';

class SearchMentor extends StatefulWidget {
  const SearchMentor({super.key});

  @override
  State<SearchMentor> createState() => _SearchMentorState();
}

class _SearchMentorState extends State<SearchMentor> {
  List<dynamic> mentors = [];
  List<Map<String, dynamic>> expertiseList = [];

  bool isLoading = false;

  Map<String, dynamic> selectedExpertise = {};

  ScrollController _scrollController = ScrollController();

  var currentPage = 1;
  var searchedName = '';

  void _scrollListener() {
    if (!isLoadMore &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      debugPrint(searchedName);
      debugPrint(currentPage.toString());
      loadMoreMentors(searchedName);
    }
  }

  bool isLoadMore = false;
  Future<void> loadMoreMentors(String name) async {
    if (isLoadMore) {
      return;
    }

    currentPage++;

    setState(() {
      isLoadMore = true;
    });

    final uri = Uri.https(
        Constants.uri, '/mentor/search', {'name': name, 'page': '$currentPage'});

    final response = await http.get(uri);
    final data = json.decode(response.body);

    if (data['mentors'] != null) {
      debugPrint("loadmore mentor: ${data['mentors']}");
      setState(() {
        mentors.addAll(data['mentors']);
        isLoadMore = false;
      });
    } else {
      setState(() {
        isLoadMore = false;
      });
    }
  }

  Future<void> fetchMentors(String name) async {
    setState(() {
      isLoading = true;
    });
    final uri = Uri.https(Constants.uri, '/mentor/search', {'name': name});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        mentors = jsonData['mentors'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load mentors');
    }
  }

  Future<void> fetchMentorsWithExpertise(
      String name, String expertiseId) async {
    setState(() {
      isLoading = true;
    });
    final uri = Uri.https(Constants.uri, '/mentor/search',
        {'expertise': expertiseId, 'name': name});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        mentors = jsonData['mentors'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load mentors');
    }
  }

  Future<List<Map<String, dynamic>>> fetchExpertise() async {
    final apiUrl = Uri.https(Constants.uri, '/expertise');

    try {
      final response = await http.get(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);

        setState(() {
          expertiseList =
              jsonResponse.map((item) => item as Map<String, dynamic>).toList();
          print(expertiseList);
        });

        return expertiseList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchMentorsByExpertise(String expertiseId) async {
    setState(() {
      isLoading = true;
    });
    final url =
        Uri.https(Constants.uri, '/mentor/search', {'expertise': expertiseId});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        mentors = jsonData['mentors'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load mentors');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExpertise();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tìm kiếm mentor',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Lĩnh vực',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            expertiseList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: expertiseList.map((expertise) {
                        return ChoiceChip(
                          selected: selectedExpertise == expertise,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedExpertise = expertise;
                                fetchMentorsByExpertise(expertise['_id']);
                              } else {
                                selectedExpertise = {};
                              }
                            });
                          },
                          label: Text(
                            expertise['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedExpertise == expertise
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          backgroundColor: selectedExpertise == expertise
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          selectedColor:
                              Theme.of(context).colorScheme.secondary,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedExpertise == expertise
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                key: Key('searchField'),
                decoration: InputDecoration(
                  labelText: 'Tìm theo tên',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.all(12),
                ),
                onSubmitted: (value) {
                  setState(() {
                    searchedName = value;
                  });
                  selectedExpertise.isNotEmpty
                      ? fetchMentorsWithExpertise(
                          value, selectedExpertise['_id'])
                      : fetchMentors(value);
                },
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: mentors.length,
                      itemBuilder: (context, index) {
                        final mentor = mentors[index];
                        return InkWell(
                          key: Key('MentorData'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) {
                                  return MentorProfileDetail(
                                    id: mentor['_id'],
                                    avatar: mentor['avatar'],
                                  );
                                }),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.black, width: 1),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: mentor['avatar'] != ""
                                    ? CachedNetworkImageProvider(
                                            mentor['avatar'] as String)
                                        as ImageProvider
                                    : Image.asset(
                                            'assets/images/blank_avatar.png')
                                        .image,
                              ),
                              title: Text(
                                mentor['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    mentor['email'],
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Số lượng mentee: ${mentor['number_of_mentees']}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 8),
                                  mentor['expertise'] != null
                                      ? Text(
                                          'Chuyên ngành: ${mentor['expertise']['name']}',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        )
                                      : Text(
                                          'Chưa chọn chuyên ngành',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            isLoadMore
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
