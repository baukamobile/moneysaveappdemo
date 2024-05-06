from django.http import HttpResponse
from django.http.response import JsonResponse

from rest_framework.views import APIView

from rest_framework.exceptions import AuthenticationFailed
from django.contrib import redirects
from moneyapp.settings import EMAIL_HOST_USER
from .serializers import UserSerializer, ExpenseSerializer, IncomeSerializer
from .models import User
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status, viewsets
import jwt, datetime
import logging
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view
from django.core.mail import EmailMessage
from django.conf import settings
from django.template.loader import render_to_string
from django.core.mail import send_mail
from django.shortcuts import redirect, render
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .serializers import ExpenseSerializer
# Create your views here.

class RegisterView(APIView):
    def post(self, request):
        # First, register the user
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()

        # Generate JWT tokens for the registered user
        refresh = RefreshToken.for_user(user)

        # Send email notification
        subject = 'Welcome to MoneyApp'
        message = 'Thank you for registering with MoneyApp. Enjoy our services!'
        sender = 'example@example.com'  # Update with your sender email
        recipient_list = [user.email]  # Assuming user has an email field

        try:
            send_mail(subject, message, sender, recipient_list)
            return Response({
                'message': 'User registered successfully. Email sent.',
                'access_token': str(refresh.access_token),
                'refresh_token': str(refresh)
            }, status=status.HTTP_201_CREATED)
        except Exception as e:
            # If email sending fails, delete the user and return an error
            user.delete()
            return Response(f"User registration failed. An error occurred: {str(e)}", status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    


class LoginView(APIView):
    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')

        if not email or not password:
            raise AuthenticationFailed('Please provide both email and password.')

        user = User.objects.filter(email=email).first()

        if user is None:
            raise AuthenticationFailed('User with this email does not exist.')

        if not authenticate(request, username=user.email, password=password):
            raise AuthenticationFailed('Incorrect password.')

        payload = {
            'id': user.id,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=60),
            'iat': datetime.datetime.utcnow()
        }

        token = jwt.encode(payload, 'secret', algorithm='HS256').encode('utf-8')

        response = Response()

        response.set_cookie(key='jwt', value=token, httponly=True)
        response.data = {
            'jwt': token
        }
        return response

from jwt.exceptions import InvalidTokenError, ExpiredSignatureError
import logging

logger = logging.getLogger(__name__)

class UserView(APIView):
    def get(self, request):
        token = request.COOKIES.get('jwt')

        if not token:
            raise AuthenticationFailed('Unauthenticated!')
        try:
            payload = jwt.decode(token, 'secret', algorithms=['HS256'])
            user = User.objects.filter(id=payload['id']).first()
            if not user:
                raise AuthenticationFailed('User not found.')
            serializer = UserSerializer(user)
            return Response(serializer.data)
        except ExpiredSignatureError:
            logger.error('Token has expired.')
            raise AuthenticationFailed('Token has expired.')
        except InvalidTokenError:
            logger.error('Invalid token.')
            raise AuthenticationFailed('Invalid token.')
        except Exception as e:
            logger.error('Error decoding token: %s', e)
            raise AuthenticationFailed('Error decoding token: {}'.format(str(e)))

class LogoutView(APIView):
    def post(self, request):
        response = Response()
        response.delete_cookie('jwt')
        response.data = {
            'message': 'success'
        }
        return response

# @api_view(['POST'])
# def add_expense(request):
#     serializer = ExpenseSerializer(data=request.data)
#     if serializer.is_valid():
#         serializer.save()
#         return Response(serializer.data, status=201)
#     return Response(serializer.errors, status=400)



@api_view(['POST'])
def add_expense(request):
    serializer = ExpenseSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=201)
    return Response(serializer.errors, status=400)

@api_view(['POST'])
def add_income(request):
    serializer = IncomeSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=201)
    return Response(serializer.errors, status=400)




# def send_email(request):
#     subject = 'Thank you for registering to our site'
#     message = ' it  means a world to us '
#     email_from = settings.EMAIL_HOST_USER
#     recipient_list = ['abylaikhanbariev7@gmail.com',]
#     send_mail( subject, message, email_from, recipient_list )
#     return redirect('template/base.html')

def first_page(request):
    return redirect(request, 'template/index.html')



# {
# "email": "iphone@gmail.com",
# "password": "iphone"

# }