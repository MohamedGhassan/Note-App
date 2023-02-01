

abstract class AppStates {}

class InitLogin extends AppStates {}

//class LoadingAppState extends AppStates {}
//class ScAppState extends AppStates {}
//class ErrorAppState extends AppStates {}

class ScCreateDB extends AppStates {}
class ScInitNots extends AppStates {}

class LoadingGetTasks extends AppStates {}
class ScGetTasks extends AppStates {}

class ScUpdateTask extends AppStates {}
class ScRemoveTask extends AppStates {}
class ScRemoveAllTask extends AppStates {}
class ScAddTask extends AppStates {}
class SaveAndDisplayNotification extends AppStates {}

class Mood extends AppStates {}
class ChangSelectedDate extends AppStates {}

