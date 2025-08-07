
class PathApi
{
  // static String baseUri = 'https://attach.loader.co.in/api/';
  static String baseUri = 'https://apiattach.framekarts.com/api/';
  static String socketUri = 'http://apiattach.framekarts.com:5643';
  static String logIn = 'users/sendOtp';
  static String verify = 'users/verifyOtp';
  static String createProfile = 'users/createProfile';
  static String language = 'user/getLanguageList';
  static String addBank = 'users/createbankAccountDetails';
  static String follow = '/followAndUnFollowListener';
  static String createCallHistory = '/users/createCallHistory';
  static String updateCallHistory = '/users/updateCallHistory';
  static String createThread = '/createThread';
  static String createStory = 'users/createStory';
  static String company = 'user/getCompany';
  static String contactus = '/users/createContact';
  static String createKyc = 'users/createKyc';
  static String seenStory = '/users/storySeen';
  static String createTransection = '/users/createTransaction';
  static String goOnlineOrOffline = '/users/onlineStatusChange';
  static String setViodeoAndAudioOff = '/users/audioVideoOFF';
  static String becomeListener = '/becomeAListener';
  static String updateBell = 'createNotificationBell';
  static String sendContactRequest = '/createMessage';
  static String endSession = '/sessionEnd';
  static String createRating = '/createRating';
  static String getListerNerQuestion = 'getAllQuestions';
  static String acquire = '/agora/acquire';
  static String startRecord = '/agora/start';
  static String stopRecord = '/agora/stop';



  static String logOut(String userId)
  {
    return '$baseUri/users/logoutUser?userId=$userId';
  }

  static getCallHistory(String userId,String page)
  {

    return '$baseUri/users/getAllCallHistoryById?userId=$userId&page=$page';
  }

  static getNotification(String userId,int page)
  {

    return '$baseUri/getAllNotificationByuserId?userId=$userId&page=$page';
  }

  static String deleteStory(String storyID)
  {
    return 'users/deleteStory?storyId=$storyID';
  }



  static String sampleUrl()
  {

    return '';
  }


  static String updateUser(String userId)
  {

    return '/users/updateProfile?userId=$userId';
  }

  static String getUser(String userId,{String? listenerId})
  {

    return '$baseUri/users/getUserProfile?userId=$userId${listenerId!=null?'&listenerId=$listenerId':''}';
  }

  static String getAllBank(String userId)
  {

    return '/users/getAllBankAccountDetailsOfUser?userId=$userId';
  }

  static String getAllTransection(String userId)
  {

    return '$baseUri/users/getListTransaction?search=$userId';
  }





}