// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// final Set<JavascriptChannel> jsChannels = [
//   JavascriptChannel(
//       name: 'Print', onMessageReceived: (JavascriptMessage message) {}),
// ].toSet();

// class WebViewUtil extends StatefulWidget {
//   /* 
//   Page Types 
//   0 = default
//   1 = From Course Deatils to Feedback & Review
//   2 = From CourseDeatils to Choose Package
//   3 = From Razorypay to Payment Success Page
//   4 = From Notification
//   5 = From Profile to Package Selection
//   6 = From Profile to FFA
//   7 = From Profile to T&C
//   8 = From Dashboard to LearnMoney
//   9 = From Learn Money  to  Profile
//   10 = From Get Advice  to  chat
//   11 = From Deeplinking
//   12 = From Profile to AddMember
//   13 = From CourseDetails Trailer Feedback Page to Choose course
//   14 = From ChooseCourse To Subscription Package
//   15 = From Advertisement Dashboard To Webview  
//   16 = From DC Booking Screen to Payment Checkout Page
//   17 = From Notification Screen to DC Visitor Webview
//   18 = From Community V2 home screen to Package selection
//   */
//   final int pageType;
//   final bool enableAppBar;
//   final bool enbaleBackArrow;
//   final Widget appTitle;
//   final bool appTitleCenter;
//   final data;
//   final String loadUrl;
//   // from choose course ad Details
//   final String catID;

//   final String goalID;
//   final String goalName;

//   const WebViewUtil(
//       {Key key,
//       this.pageType = 0,
//       this.enableAppBar = true,
//       this.enbaleBackArrow = true,
//       this.appTitle,
//       this.appTitleCenter = false,
//       this.data,
//       this.loadUrl,
//       this.goalID,
//       this.catID,
//       this.goalName})
//       : super(key: key);

//   @override
//   _WebViewUtilState createState() => _WebViewUtilState();
// }

// class _WebViewUtilState extends State<WebViewUtil> with WidgetsBindingObserver {
//   Service api = new Service();
//   PrintUtil printUtil = PrintUtil();
//   AppLanguageUtil appLanguageUtil = new AppLanguageUtil();
//   ToastUtil toastUtil = new ToastUtil();

//   /* Instance of WebView plugin */
//   final flutterWebViewPlugin = FlutterWebviewPlugin();

//   /* Webview Streams */
//   StreamSubscription _onDestroy;
//   StreamSubscription<String> _onUrlChanged;
//   StreamSubscription<WebViewStateChanged> _onStateChanged;
//   StreamSubscription<WebViewHttpError> _onHttpError;

//   /* Post Value Declaration */
//   String mobileNo;
//   String secretKey;
//   String deviceType;
//   String deviceModel;
//   String deviceVersion;
//   String deviceId;
//   String deviceBrand;
//   String mobileAppVersion;
//   String languageId;
//   String countryCode;
//   String countryDialCode;
//   String countryId;

//   /* Sync Lang Text */
//   String internetAlert = '';
//   String noInternetMsg = "Oops! No Internet Connection";
//   String noInteenetDesc =
//       "Make sure wifi or cellular data is turned on and then try again.";
//   String retryBtn = "Try Again";

//   /* Internet Listeners */
//   var connectivitySubscription;
//   bool isNetworkConnected = false;
//   var currentUrl = '';
//   var interUrl = '';
//   ConnectivityResult previousConRes;
//   var loadingStyle = '''
//     <style>
//         body {
//           position: relative;
//           display:table-cell;
//           width:100vh;
//           height:100vh;
//           text-align:center;
//           vertical-align:middle;
//         }
//         .loader {
//           margin: 0;
//           display: inline-block;
//           top: 50%;
//           -ms-transform: translate(-50%, -50%);
//           transform: translate(-50%, -50%);
//           border: 10px solid #f3f3f3;
//           border-radius: 50%;
//           border-top: 10px solid #4378FF;
//           width: 50px;
//           height: 50px;
//           -webkit-animation: spin 2s linear infinite; /* Safari */
//           animation: spin 2s linear infinite;
//         }      /* Safari */
//         @-webkit-keyframes spin {
//           0% { -webkit-transform: rotate(0deg); }
//           100% { -webkit-transform: rotate(360deg); }
//         }      @keyframes spin {
//           0% { transform: rotate(0deg); }
//           100% { transform: rotate(360deg); }
//         }
//         </style>
//   ''';

//   void synLanguage() {
//     appLanguageUtil.getAppContent().then((resp) {
//       setState(() {
//         Map<String, dynamic> appContent;
//         appContent = resp;
//         internetAlert = appContent['action_items']['internent_alert'];
//         noInternetMsg = appContent['action_items']
//                 ['no_internet_connection_title'] ??
//             "Oops! No Internet Connection";
//         noInteenetDesc = appContent['action_items']['no_internet_desc'] ??
//             "Make sure wifi or cellular data is turned on and then try again.";
//         retryBtn = appContent['action_items']['retry_btn'] ?? "Try Again";
//       });
//     });
//   }

