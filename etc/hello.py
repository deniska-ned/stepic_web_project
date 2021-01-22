def wsgi_appication(environ, start_response):
    status = "200 OK"

    headers = [
        ("Content-Type", "text/plain")
    ]

    body = (bytes(variable + "\n")
            for variable in environ["QUERY_STRING"].split('&'))

    start_response(status, headers)

    return body
