import 'package:flutter/material.dart';

void main() {
  final userInfo = UserInfo(
      name: 'John Doe',
      position: 'Software Engineer',
      company: 'ACME Enterprises',
      avatar: 'assets/images/user_icon.png',
      phone: '3124565789',
      email: 'johndoe@acme.com',
      address1: '10 W 31st St.',
      address2: 'Chicago, IL 60616');

  userInfo.addEducation(
      logo: 'assets/images/iit.png', name: 'Illinois Tech', gpa: 3.8);

  userInfo.addEducation(
      logo: 'assets/images/school.png', name: 'Riverdale High', gpa: 4);

  userInfo.addProject(img: 'assets/images/project1.jpeg', name: 'project1');
  userInfo.addProject(img: 'assets/images/project2.png', name: 'project2');
  runApp(MyApp(userInfo: userInfo));
}

class EducationRow extends StatelessWidget {
  final Education education;

  EducationRow({required this.education});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(education.logo, width: 50, height: 50),
        Text(education.name),
        Text('${education.gpa} GPA'),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;

  ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(project.img),
          ),
          Text(project.name),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final UserInfo userInfo;

  MyApp({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: 4,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Intro(
                  name: userInfo.name,
                  position: userInfo.position,
                  company: userInfo.company,
                  avatar: userInfo.avatar,
                );
              case 1:
                return ContactInfo(userInfo: userInfo);
              case 2:
                return EducationInfo(userInfo: userInfo);
              case 3:
                return ProjectInfo(userInfo: userInfo);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({
    super.key,
    required this.userInfo,
  });

  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Projects'),
          ...userInfo.projects
              .map((project) => ProjectCard(project: project))
              .toList(),
        ],
      ),
    );
  }
}

class EducationInfo extends StatelessWidget {
  const EducationInfo({
    super.key,
    required this.userInfo,
  });

  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Education'),
        ),
        ...userInfo.education.map((edu) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: EducationRow(education: edu),
            )),
      ],
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    super.key,
    required this.userInfo,
  });

  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/phone.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(userInfo.phone),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/email.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(userInfo.email),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/address.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(userInfo.address1),
                    Text(userInfo.address2),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Intro extends StatelessWidget {
  final String name;
  final String position;
  final String company;
  final String avatar;

  Intro({
    Key? key,
    required this.name,
    required this.position,
    required this.company,
    required this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(avatar, fit: BoxFit.cover)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(position),
            Text(company),
          ],
        ),
      ],
    );
  }
}

class Education {
  final String logo;
  final String name;
  final double gpa;

  Education({
    required this.logo,
    required this.name,
    required this.gpa,
  });
}

class Project {
  final String img;
  final String name;

  Project({
    required this.img,
    required this.name,
  });
}

class UserInfo {
  final String name;
  final String position;
  final String company;
  final String avatar;
  final String phone;
  final String email;
  final String address1;
  final String address2;

  List<Education> education = [];
  List<Project> projects = [];

  UserInfo({
    required this.name,
    required this.position,
    required this.company,
    required this.avatar,
    required this.phone,
    required this.email,
    required this.address1,
    required this.address2,
  });

  void addEducation(
      {required String logo, required String name, required double gpa}) {
    education.add(Education(logo: logo, name: name, gpa: gpa));
  }

  void addProject({required String img, required String name}) {
    projects.add(Project(img: img, name: name));
  }
}