//   getPostDetails() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       mobileNo = prefs.getString('mobileNumber');
//       secretKey = prefs.getString("secretKey");
//       deviceType = prefs.getString("device_type");
//       deviceModel = prefs.getString("device_model");
//       deviceVersion = prefs.getString("device_version");
//       deviceId = prefs.getString("device_id");
//       deviceBrand = prefs.getString("device_brand");
//       mobileAppVersion = prefs.getString("mobile_app_version");
//       languageId = prefs.getString("languageId");
//       countryCode = prefs.getString('countryCode') ?? "";
//       countryDialCode = prefs.getString('countryDialCode') ?? "";
//       countryId = prefs.getString('countryId') ?? "";
//     });
//   }

//   /* On change in network wifi/mobile data */
//   void onNetworkChange() {
//     connectivitySubscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) async {
//       ConnectivityResult currentConRes = result;
//       if (currentConRes != previousConRes) {
//         previousConRes = currentConRes;
//         if (result == ConnectivityResult.none) {
//           isNetworkConnected = false;
//           flutterWebViewPlugin.reloadUrl(
//               Uri.dataFromString(internetHTMLData(), mimeType: 'text/html')
//                   .toString());
//         } else if (result == ConnectivityResult.mobile) {
//           isNetworkConnected = true;
//         } else if (result == ConnectivityResult.wifi) {
//           isNetworkConnected = true;
//         }
//       }
//       setState(() {});
//     });
//   }

//   String internetHTMLData() {
//     String retryURL = widget.loadUrl + "/native?type=24&id=";
//     return '''
//       <!doctype html>
//       <html>
//       <head>
//       <meta charset="utf-8">
//       <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>

