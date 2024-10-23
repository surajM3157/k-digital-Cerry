class ApiUrls
{
   static final String baseUrl = "http://192.168.1.39:3001/api/v1/guest";
   //static final String baseUrl = "http://192.168.1.39:3001/api/v1/guest";

   static String loginApiUrl = "$baseUrl/auth/login-guest";
   static String otpApiUrl = "$baseUrl/auth/verify-otp";
   static String speakerApiUrl = "$baseUrl/event/list-speakers";
   static String sponsorApiUrl = "$baseUrl/event/list-sponsors";
   static String partnerApiUrl = "$baseUrl/event/list-partners";
   static String bannerApiUrl = "$baseUrl/event/list-banners";
   static String agendaApiUrl = "$baseUrl/event/list-agenda";

}




