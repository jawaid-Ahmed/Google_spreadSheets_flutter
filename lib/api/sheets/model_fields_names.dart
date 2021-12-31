class AttendanceFields{
  static String id="Id";
  static String userId="UserId";
  static String userName="Username";
  static String date="Date";

  ///these are just columns names initialized at one place to show on first
  ///row of your spread sheet .

  static List<String> getFields() => [id,userId,userName,date];

}