//       <title>Please check your internet connection</title>
//       <style>
//         @font-face {
//         font-family: 'product_sansregular';
//         src: url('./fonts/productsans-regular-webfont.woff2') format('woff2'),
//           url('./fonts/productsans-regular-webfont.woff') format('woff');
//         font-weight: normal;
//         font-style: normal;
//       }
//       :root {
//         font-size: 16px;
//       }
//       body {
//         font-family: 'product_sansregular';
//       }
//       h1 {
//         font-size: 1.25rem;
//       }
//         p {
//           font-size: 0.875rem;
//           line-height: 1.25rem;
//         }
//       .main-title {
//         line-height: 1.65rem;
//         color: #121036;
//         margin: 0px;
//       }
//         .no-internet {
//         position: fixed;
//         width: 100%;
//         height: 100vh;
//         background: #ffffff;
//         padding: 0px 30px;
//         box-sizing: border-box;
//         overflow: hidden;
//         z-index: 1;
//       }
//       .no-internet .no-internet-wrapper {
//         padding: 50px 0px 0px 0px;
//       }
//       .no-internet-wrapper .img {
//         display: inline-block;
//         width: 65px;
//         margin: 0px 0px 20px 0px;
//       }
//       .no-internet-wrapper .img svg {
//         width:100%;
//         float: left;
//       }
//       .txt-a-c {
//         text-align: center;
//       }
//       .bx,.space1,.space2,.space3,.space4,.space5 {
//         position: relative;
//         width: 100%;
//         float: left;
//       }
//       .space1 {
//         height: 10px;
//       }
//       .space2 {
//         height: 20px;
//       }
//       .cta {
//         border: none;
//         line-height: 2.5rem;
//         padding: 0px 20px;
//         border-radius: 25px;
//       }
//       .primary-cta {
//         color: #ffffff;
//         background: #4378FF;
//       }
//       </style>
//       <script type="text/javascript">
//           window.history.forward();
//           function noBack() {
//               window.history.forward();
//           }
//       </script>
//       </head>
//       <body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="" class="no-internet">
//       <section class="no-internet-wrapper txt-a-c">
//         <div class="img">
//           <svg version="1.1" x="0px" y="0px"
//         viewBox="0 0 111 272" style="enable-background:new 0 0 111 272;" xml:space="preserve">
//       <style type="text/css">
//         .st0{fill:#E7E0F2;}.st1{fill:url(#SVGID_1_);}.st2{opacity:0.3;fill:#030C37;}.st3{fill:#FFFFFF;}	.st4{opacity:0.5;fill:none;stroke:#FFFFFF;stroke-width:4;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;}.st5{fill:#030C37;}.st6{opacity:0.8;fill:#121036;}	.st7{fill:#FFFFFF;stroke:#121036;stroke-width:4;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;}</style><g><path class="st0" d="M111.3,258.4c0,7.7-6.2,13.9-13.9,13.9H14c-7.7,0-13.9-6.2-13.9-13.9V84.1C0,76.4,6.3,70.2,14,70.2h83.5
//           c7.7,0,13.9,6.2,13.9,13.9V258.4z"/></g><g><linearGradient id="SVGID_1_" gradientUnits="userSpaceOnUse" x1="24.5962" y1="99.3849" x2="83.2629" y2="214.0515"><stop  offset="0" style="stop-color:#2B1661"/><stop  offset="1" style="stop-color:#3A0092"/></linearGradient><path class="st1" d="M103.4,238.5c0,2-1.7,3.7-3.7,3.7H11.6c-2,0-3.7-1.7-3.7-3.7V81.8c0-2,1.7-3.7,3.7-3.7h88.1
//           c2,0,3.7,1.7,3.7,3.7V238.5z"/></g><path class="st2" d="M65,256.7c0,5.1-4.2,9.3-9.3,9.3c-5.1,0-9.3-4.2-9.3-9.3c0-5.1,4.2-9.3,9.3-9.3C60.8,247.5,65,251.6,65,256.7z"
//         /><g><path class="st3" d="M39.5,134.6c-3.2,0-5.9,2.6-5.9,5.9c0,3.2,2.6,5.9,5.9,5.9c3.2,0,5.9-2.6,5.9-5.9
//           C45.3,137.3,42.7,134.6,39.5,134.6z"/><path class="st3" d="M71.9,134.6c-3.2,0-5.9,2.6-5.9,5.9c0,3.2,2.6,5.9,5.9,5.9c3.2,0,5.9-2.6,5.9-5.9
//           C77.8,137.3,75.2,134.6,71.9,134.6z"/></g><path class="st4" d="M35,181.6c0,0,16.7-25.3,41.4-10.8"/>
//       <path class="st5" d="M44.2,140.6c0,1.1-0.9,1.9-1.9,1.9c-1.1,0-1.9-0.9-1.9-1.9s0.9-1.9,1.9-1.9C43.4,138.7,44.2,139.5,44.2,140.6z"
//         /><path class="st5" d="M76.7,140.6c0,1.1-0.9,1.9-1.9,1.9c-1.1,0-1.9-0.9-1.9-1.9s0.9-1.9,1.9-1.9C75.8,138.7,76.7,139.5,76.7,140.6z"
//         /><path class="st6" d="M38.2,47.5l2.5,3.4c1.8-0.7,3.7-1.2,5.7-1.6l-1.7-3.8C42.4,46,40.3,46.6,38.2,47.5z"/>
//       <path class="st6" d="M70.7,49c-5.2-2.7-11.1-4.3-17.3-4.4l0.7,4.1c5.1,0.2,9.8,1.5,14.1,3.6L70.7,49z"/><path class="st6" d="M30.5,37.1l2.5,3.3c2.5-1.2,5.2-2.2,8-3l-1.7-3.7C36.2,34.5,33.3,35.7,30.5,37.1z"/><path class="st6" d="M75.9,42.1l2.5-3.3c-7.5-4.5-16.2-7.1-25.5-7.1c-0.5,0-1,0-1.6,0l0.7,4c0.3,0,0.6,0,0.9,0
//         C61.3,35.8,69.1,38.1,75.9,42.1z"/><path class="st6" d="M23,26.8l2.4,3.3c3.2-1.8,6.6-3.3,10.2-4.4L33.9,22C30.1,23.2,26.4,24.9,23,26.8z"/><path class="st6" d="M83.4,32.1l2.5-3.3c-9.5-6.2-20.8-9.9-33.1-9.9c-1.2,0-2.5,0-3.7,0.1l0.7,4c1-0.1,2-0.1,3-0.1
//         C64.1,23,74.6,26.3,83.4,32.1z"/><path class="st6" d="M16.1,17l1.4,2.3l0.8,1.1c3.8-2.3,7.9-4.3,12.2-5.8l-1.7-3.7C24.4,12.5,20.1,14.6,16.1,17z"/>
//       <path class="st6" d="M90.6,22.6l2.5-3.3C81.6,11.4,67.8,6.7,52.9,6.7c-1.9,0-3.8,0.1-5.7,0.2l0.7,4c1.7-0.1,3.3-0.2,5-0.2
//         C66.9,10.8,79.8,15.2,90.6,22.6z"/><line class="st7" x1="25" y1="2" x2="55.9" y2="63.5"/></svg>
//         </div>
//         <h1 class="main-title">Oops! No<br>Internet Connection</h1>
//         <div class="space1">&nbsp;</div>
//         <p>Make sure wifi or cellular data<br>is turned on and then try again.</p>
//         <div class="space2">&nbsp;</div>
//         <div class="bx txt-a-c">
//           <a href="$retryURL"><button class="btn cta primary-cta">Retry</button></a>
//         </div>
//       </section>
//       </body>
//       </html>
//     ''';
//   }

