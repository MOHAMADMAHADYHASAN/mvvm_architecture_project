class AppUrl {

  static var productUrl = "https://dummyjson.com/products";

 //-- static var baseUrl = my  addresss  you cangive yours
  //this is emulator address
  static var baseUrl = "http://10.0.2.2:3000";


  static var logInUrl = '$baseUrl/api/auth/logIn';
  static var signupUrl = '$baseUrl/api/auth/singUp';

//task url
  static var getTasksUrl = '$baseUrl/api/task/alltask';
  static var createTaskUrl = '$baseUrl/api/task/create';
  static var completeTaskUrl = '$baseUrl/api/task/complete';
  static var deleteTaskUrl = '$baseUrl/api/task/deletetask';


}

