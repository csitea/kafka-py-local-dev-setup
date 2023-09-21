from django import forms

class TheForm(forms.Form):
    topic = forms.CharField(max_length=50)
    name = forms.CharField(max_length=50)
    age = forms.IntegerField()
