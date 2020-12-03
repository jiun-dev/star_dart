import 'dart:math';

var random = Random();

class Unit {
  String name;
  int hp;
  int speed;
  int location;

  Unit({
    this.name,
    this.hp,
    this.speed,
    this.location,
  });

  void createUnit(Unit unit, int hp, int speed) {
    print('${name} 유닛이 생성되었습니다.');
  }

  void move(Unit unit, int location) {
    print('${name} : ${location} 방향으로 이동합니다.[속도 : ${speed}');
  }

  void damaged() {
    print('${name} : ${damaged} 데미지를 입었습니다.');
    print('${name} : 현재 체력은 ${hp} 입니다.');
  }

  void attack(Unit unit, int location, int damage) {
    print('${name} ${location} 방향으로 공격 합니다. [공격력 ${damage}]');
  }
}

// 공격 유닛
class AttackUnit extends Unit {
  int damage;

  AttackUnit({this.damage});
}

// 마린
class Marine extends AttackUnit {
  Marine({
    name = '마린',
    hp = 40,
    damage = 10,
    speed = 5,
  });
  int attackSpeed = 5;
  bool setStimPack = true;

  void steamPack() {
    if (hp > 10) {
      hp -= 10;
      print('${name} : 스팀팩을 사용합니다. (HP 10 감소)');
    } else {
      print('${name} : 체력이 부족하여 스팀팩을 사용하지 않습니다.');
    }
  }
}

// 탱크
class Tank extends AttackUnit {
  Tank({
    name = '탱크',
    hp = 80,
    damage = 20,
    speed = 2,
  });
  bool seizeDeveloped = false; // 시즈모드 개발여부
  int attackSpeed = 35;

  void setSeizeMode() {
    if (seizeDeveloped == false) {
      return;
    } else {
      print('${name} : 시즈모드를 해제합니다.');
    }
  }
}

class Flyable extends Unit {
  void fly(Unit name, int location) {
    print('${name} : ${location} 방향으로 날아갑니다. [속도 ${speed}]');
  }
}

class FlyableAttackUnit extends Flyable {
  void move(Unit unit, int location) {
    print('${name} : ${location} 방향으로 날아갑니다. [속도 ${speed}]');
  } // 오버로딩
}

// 레이스
class Wraith extends FlyableAttackUnit {
  Wraith({
    name = '레이스',
    hp = 60,
    damage = 10,
    speed = 5,
  });
  bool clocked = false;

  void clocking(self) {
    if (self.clocked == true) {
      print('${name} : 클로킹 모드를 해제합니다.');
      self.clocked = false;
    } else {
      print('${name} : 클로킹 모드를 설정합니다.');
      self.clocked = true;
    }
  }
}

void gameStart() {
  print('[알림] 새로운 게임을 시작합니다.');
}

void gameOver() {
  print('[알림]Player님이 게임에서 퇴장하셨습니다.');
}

void main() {
  gameStart();

  // 마린 3개 생성
  var m1 = Marine();
  var m2 = Marine();
  var m3 = Marine();
  var t1 = Tank();
  var t2 = Tank();
  var w1 = Wraith();

  List<Unit> attackUnits = [];
  attackUnits.add(m1);
  attackUnits.add(m2);
  attackUnits.add(m3);
  attackUnits.add(t1);
  attackUnits.add(t2);
  attackUnits.add(w1);

  // 전군 이동
  for (unit in attackUnits) {
    unit.move('1시');
  }

  // 공격모드 준비 (마린 스팀팩, 탱크 시즈모드, 레이스 클로킹)
  for (unit in attackUnits) {
    if (unit is Marine) {
      unit.steamPack();
    } else if (unit is Tank) {
      unit.set_seize_mode();
    } else if (unit is Wraith) {
      unit.clocking;
    }
  }

// 전군 공격
  for (unit in attackUnits) {
    unit.attack('1시');
  }

// 전군 피해
  for (unit in attackUnits) {
    unit.damaged(random); // 랜덤으로 공격을 받음
  }
  gameOver();
}
