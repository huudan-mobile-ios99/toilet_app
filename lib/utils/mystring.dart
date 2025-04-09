class MyString{
    static const int DEFAULTNUMBER = 111111;
    // static const String ADRESS_LOCAL = "localhost";
		// static const String ADRESS = "localhost";
		static const String ADRESS = "192.168.101.58";
		static const String PORT = "8095";
    static const String BASE = 'http://$ADRESS:$PORT';

    // //RENDER: vegas-toilet-app.onrender.com
    // static const CREATE_FEEDBACK = '$BASE/create_feedback';
    static const CREATE_FEEDBACK_STATUS = '$BASE/create_feedback_status';
    static const LIST_FEEDBACK = '$BASE/list_feedback';
    static const CREATE_NOTI_ALL = '$BASE/firebase/notification/all';
    static const CREATE_NOTI = '$BASE/firebase/notification';
    static const CREATE_FEEDBACK = '$BASE/create_feedback';



     static const LIST_USER= '$BASE/user/list';
     static const CREATE_USER= '$BASE/user/register';
     static const DELETE_USER= '$BASE/user/delete/';
     static const UPDATE_USER= '$BASE/user/update/';
     static const CREATE_CHECKLIST= '$BASE/checklist/create';

     static const String FIREBASE_APP_NAME = 'toilet-info';
     static const String FIREBASE_apiKey = 'AIzaSyARXFEMkzz6ceCPlXlg7jgeetMMRwE2CC8';
     static const String FIREBASE_appId = '1:327707788242:web:450f3d8c3e24c34b91be0b';

     static const String FIREBASE_messagingSenderId = '551431577143';
     static const String FIREBASE_projectId = 'toilet-info-8cc33';
     static const String FIREBASE_url = 'https://toilet-info-8cc33-default-rtdb.asia-southeast1.firebasedatabase.app';

}
