import 'package:flutter/material.dart';
import 'package:itmentor/providers/user_provider.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/awards/create_awards.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/awards/edit_awards.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/awards/edit_awards_detail.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/educations/edit_education_detail.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/experiences/edit_experiences_detail.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/skills/create_skills.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/educations/create_education.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/educations/edit_educations.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/experiences/create_experiences.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/experiences/edit_experiences.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/skills/edit_skills.dart';
import 'package:itmentor/screens/account_settings_screen/avatar_name/profile_detail/bio/skills/edit_skills_detail.dart';
import 'package:itmentor/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BioScreen extends StatefulWidget {
  final String token;
  final String bioId;
  final List<dynamic> awards;
  final List<dynamic> skills;
  final List<dynamic> educations;
  final List<dynamic> experiences;
  const BioScreen(
      {super.key,
      required this.token,
      required this.bioId,
      required this.awards,
      required this.skills,
      required this.educations,
      required this.experiences});

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  final AuthServices authServices = AuthServices();

  void updateSkillsList(Map<String, String> newSkill) {
    setState(() {
      widget.skills.add(newSkill);
    });
  }

  void addExperience(Map<String, String> newExperience) {
    setState(() {
      widget.experiences.add(newExperience);
    });
  }

  void deleteExperience(String experienceId) {
    setState(() {
      widget.experiences
          .removeWhere((element) => element['_id'] == experienceId);
    });
  }

  void updateExperienceList(Map<String, dynamic> updatedExperience) {
    setState(() {
      final index = widget.experiences
          .indexWhere((exp) => exp['_id'] == updatedExperience['_id']);
      if (index != -1) {
        widget.experiences[index] = updatedExperience;
      }
    });
  }

  void addEducation(Map<String, String> newEducation) {
    setState(() {
      widget.educations.add(newEducation);
    });
  }

  void deleteEducation(String educationId) {
    setState(() {
      widget.educations.removeWhere((element) => element['_id'] == educationId);
    });
  }

  void updateEducationList(Map<String, dynamic> updatedEducation) {
    setState(() {
      final index = widget.educations
          .indexWhere((exp) => exp['_id'] == updatedEducation['_id']);
      if (index != -1) {
        widget.educations[index] = updatedEducation;
      }
    });
  }

  void addAward(Map<String, String> newAward) {
    setState(() {
      widget.awards.add(newAward);
    });
  }

  void updateAwardList(Map<String, dynamic> updatedAward) {
    setState(() {
      final index =
          widget.awards.indexWhere((exp) => exp['_id'] == updatedAward['_id']);
      if (index != -1) {
        widget.awards[index] = updatedAward;
      }
    });
  }

  void deleteAward(String awardId) {
    setState(() {
      widget.awards.removeWhere((element) => element['_id'] == awardId);
    });
  }

  void deleteSkill(String skillId) {
    setState(() {
      widget.skills.removeWhere((element) => element['_id'] == skillId);
    });
  }

  void updateSkillList(Map<String, dynamic> updatedSkill) {
    setState(() {
      final index =
          widget.skills.indexWhere((exp) => exp['_id'] == updatedSkill['_id']);
      if (index != -1) {
        widget.skills[index] = updatedSkill;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Kinh nghiệm làm việc',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                key: Key('AddExperience'),
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) {
                                    return CreateExperiences(
                                      token: widget.token,
                                      bioId: widget.bioId,
                                      onExperienceCreated: addExperience,
                                    );
                                  })));
                                },
                              ),
                              IconButton(
                                key: Key('DeleteExperience'),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) {
                                    return EditExperiences(
                                      experiences: widget.experiences,
                                      token: widget.token,
                                      onExperienceDeleted: deleteExperience,
                                    );
                                  })));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.experiences.length,
              itemBuilder: (context, index) {
                final experience = widget.experiences[index];

                final startDate = DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(experience['start_date']));
                final endDate = DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(experience['end_date']));

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // Add a highlighted border color
                    side: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    key: Key('Experience'),
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 59, 105, 255),
                      child: Icon(
                        Icons.work_outline,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      experience['position'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Text(
                          experience['company'],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Từ $startDate đến $endDate',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return EditExperiencesDetail(
                              experience: experience,
                              token: widget.token,
                              onUpdateExperience: updateExperienceList,
                            );
                          }),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Học vấn',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return CreateEducation(
                              token: widget.token,
                              bioId: widget.bioId,
                              onEducationCreated: addEducation,
                            );
                          })));
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return EditEducations(
                              educations: widget.educations,
                              token: widget.token,
                              onEducationDeleted: deleteEducation,
                            );
                          })));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.educations.length,
              itemBuilder: (context, index) {
                final education = widget.educations[index];

                final startDate = DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(education['start_date']));
                final endDate = DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(education['end_date']));

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // Add a highlighted border color
                    side: BorderSide(color: Colors.green, width: 2.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 59, 255, 137),
                      child: Icon(
                        Icons.school,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      education['place'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Text(
                          education['major'],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Từ $startDate đến $endDate',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return EditEducationDetail(
                              educations: education,
                              token: widget.token,
                              onUpdateEducation: updateEducationList,
                            );
                          }),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Giải thưởng',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return CreateAwards(
                              token: widget.token,
                              bioId: widget.bioId,
                              onAwardCreated: addAward,
                            );
                          })));
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return EditAwards(
                              awards: widget.awards,
                              token: widget.token,
                              onAwardDelete: deleteAward,
                              // token: widget.token,
                              // bioId: widget.bioId,
                            );
                          })));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.awards.length,
              itemBuilder: (context, index) {
                final award = widget.awards[index];
                final awardedDate = DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(award['date']));
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // Add a highlighted border color
                    side: BorderSide(color: Colors.teal, width: 2.0),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
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
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Text(
                          'Description: ${award['description']}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Ngày trao thưởng: $awardedDate',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return EditAwardsDetail(
                              awards: award,
                              token: widget.token,
                              onUpdateAward: updateAwardList,
                            );
                          }),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kĩ năng',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return CreateSkills(
                              token: widget.token,
                              bioId: widget.bioId,
                              onSkillCreated: updateSkillsList,
                            );
                          })));
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return EditSkills(
                              skills: widget.skills,
                              token: widget.token,
                              onSkillDelete: deleteSkill,
                              // token: widget.token,
                              // bioId: widget.bioId,
                            );
                          })));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.skills.length,
              itemBuilder: (context, index) {
                final skill = widget.skills[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // Add a highlighted border color
                    side: BorderSide(color: Colors.amber, width: 2.0),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow,
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      skill['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Mô tả: ${skill['description']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return EditSkillDetail(
                          skills: skill,
                          token: widget.token,
                          onSkillUpdate: updateSkillList,
                        );
                      })));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
