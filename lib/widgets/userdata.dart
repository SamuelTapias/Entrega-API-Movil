class UserInfo {
  final String token;
  final String username;
  final String name;
  final String email;

  UserInfo({this.token, this.username, this.name, this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      token: json['token'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
    );
  }

  String prn(){
    return ""+ name+" "+email+" "+username; 
  }
}

class Validation {
  final bool valid;

  Validation({this.valid});

  factory Validation.fromJson(Map<String, dynamic> json) {
    return Validation(
      valid: json['valid'],
    );
  }
}

class Course{
  final int id;
  final String name;
  final String professor; 
  final int students;

  Course({this.id, this.name, this.professor, this.students});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      professor: json['professor'],
      students: json['students'],
    );
  }
  String toString(){
    return ""+ id.toString()+" "+name+" "+professor+" "+students.toString(); 
  }
}

class InCourse{
  final String name;
  final ProfessorInCourse professor;
  final List<StudentInCourse> students;

  InCourse({this.name, this.professor,this.students});

  factory InCourse.fromJson(Map<String, dynamic> json) {
    var list = json['students'] as List;
    List<StudentInCourse> studentsList = list.map((i) => StudentInCourse.fromJson(i)).toList();
    return InCourse(
      name: json['name'],
      professor: ProfessorInCourse.fromJson(json['professor']),
      students: studentsList,
    );
  }
  String toString(){
    return ""+name+" "+professor.toString()+" "+students.toString(); 
  }
  String getName(){
    return this.name;
  }
}

class StudentInCourse{
  final int id;
  final String name;
  final String username; 
  final String email;

  StudentInCourse({this.id, this.name, this.username, this.email});

  factory StudentInCourse.fromJson(Map<String, dynamic> json) {
    return StudentInCourse(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
  String toString(){
    return ""+ id.toString()+" "+name+" "+username+" "+email; 
  }
}

class ProfessorInCourse{
  final int id;
  final String name;
  final String username; 
  final String email;

  ProfessorInCourse({this.id, this.name, this.username, this.email});

  factory ProfessorInCourse.fromJson(Map<String, dynamic> json) {
    return ProfessorInCourse(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
  String toString(){
    return ""+ id.toString()+" "+name+" "+username+" "+email; 
  }
}
class Student{
  final int id;
  final String name;
  final String username; 
  final String phone; 
  final String email;
  final String city; 
  final String country; 
  final String birthday;

  Student({this.id, this.name, this.username,this.phone, this.email,this.city,this.country,this.birthday});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['course_id'],
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
      country: json['country'],
      birthday: json['birthday'],
    );
  }
  String toString(){
    return ""+ id.toString()+" "+name+" "; 
  }
}

class AllStudents{
  final List<StudentInCourse> students;

  AllStudents({this.students});

  factory AllStudents.fromJson(List<dynamic> json) {
    
    List<StudentInCourse> studentsList = json.map((i) => StudentInCourse.fromJson(i)).toList();
    return AllStudents(
      students: studentsList,
    );
  }
  String toString(){
    return " "+students.toString(); 
  }
  
}