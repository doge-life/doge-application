|            |             |
------------ | -------------
Travis       | [![Travis](https://travis-ci.org/doge-life/doge-application.svg?branch=master)](https://travis-ci.org/doge-life/doge-application)
CircleCI     | [![CircleCI](https://circleci.com/gh/doge-life/doge-application.svg?style=svg)](https://circleci.com/gh/doge-life/doge-application)
Jenkins      | [![Jenkins](http://ec2-107-21-21-140.compute-1.amazonaws.com/buildStatus/icon?job=doge-life/doge-application/master)](http://ec2-107-21-21-140.compute-1.amazonaws.com/job/doge-life/job/doge-application/job/master/)

|            |             |
------------ | -------------
Code Climate GPA | [![Code Climate](https://codeclimate.com/github/doge-life/doge-application/badges/gpa.svg)](https://codeclimate.com/github/doge-life/doge-application)
Code Climate Coverage | [![Test Coverage](https://codeclimate.com/github/doge-life/doge-application/badges/coverage.svg)](https://codeclimate.com/github/doge-life/doge-application/coverage)
Code Climate Issues | [![Issue Count](https://codeclimate.com/github/doge-life/doge-application/badges/issue_count.svg)](https://codeclimate.com/github/doge-life/doge-application)

# doge-application
The Front-end application of Doge Life.

## Connecting to the proxy

If you are building a Docker image on the DogeData network, you will need to connect to a proxy. The packer build is looking for the following environment variables to be set:

```bash
export DOGE_PROXY_UNAME='domain\your%20username'
export DOGE_PROXY_PASSWORD='your%20password'
export DOGE_PROXY_HOST='l02piproxy01.corp.local'
export DOGE_PROXY_PORT='80'
```
