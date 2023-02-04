abstract class AppStates {}

class AppInitState extends AppStates {}
class CreateOrderLoadingState extends AppStates {}

class CreateOrderSuccessState extends AppStates {}

class CreateOrderErrorState extends AppStates {}
class GetNotificationErrorState extends AppStates {}
class GetNotificationSuccessState extends AppStates {}
class GetNotificationLoadingState extends AppStates {}
class GetAllOrdersErrorState extends AppStates {}
class GetAllOrdersSuccessState extends AppStates {}
class GetAllOrdersLoadingState extends AppStates {}
class UpdateOrderErrorState extends AppStates {}
class UpdateOrderSuccessState extends AppStates {}
class UpdateOrderLoadingState extends AppStates {}
