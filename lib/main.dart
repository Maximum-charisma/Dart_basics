import 'dart:math';

void main() {
  //Первый пункт задания
  print('НОД: ' + DelimetersCalculator().nod(36, 54).toString());
  print('НОК: ' + DelimetersCalculator().nok(36, 54).toString());

  //Второй пункт задания
  Convertation().fromDecimalToBinarySystem(8);
  Convertation().fromBinaryToDecimalSystem(1000);

  //Третий пункт задания
  ParseString().getNumbersFromString('dog 40 cat 5 400 bird 7');

  //Четверый пункт задания
  print('Map из слов: ' +
      ListToMap().listOfStringToMap([
        'one',
        'two',
        'three',
        'four',
        'five',
        'four',
        'two',
        'four',
        'four'
      ]).toString());

  //Пятый пункт задания
  print('Список чисел из списка слов: ' +
      NumbersFromString().getNumbersFromString([
        'one',
        'two',
        'three',
        'four',
        'two',
        'three',
        'two',
        'three',
        'five'
      ]).toString());

  //Шестой пункт задания
  int distance = Point.zero().distanceTo(Point(10, 5, 4));
  print('Расстояние между точками равно: $distance');
  print('Площадь треугольника равна: ' +
      Point.zero()
          .calculateAreaOfTriangle(
              Point(10, 5, 8), Point(4, 9, 1), Point(7, 3, 6))
          .toString());

  //Седьмой пункт задания
  print('Корень в n-ной степени равен: ' + (125.squareRoot(3)).toString());

  //Восьмой пункт задания
  print('Система почты: ' + AdminUser('q.macks555@gmail.com').getMailSystem());

  UserManager userManager = UserManager();

  userManager.addUser(AdminUser('maxim@gmail.com'));
  userManager.addUser(GeneralUser('elena@gmail.com'));
  userManager.addUser(GeneralUser('alex@icloud.com'));
  userManager.addUser(GeneralUser('yulia@yandex.ru'));
  userManager.addUser(GeneralUser('masha@mail.com'));
  userManager.printEmails();

  //Девятый пункт задания
  
}

class Convertation {
  void fromDecimalToBinarySystem(int a) {
    String b = '';

    while (a > 0) {
      b = (a % 2).toString() + b;
      a = a ~/ 2;
    }
    print('Из десятичной системы в двоичную: ' + b);
  }

  void fromBinaryToDecimalSystem(int a) {
    print('Из двоичной системы в десятичную: ' +
        int.parse(a.toString(), radix: 2).toString());
  }
}

class DelimetersCalculator {
  int nod(int a, int b) {
    while (a > 0 && b > 0) {
      if (a == b) {
        return a;
      } else {
        if (a > b) {
          return a - b;
        } else {
          return b - a;
        }
      }
    }
    return 0;
  }

  int nok(int a, int b) {
    return (a * b) ~/ nod(a, b);
  }
}

class ParseString {
  bool isNumber(String item) {
    return '0123456789'.split('').contains(item);
  }

  void getNumbersFromString(String text) {
    RegExp exp = RegExp(r"[^+ 0-9]");
    String res = text.replaceAll(exp, '');
    List numbers = res.split(' ').toList();
    numbers.removeWhere((element) => element.isEmpty);
    List<num> newList = numbers.map((e) => int.parse(e)).toList();

    print('Коллекция чисел: ' + newList.toString());
  }
}

class ListToMap {
  Map<String, int> listOfStringToMap(List<String> strings) {
    Map<String, int> stringMap = {};
    for (var element in strings) {
      if (stringMap.containsKey(element)) {
        stringMap.update(element, (value) => value += 1);
      } else {
        stringMap.putIfAbsent(element, () => 1);
      }
    }
    return stringMap;
  }
}

class NumbersFromString {
  List<int> getNumbersFromString(List<String> strings) {
    List<int> numbers = [];
    strings.toSet();
    Map<int, String> checkWords = {
      0: 'zero',
      1: 'one',
      2: 'two',
      3: 'three',
      4: 'four',
      5: 'five',
      6: 'six',
      7: 'seven',
      8: 'eight',
      9: 'nine'
    };
    checkWords.forEach((key, value) {
      if (strings.contains(value)) {
        numbers.add(key);
      }
    });
    return numbers;
  }
}

class Point {
  final int x;
  final int y;
  final int z;
  Point(this.x, this.y, this.z);

  factory Point.zero() {
    return Point(0, 0, 0);
  }

  factory Point.one() {
    return Point(1, 1, 1);
  }

  // Отдельный метод для упрощения нахождения расстояния между точками
  int distanceBetweenPoints(Point firstPoint, Point secondPoint) {
    return sqrt((firstPoint.x - secondPoint.x) *
                (firstPoint.x - secondPoint.x) +
            (firstPoint.y - secondPoint.y) * (firstPoint.y - secondPoint.y) +
            (firstPoint.z - secondPoint.z) * (firstPoint.z - secondPoint.z))
        .round();
  }

  // Расстояние между двумя точками
  int distanceTo(Point another) {
    return distanceBetweenPoints(Point(x, y, z), another);
  }

  // Нахождение площади треугольника ABC, знаю, что переменные называются с маленькой буквы, но в данном примере будет понятнее с заглавных букв
  int calculateAreaOfTriangle(Point A, Point B, Point C) {
    int AB = distanceBetweenPoints(A, B);
    print('AB = ' + AB.toString());

    int BC = distanceBetweenPoints(B, C);
    print('BC = ' + BC.toString());

    int AC = distanceBetweenPoints(A, C);
    print('AC = ' + AC.toString());

    // Координаты точки D, которая находится между точками A и B
    Point D = Point((A.x + B.x) ~/ 2, (A.y + B.y) ~/ 2, (A.z + B.z) ~/ 2);

    // Расстояние между точками A и D (Половина основания)
    int AD = distanceBetweenPoints(A, D);

    // Нахождения высоты треугольника ABC
    int DC = distanceBetweenPoints(D, C);
    print('Высота = ' + DC.toString());

    return DC * AD;
  }
}

extension on num {
  num posOrNegNum(num x) {
    return (x < 0) ? -x : x;
  }

  num squareRoot(num root) {
    if (root > 0) {
      double counter = 1, answer = 0, number = 0.00001;

      while (answer < posOrNegNum(this)) {
        if (counter < root) {
          while (counter < root) {
            if (answer == 0) {
              answer = number * number;
            } else {
              answer *= number;
            }
            counter++;
          }
        } else {
          counter = 1;
          answer = 0;
          number += 0.00001;
        }
      }
      if (answer.round() == round()) {
        return number;
      } else {
        throw ArgumentError();
      }
    } else {
      throw ArgumentError();
    }
  }
}

class User {
  final String email;

  User(this.email);
}

class AdminUser extends User with GetMailSystem {
  AdminUser(String email) : super(email);
}

class GeneralUser extends User {
  GeneralUser(String email) : super(email);
}

mixin GetMailSystem on User {
  String getMailSystem() {
    String system = '';
    bool isGone = false;
    return email.split('@')[1];
  }
}

class UserManager<T extends User> {
  List<T> users = [];

  void addUser(T user) {
    users.add(user);
  }

  void deleteUser(T user) {
    users.remove(user);
  }

  void printEmails() {
    users.forEach((element) {
      if (element is GeneralUser) {
        print('email General User: ' + element.email);
      } else if (element is AdminUser) {
        print('email Admin User: ' + AdminUser(element.email).getMailSystem());
      }
    });
  }
}
