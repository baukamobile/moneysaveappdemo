from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from .serializers import UserSerializer, ExpenseSerializer, IncomeSerializer
from .models import User
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status
import jwt, datetime
import logging
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view


# Create your views here.
class RegisterView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()

        refresh = RefreshToken.for_user(user)

        return Response({
            'message': 'User registered successfully.',
            'access_token': str(refresh.access_token),
            'refresh_token': str(refresh)
        }, status=status.HTTP_201_CREATED)


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