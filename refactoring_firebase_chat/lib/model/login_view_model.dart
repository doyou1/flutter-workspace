class LoginViewModel {
  // 로그인 처리시 로딩 위젯
  bool isShowSpinner;
  // 비밀번호 표시 여부 플래그
  bool isVisiblePassword;
  // 아이디 기억 여부 플래그(로그인시 Hive 저장 필요)
  bool isSaveId;

  LoginViewModel({
    this.isShowSpinner = false,
    this.isVisiblePassword = false,
    this.isSaveId = false,
  });
}
