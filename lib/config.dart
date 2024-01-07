class Config{
  static const String appName = "Kid Emporium";
  static const String apiURL = "192.168.0.109:4000";
  static const String registerAPI = "api/register";
  static const String loginAPI = "api/login";

  //reminder
  static const String createReminderAPI = "api/reminder";
  static const String getReminderAPI = "api/get-reminder";
  static const String deleteReminderAPI = "api/delete-reminder";
  static const String getReminderDetailsAPI = "api/get-reminder-details";
  static const String updateReminderAPI = "api/update-reminder";

  //child
  static const String createChildAPI = "api/child";
  static const String getChildAPI = "api/get-child";
  static const String deleteChildAPI = "api/delete-child";
  static const String getChildDetailsAPI = "api/get-child-details";
  static const String updateChildAPI = "api/update-child";
  static const String getAllChildrenAPI = "api/children";

  //therapist
  static const String createTherapistAPI = "api/therapist";
  static const String getTherapistAPI = "api/get-therapist";
  static const String deleteTherapistAPI = "api/delete-therapist";
  static const String getTherapistDetailsAPI = "api/get-therapist-details";
  static const String updateTherapistAPI = "api/update-therapist";
  static const String getAllTherapistsAPI = "api/therapists";
}