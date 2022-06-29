import 'package:flutter/material.dart';

const SELECT_JOY_STICK_BUTTON_TEXT = "JOYSTICK";
const SELECT_ACCELEROMETER_BUTTON_TEXT = "ACCELEROMETER";
const RANDOM_TAP_TEXT = "Random";
const COUNT_DOWN_TAP_TEXT = "Count Down";
const MULTI_GOAL_TAP_TEXT = "Multi Goal";

const JOY_STICK_RANDOM_CONTROLLER = 1;
const JOY_STICK_COUNT_DOWN_CONTROLLER = 2;
const JOY_STICK_SINK_HOLE_CONTROLLER = 3;
const JOY_STICK_MULTI_GOAL_CONTROLLER = 4;

const CONTROLLER_LENGTH = 4;

const WIDGET_SIZE = 300.0;
const SIZEDBOX_HEIGHT = 10.0;

const int ROWS = 15;
const int COLUMNS = 15;

const WALL_COUNT = 5;
const SINK_HOLE_COUNT = 5;
const GOAL_COUNT = 7;

const GOAL_FLAG = -1;
const WALL_FLAG = -2;
const SINK_HOLE_FLAG = -3;
const OK_FLAG = -4;
const CORRECT_GOAL_FLAG = -5;
const WRONG_GOAL_FLAG = -6;

const WIN_SNACK_BAR_TEXT = "성공!!!";
const FAIL_SNACK_BAR_TEXT = "실패ㅠㅠㅠ";
const REQUIRE_COUNT_DOWN_SNACK_BAR_TEXT = "Countdown Timer를 시작해주세요!";
const IS_SINK_HOLE_SNACK_BAR_TEXT = "싱크홀에 빠졌습니다! 실패!";
const COUNT_DOWN_SUCCESS_SNACK_BAR_TEXT = "Count Down Game Success!";
const COUNT_DOWN_FAIL_SNACK_BAR_TEXT = "Count Down Game Failㅠㅠ";


const START_COUNT_DOWN_TEXT = "Start CountDown!";
const STOP_COUNT_DOWN_TEXT = "Stop CountDown!";

const COUNT_DOWN_SECONDS = 15;
const GAME_COUNT = 5;

const List GoalColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

const DURATION_MILLISECONDS = 350;
const TINY_DIFF = 1.0;
