from django.urls import path, include
from .views import RegisterView, LoginView, UserView, LogoutView, add_expense, add_income


urlpatterns = [
    path('register/', RegisterView.as_view()),
    path('login/', LoginView.as_view()),
    path('user/', UserView.as_view()),
    path('logout/', LogoutView.as_view()),
    path('addexpenses/', add_expense),
    path('addincomes/', add_income)

]
