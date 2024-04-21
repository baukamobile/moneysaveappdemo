from django.urls import path, include
from .views import RegisterView, LoginView,sendEmail, UserView, LogoutView, add_expense, add_income


urlpatterns = [
    path('register/', RegisterView.as_view()),
    path('login/', LoginView.as_view()),
    path('user/', UserView.as_view()),
    path('logout/', LogoutView.as_view()),
    path('add_expenses/', add_expense),
    path('add_incomes/', add_income),
    path('send_email/',sendEmail, name='send_email' )

]
