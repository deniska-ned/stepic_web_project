from django.http import HttpResponse

def test(request, *args, **kwargs):
    body = 'OK'
    if 'q_num' in kwargs:
        body += '; question number:  ' + kwargs['q_num']
    return HttpResponse(body)