//   String loadHTMLData(webUrl) {
//     var requestData;
//     /* Payment Response*/
//     if (widget.pageType == 3 ||
//         widget.pageType == 4 ||
//         widget.pageType == 1 ||
//         widget.pageType == 13) {
//       if (widget.data != null) {
//         requestData = " ";
//         var values = json.decode(widget.data);
//         values.forEach((key, value) {
//           if (key != "course_name") {
//             requestData = requestData +
//                 '<input type="hidden" name="$key" value="$value" />  ';
//           }
//         });
//       } else {
//         requestData = "";
//       }
//     }

//     var notPostData;
//     if (widget.pageType == 11) {
//       if (widget.data != null) {
//         notPostData = [];
//         var values = json.decode(widget.data);
//         values.forEach((key, value) {
//           return notPostData
//               .add('<input type="hidden" name="$key" value="$value" />');
//         });
//       } else {
//         notPostData = '';
//       }
//     }

//     if (widget.pageType == 16 || widget.pageType == 17) {
//       if (widget.data != null) {
//         requestData = " ";
//         var values = json.decode(widget.data);
//         values.forEach((key, value) {
//           requestData = requestData +
//               '<input type="hidden" name="$key" value="$value" />  ';
//         });
//       } else {
//         notPostData = '';
//       }
//     }

//     /* Subcription Package */
//     if (widget.pageType == 2) {
//       if (widget.data != null) {
//         requestData = " ";
//         requestData = requestData +
//             '<input type="hidden" name="course_id" value="${widget.data}" />  ';
//       } else {
//         requestData = "";
//       }
//     }

//     if (widget.pageType == 15) {
//       if (widget.data != null) {
//         requestData = " ";
//         requestData = requestData +
//             '<input type="hidden" name="ads_id" value="${widget.data}" />  ';
//       } else {
//         requestData = "";
//       }
//     }

