# Use an official Python runtime as a parent image
FROM python:3.7.3

# Set environment varibles
ENV PYTHONUNBUFFERED 1
ENV DJANGO_ENV dev

ADD ./requirements/ /code/requirements/
RUN pip install --upgrade pip
# Install any needed packages specified in requirements.txt
RUN pip install -r /code/requirements/testing.txt
RUN pip install gunicorn

# Copy the current directory contents into the container at /code/
COPY . /code/
# Set the working directory to /code/
WORKDIR /code/

#RUN python manage.py migrate

RUN useradd dunbar
RUN chown -R dunbar /code
USER dunbar

EXPOSE 8000
CMD exec gunicorn app.wsgi:application --bind 0.0.0.0:8000 --workers 3
