# tasks.py

from celery import shared_task
from django.core.mail import send_mail

@shared_task
def send_message_1():
    subject = 'Message 1'
    message = 'This is message 1'
    sender = 'example@example.com'
    recipient_list = ['recipient@example.com']
    send_mail(subject, message, sender, recipient_list)

@shared_task
def send_message_2():
    subject = 'Message 2'
    message = 'This is message 2'
    sender = 'example@example.com'
    recipient_list = ['recipient@example.com']
    send_mail(subject, message, sender, recipient_list)

# Define more tasks for other messages similarly...