//     if (requestData != null) {
//       return '''
//       <html>
//         $loadingStyle
//         <body onload="document.f.submit();">
//           <div class="loader"></div>
//           <form id="f" name="f" method="post" action="$webUrl">
//            <input type="hidden" name="secret_key" value="$secretKey" />
//            <input type="hidden" name="mobile_number" value="$mobileNo" />
//            <input type="hidden" name="device_type" value="$deviceType" />
//            <input type="hidden" name="device_model" value="$deviceModel" />
//            <input type="hidden" name="device_version" value="$deviceVersion" />
//            <input type="hidden" name="device_id" value="$deviceId" />
//            <input type="hidden" name="device_brand" value="$deviceBrand" />
//            <input type="hidden" name="mobile_app_version" value="$mobileAppVersion" />
//            <input type="hidden" name="app_language" value="$languageId" />
//            <input type="hidden" name="country_code" value="$countryCode" />
//            <input type="hidden" name="country_dial_code" value="$countryDialCode" />
//            <input type="hidden" name="country_id" value="$countryId" />
//            ${requestData.toString()}
//           </form>
//         </body>
//       </html>
//     ''';
//     } else if (notPostData != null) {
//       return '''
//       <html>
//         $loadingStyle
//         <body onload="document.f.submit();">
//           <div class="loader"></div>
//           <form id="f" name="f" method="post" action="$webUrl">
//            <input type="hidden" name="secret_key" value="$secretKey" />
//            <input type="hidden" name="mobile_number" value="$mobileNo" />
//            <input type="hidden" name="device_type" value="$deviceType" />
//            <input type="hidden" name="device_model" value="$deviceModel" />
//            <input type="hidden" name="device_version" value="$deviceVersion" />
//            <input type="hidden" name="device_id" value="$deviceId" />
//            <input type="hidden" name="device_brand" value="$deviceBrand" />
//            <input type="hidden" name="mobile_app_version" value="$mobileAppVersion" />
//            <input type="hidden" name="app_language" value="$languageId" />
//             <input type="hidden" name="country_code" value="$countryCode" />
//            <input type="hidden" name="country_dial_code" value="$countryDialCode" />
//            <input type="hidden" name="country_id" value="$countryId" />
//            ${notPostData.toString()}
//           </form>
//         </body>
//       </html>
//     ''';
//     } else {
//       return '''
//       <html>
//         $loadingStyle
//         <body onload="document.f.submit();">
//           <div class="loader"></div>
//           <form id="f" name="f" method="post" action="$webUrl">
//            <input type="hidden" name="secret_key" value="$secretKey" />
//            <input type="hidden" name="mobile_number" value="$mobileNo" />
//            <input type="hidden" name="device_type" value="$deviceType" />
//            <input type="hidden" name="device_model" value="$deviceModel" />
//            <input type="hidden" name="device_version" value="$deviceVersion" />
//            <input type="hidden" name="device_id" value="$deviceId" />
//            <input type="hidden" name="device_brand" value="$deviceBrand" />
//            <input type="hidden" name="mobile_app_version" value="$mobileAppVersion" />
//            <input type="hidden" name="app_language" value="$languageId" />
//            <input type="hidden" name="country_code" value="$countryCode" />
//            <input type="hidden" name="country_dial_code" value="$countryDialCode" />
//            <input type="hidden" name="country_id" value="$countryId" />
//           </form>
//         </body>
//       </html>
//     ''';
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     synLanguage();
//     onNetworkChange();
//     getPostDetails();
//     setUpWebViewStreams();
//     PrintUtil().printMsg("WebView Init URL || ${widget.loadUrl}");
//     if (widget.loadUrl == Service.learnMoneyUrl) {
//       ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//           Constants.pageLearnMoneyVideos);
//     } else if (widget.loadUrl == Service.ffcUrl) {
//       ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//           Constants.pageBenefit);
//     }
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.paused) {
//       if (widget.loadUrl == Service.learnMoneyUrl) {
//         ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//             Constants.pageLearnMoneyVideos);
//       } else if (widget.loadUrl == Service.ffcUrl) {
//         ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//             Constants.pageBenefit);
//       }
//     } else if (state == AppLifecycleState.resumed) {
//       if (widget.loadUrl == Service.learnMoneyUrl) {
//         ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//             Constants.pageLearnMoneyVideos);
//       } else if (widget.loadUrl == Service.ffcUrl) {
//         ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//             Constants.pageBenefit);
//       }
//     } else {}
//   }

//   setUpWebViewStreams() {
//     flutterWebViewPlugin.close();
//     _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
//       if (mounted) {}
//     });

//     _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
//       if (mounted) {
//         setState(() {
//           currentUrl = url;
//         });
//         printUtil.printMsg("On change Url " + url);
//         var originUrl = url.split('?');
//         var actionString = originUrl[0].split('/').last;
//         if (actionString == "native") {
//           Uri uri = Uri.dataFromString(url);
//           var type = uri.queryParameters['type'];
//           var id = uri.queryParameters['id'];
//           if (type == "1") {
//             Map<String, dynamic> data = {};
//             data = {
//               "type": 2,
//             };
//             Navigator.pushReplacementNamed(
//                 context, Constants.routeToInterestAndOccupation,
//                 arguments: {"data": data});
//           } else if (type == "2" || type == "3") {
//             if (id != null) {
//               flutterWebViewPlugin.goBack();
//               api.getShareData(type, id).then((resp) {
//                 printUtil.printMsg("$resp");
//                 Share.share(
//                     resp['data']['description'] + " " + resp['data']['url'],
//                     subject: resp['data']['title']);
//               });
//             }
//           } else if (type == "4") {
//             Navigator.of(context).pushReplacementNamed(Constants.routeWelcome);
//           } else if (type == "5") {
//             flutterWebViewPlugin.reloadUrl(Uri.dataFromString(
//                     loadHTMLData(widget.loadUrl),
//                     mimeType: 'text/html')
//                 .toString());
//           } else if (type == "6") {
//             Map<String, dynamic> data = {};
//             data = {
//               "selectedIndex": 0,
//             };
//             Navigator.pushReplacementNamed(
//                 context, Constants.routeGoalsBottomNavbar,
//                 arguments: {"data": data});
//           } else if (type == "7") {
//             /* Introduction */
//           } else if (type == "8") {
//             var values = json.decode(widget.data);
//             Map<String, dynamic> routeData = {};
//             routeData['data'] = {
//               "course_id": values['course_id'],
//               "course_video_id": values['video_id'],
//               "is_last_video": values['is_last_video'],
//               "course_name": values['course_name']
//             };
//             if (values['is_last_video']) {
//               Map<String, dynamic> routeData = {};
//               routeData['data'] = {
//                 "course_title": values['course_name'],
//                 "course_id": values['course_id']
//               };
//               Navigator.pushReplacementNamed(
//                   context, Constants.routeCongratulation,
//                   arguments: routeData);
//             } else {
//               routeData['data'] = {
//                 "course_title": values['course_name'],
//                 "course_id": values['course_id'],
//               };
//               Navigator.pushReplacementNamed(
//                   context, Constants.routeVideoFeedbackMain,
//                   arguments: routeData);
//             }
//           } else if (type == "16") {
//             if (widget.pageType == 13) {
//               Map<String, dynamic> data = {};
//               data = {
//                 "selectedIndex": 0,
//               };
//               Navigator.pushReplacementNamed(
//                   context, Constants.routeGoalsBottomNavbar,
//                   arguments: {"data": data});
//             } else {
//               var values = json.decode(widget.data);
//               if (values['is_last_video']) {
//                 Map<String, dynamic> routeData = {};
//                 routeData['data'] = {
//                   "course_title": values['course_name'],
//                   "course_id": values['course_id']
//                 };
//                 Navigator.pushReplacementNamed(
//                     context, Constants.routeCongratulation,
//                     arguments: routeData);
//               } else {
//                 Navigator.pushReplacementNamed(
//                     context, Constants.routeCourseDetails,
//                     arguments: values['course_id']);
//               }
//             }
//           } else if (type == "9") {
//             Navigator.of(context)
//                 .pushReplacementNamed(Constants.routeChooseCourse);
//           } else if (type == "10") {
//             /* Benefits */
//           } else if (type == "11") {
//             /* Navigate to Dashboard */
//             Map<String, dynamic> data = {};
//             data = {
//               "selectedIndex": 0,
//             };
//             Navigator.pushReplacementNamed(
//                 context, Constants.routeGoalsBottomNavbar,
//                 arguments: {"data": data});
//           } else if (type == "12") {
//             /* Wealthpedia */
//           } else if (type == "13") {
//             /* App Feedback */
//           } else if (type == "14") {
//             Navigator.of(context)
//                 .pushReplacementNamed(Constants.routeScheduleCallNormal);
//           } else if (type == "15") {
//             /* Club Video Player */
//           } else if (type == "22") {
//             Navigator.of(context)
//                 .pushReplacementNamed(Constants.routeRazorypay);
//           } else if (type == "23") {
//             Map<String, dynamic> data = {};
//             data = {
//               "selectedIndex": 0,
//             };
//             Navigator.pushReplacementNamed(
//                 context, Constants.routeGoalsBottomNavbar,
//                 arguments: {"data": data});
//           } else if (type == "24") {
//             /* Internet Retry */
//             HelperUtil.checkInternetConnection().then((isConnected) {
//               if (isConnected) {
//                 flutterWebViewPlugin.reloadUrl(Uri.dataFromString(
//                         loadHTMLData(widget.loadUrl),
//                         mimeType: 'text/html')
//                     .toString());
//               }
//             });
//           } else if (type == "25") {
//             /* DC Payment Gateway SDK */
//           } else if (type == "26" || type == "27") {
//             if (widget.data != null) {
//               var values = json.decode(widget.data);
//               Map<String, dynamic> data = {};
//               data = {
//                 "selectedIndex": 2,
//                 "configured": true,
//                 "goalID": values['goalID'].toString()
//               };
//               Navigator.of(context).pushReplacementNamed(
//                   Constants.routeDemoCenterTabBar,
//                   arguments: {"data": data});
//             } else {
//               Map<String, dynamic> data = {};
//               data = {
//                 "selectedIndex": 0,
//               };
//               Navigator.pushReplacementNamed(
//                   context, Constants.routeGoalsBottomNavbar,
//                   arguments: {"data": data});
//             }
//           }
//         }
//       }
//     });

//     _onHttpError =
//         flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) async {
//       if (int.parse(error.code) < 0) {
//         bool isConnected = await HelperUtil.checkInternetConnection();
//         if (!isConnected) {
//           flutterWebViewPlugin.reloadUrl(
//               Uri.dataFromString(internetHTMLData(), mimeType: 'text/html')
//                   .toString());
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _onDestroy?.cancel();
//     _onUrlChanged?.cancel();
//     _onStateChanged?.cancel();
//     _onHttpError?.cancel();
//     connectivitySubscription?.cancel();
//     flutterWebViewPlugin?.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     if (widget.loadUrl == Service.learnMoneyUrl) {
//       ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//           Constants.pageLearnMoneyVideos);
//     } else if (widget.loadUrl == Service.ffcUrl) {
//       ScreenDataAnalyticsTrack.addorupdateScreenDataAnalyticsTrack(
//           Constants.pageBenefit);
//     }
//     super.dispose();
//   }

//   handleBackAction() {
//     if (widget.pageType == 0) {
//       /*  0 = default */
//       Navigator.of(context).pop();
//     } else if (widget.pageType == 1) {
//       /* 1 = From Course Deatils to Feedback & Review */

//     } else if (widget.pageType == 2) {
//       /* 2 = From CourseDeatils to Choose Package */
//       Navigator.pushReplacementNamed(context, Constants.routeCourseDetails,
//           arguments: int.parse(widget.data.toString()));
//     } else if (widget.pageType == 3) {
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 4) {
//       /* 4 = From Notification */
//     } else if (widget.pageType == 5) {
//       /* 4 = From Profile to Choose Package */
//       /* Navigate to Dashboard */
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 6) {
//       /* 6 = From Profile to FFA */
//       /* Navigate to Dashboard */
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 7) {
//       /* 7 = From Profile to T&C */
//       /* Navigate to Dashboard */
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 8) {
//       /* 8 = From Dashboard to Web View  */
//       Navigator.of(context)
//           .pushReplacementNamed(Constants.routeGoalsBottomNavbar);
//     } else if (widget.pageType == 9) {
//       /* 8 = From LearnMoney to Profile */
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 10) {
//       /* 8 = From Dashboard to LearnMoney */
//       Navigator.pushReplacementNamed(context, Constants.routeGetAdviceScreen);
//     } else if (widget.pageType == 11 || widget.pageType == 15) {
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 12) {
//       /* 12 = From Profile to addmember */
//       /* Navigate to Dashboard */
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 13) {
//       /* 13 = CourseDetails Trailer Feedback Page to Choose course */
//       Map<String, dynamic> data = {};
//       data = {
//         "selectedIndex": 0,
//       };
//       Navigator.pushReplacementNamed(context, Constants.routeGoalsBottomNavbar,
//           arguments: {"data": data});
//     } else if (widget.pageType == 14) {
//       Navigator.of(context).pop();
//     } else if (widget.pageType == 16) {
//       /* 16 = From DC checkout to DC detailed page */
//       if (widget.data != null) {
//         var values = json.decode(widget.data);
//         Map<String, dynamic> data = {};
//         data = {
//           "selectedIndex": 2,
//           "configured": true,
//           "goalID": values['goalID'].toString()
//         };
//         Navigator.of(context).pushReplacementNamed(
//             Constants.routeDemoCenterTabBar,
//             arguments: {"data": data});
//       } else {
//         Navigator.pop(context);
//       }
//     } else if (widget.pageType == 17) {
//       /* 17 = From Notification Screen to DC Visitor Webview */
//       if (widget.data != null) {
//         var values = json.decode(widget.data);
//         Map<String, dynamic> data = {};
//         data = {
//           "selectedIndex": 2,
//           "configured": true,
//           "goalID": values['goalID'].toString()
//         };
//         Navigator.of(context).pushReplacementNamed(
//             Constants.routeDemoCenterTabBar,
//             arguments: {"data": data});
//       } else if (widget.pageType == 18) {
//         if (widget.data != null) {
//           Map<String, dynamic> data = {};
//           data = {"goalId": widget.data, "from": 3};
//           Navigator.pushReplacementNamed(
//               context, Constants.routeCommunityV2Home,
//               arguments: {"data": data});
//         } else {
//           Navigator.of(context).pop();
//         }
//       } else {
//         Map<String, dynamic> data = {};
//         data = {
//           "selectedIndex": 0,
//         };
//         Navigator.pushReplacementNamed(
//             context, Constants.routeGoalsBottomNavbar,
//             arguments: {"data": data});
//       }
//     } else {
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     PrintUtil().printMsg("Request WebUrl || ${loadHTMLData(widget.loadUrl)}");
//     return Material(
//       child: SafeArea(
//         child: WillPopScope(
//           onWillPop: () {
//             printUtil.printMsg("Loaded URL ${widget.loadUrl}");
//             printUtil.printMsg("Current URL $currentUrl");
//             if (Platform.isIOS) {
//               if (currentUrl == widget.loadUrl ||
//                   currentUrl == Service.learnMoneyUrl ||
//                   currentUrl == Service.addFamilyMemberUrl ||
//                   currentUrl == Service.rewardsDashboardHybirdUrl ||
//                   currentUrl == Service.ffcUrl ||
//                   currentUrl == Service.ffcUrlBase ||
//                   widget.pageType == 16 ||
//                   widget.pageType == 14 ||
//                   currentUrl.contains("/Ffc/add_family_members_action")) {
//                 handleBackAction();
//               } else {
//                 flutterWebViewPlugin.canGoBack().then(
//                   (isGoBack) {
//                     if (isGoBack) {
//                       flutterWebViewPlugin.goBack();
//                     } else {
//                       printUtil.printMsg("Came to handler back action");
//                       handleBackAction();
//                     }
//                   },
//                 );
//               }
//             } else {
//               if (currentUrl == widget.loadUrl ||
//                   currentUrl == Service.learnMoneyUrl ||
//                   currentUrl == Service.addFamilyMemberUrl ||
//                   currentUrl == Service.rewardsDashboardHybirdUrl ||
//                   currentUrl == Service.ffcUrl ||
//                   currentUrl == Service.ffcUrlBase ||
//                   widget.pageType == 16 ||
//                   widget.pageType == 14 ||
//                   currentUrl.contains("/Ffc/add_family_members_action")) {
//                 handleBackAction();
//               } else {
//                 flutterWebViewPlugin.canGoBack().then(
//                   (isGoBack) {
//                     if (isGoBack) {
//                       flutterWebViewPlugin.goBack();
//                     } else {
//                       printUtil.printMsg("Came to handler back action");
//                       handleBackAction();
//                     }
//                   },
//                 );
//               }
//             }
//           },
//           child: WebviewScaffold(
//             url: Uri.dataFromString(loadHTMLData(widget.loadUrl),
//                     mimeType: 'text/html')
//                 .toString(),
//             clearCache: false,
//             resizeToAvoidBottomInset: true,
//             javascriptChannels: jsChannels,
//             mediaPlaybackRequiresUserGesture: false,
//             withZoom: false,
//             withLocalStorage: true,
//             hidden: true,
//             withJavascript: true,
//             initialChild: Container(
//               child: Center(child: LoadingUtil.ballRotate(context)),
//             ),
//             appBar: (widget.enableAppBar)
//                 ? AppBar(
//                     elevation: 0.0,
//                     backgroundColor: Colors.white,
//                     leading: (widget.enbaleBackArrow &&
//                             (widget.pageType != 13 && widget.pageType != 1))
//                         ? Container(
//                             child: IconButton(
//                               icon: Icon(
//                                 Icons.arrow_back_ios,
//                                 size: 25,
//                                 color: Colors.black,
//                               ),
//                               onPressed: () {
//                                 printUtil
//                                     .printMsg("Loaded URL ${widget.loadUrl}");
//                                 printUtil.printMsg("Current URL $currentUrl");
//                                 printUtil.printMsg("Inter URL $interUrl");
//                                 if (Platform.isIOS) {
//                                   // if (currentUrl == widget.loadUrl ||
//                                   //     currentUrl == Service.learnMoneyUrl ||
//                                   //     currentUrl ==
//                                   //         Service.addFamilyMemberUrl ||
//                                   //     currentUrl ==
//                                   //         Service.rewardsDashboardHybirdUrl ||
//                                   //     currentUrl == Service.ffcUrl ||
//                                   //     currentUrl == Service.ffcUrlBase ||
//                                   //     widget.pageType == 16 || widget.pageType == 14 ||
//                                   // currentUrl.contains("/Ffc/add_family_members_action")) {
//                                   //   handleBackAction();
//                                   // } else {

//                                   if (currentUrl == widget.loadUrl ||
//                                       currentUrl == Service.learnMoneyUrl ||
//                                       currentUrl ==
//                                           Service.addFamilyMemberUrl ||
//                                       currentUrl ==
//                                           Service.rewardsDashboardHybirdUrl ||
//                                       currentUrl == Service.ffcUrl ||
//                                       currentUrl == Service.ffcUrlBase ||
//                                       widget.pageType == 16 ||
//                                       widget.pageType == 14 ||
//                                       currentUrl == interUrl ||
//                                       currentUrl.contains(
//                                           "/Ffc/add_family_members_action")) {
//                                     handleBackAction();
//                                   } else {
//                                     flutterWebViewPlugin.canGoBack().then(
//                                       (isGoBack) {
//                                         if (isGoBack) {
//                                           flutterWebViewPlugin.goBack();
//                                           interUrl = currentUrl;
//                                         } else {
//                                           printUtil.printMsg(
//                                               "Came to handler back action");
//                                           handleBackAction();
//                                         }
//                                       },
//                                     );
//                                   }
//                                   // }
//                                 } else {
//                                   if (currentUrl == widget.loadUrl ||
//                                       currentUrl == Service.learnMoneyUrl ||
//                                       currentUrl ==
//                                           Service.addFamilyMemberUrl ||
//                                       currentUrl ==
//                                           Service.rewardsDashboardHybirdUrl ||
//                                       currentUrl == Service.ffcUrl ||
//                                       currentUrl == Service.ffcUrlBase ||
//                                       widget.pageType == 16 ||
//                                       widget.pageType == 14 ||
//                                       currentUrl.contains(
//                                           "/Ffc/add_family_members_action")) {
//                                     handleBackAction();
//                                   } else {
//                                     flutterWebViewPlugin.canGoBack().then(
//                                       (isGoBack) {
//                                         if (isGoBack) {
//                                           flutterWebViewPlugin.goBack();
//                                         } else {
//                                           printUtil.printMsg(
//                                               "Came to handler back action");
//                                           handleBackAction();
//                                         }
//                                       },
//                                     );
//                                   }
//                                 }
//                               },
//                             ),
//                           )
//                         : Container(),
//                     title: (widget.appTitle != null)
//                         ? widget.appTitle
//                         : Container(),
//                     centerTitle: widget.appTitleCenter,
//                   )
//                 : null,
//           ),
//         ),
//       ),
//     );
//   }
// }
