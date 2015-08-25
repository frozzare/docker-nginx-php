# docker-nginx-php

A Docker image to serve PHP 5.6 applications

# Example

```
$ docker run -d -p 80:80 frozzare/nginx-php
```

Go to [http://localhost](http://localhost)

# Loading your custom PHP application

```
FROM frozzare/nginx-php
```

After that, build the new `Dockerfile`:

```
docker build -t username/my-php-app .
```

And test it:

```
docker run -d -p 80:80 username/my-php-app
```

Go to [http://localhost](http://localhost)

# License

MIT © [Fredrik Forsmo](https://github.com/frozzare)
