class ApiUrls
{
   static final String baseUrl = "http://192.168.1.39:3001/api/v1/guest";
   static final String imageUrl = "http://192.168.1.39:3001/";
   //static final String baseUrl = "http://192.168.1.39:3001/api/v1/guest";
  // https://piwotbe.kdcstaging.in

   static String loginApiUrl = "$baseUrl/auth/login-guest";
   static String otpApiUrl = "$baseUrl/auth/verify-otp";
   static String speakerApiUrl = "$baseUrl/event/list-speakers";
   static String sponsorApiUrl = "$baseUrl/event/list-sponsors";
   static String partnerApiUrl = "$baseUrl/event/list-partners";
   static String bannerApiUrl = "$baseUrl/event/list-banners";
   static String agendaApiUrl = "$baseUrl/event/list-agenda";
   static String sessionListApiUrl = "$baseUrl/event/list-sessions-by-category";
   static String floorPlanApiUrl = "$baseUrl/event/list-floor-plan";
   static String guestDetailsApiUrl = "$baseUrl/auth/guest-details";
   static String updateProfileApiUrl = "$baseUrl/auth/update-guest-details";
   static String listLinksApiUrl = "$baseUrl/event/list-links";
   static String liveSessionApiUrl = "$baseUrl/event/list-live-events";
   static String aboutUsApiUrl = "$baseUrl/event/list-about-us";
   static String faqApiUrl = "$baseUrl/event/list-faq";
   static String friendListApiUrl = "$baseUrl/chat/friends";
   static String guestListApiUrl = "$baseUrl/event/list-guest";
   static String sendRequestApiUrl = "$baseUrl/chat/send-friend-request";
   static String pendingRequestApiUrl = "$baseUrl/chat/pending-requests";
   static String handleRequestApiUrl = "$baseUrl/chat/handle-friend-request";
   static String sessionSurveysApiUrl = "$baseUrl/event/list-survey";
   static String addSurveyApiUrl = "$baseUrl/event/add-feedback";

}




