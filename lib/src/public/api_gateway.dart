class ApiGateway {
  // Authentication
  static const LOGIN = 'api/authentication/login';
  static const REGISTER = 'api/authentication/register';

  // User
  static const USER = 'api/user';
  static const GET_INFO = 'api/user/info';
  static const UPDATE_AVATAR = 'api/user/avatar';

  // Upload File
  static const UPLOAD_SINGLE_FILE = 'api/up-load-file/upload';
  static const UPLOAD_MULTIPLE_FILE = 'api/up-load-file/uploads';
  static const GET_FILE_INFO = 'api/up-load-file';

  // Class
  static const CLASS = 'api/classes';
  static const RECOMMEND_CLASSES = 'api/classes/recommendClasses';
  static const JOIN_CLASS = 'api/classes/joinMember';
  static const LEAVE_CLASS = 'api/classes/leaveClass';

  // Exam
  static const SET_OF_QUESTIONS = 'api/set-of-questions';

  // Question
  static const QUESTION = 'api/question';

  // Road Map
  static const ROAD_MAP = 'api/road-map';
}
