from django.db import models
from django.contrib.auth.models import User


class QuestionManager(models.Manager):
    def new(self):
        return self.order_by('-added_at')
    def popular(self):
        return self.ordered_by('-rating')


class Question(models.Model):
    title = models.CharFiled(max_length=255)
    text = models.TextFiled()
    added_at = models.DateTimeField(auto_now_add=True)
    rating = models.IntegerField(default=0)
    author = models.ForeignKey(User, null=True, on_delete=models.SET_NULL)
    likes = models.ManyToManyField(User, null=True, on_delete=models.SET_NULL)

    objects = QuestionManager()


class Answer(models.Model):
    text = models.TextField()
    added_at = models.DateTimeField(auto_now_add=True)
    question = models.ForeignKey(Question, null=False,
            on_delete=models.SET_CASCADE)
    author = models.ForeignKey(User, null=True, on_delete=models.SET_NULL)
