<p align="center" style="margin-top: 50px">
  <img src="img/linux-logo.png" alt="Linux Logo" height="200">
</p>

<h1 align="center">Linux Web Controller</h1>

<p align="center">
  <a href="https://en.wikipedia.org/wiki/Bash_(Unix_shell)">
    <img src="https://img.shields.io/badge/shell-scripting-red">
  </a>
  <a href="https://github.com/bielcarpi/linux-web-controller">
    <img src="https://img.shields.io/badge/Development Stage-blue.svg">
  </a>
    <a href="https://opensource.org/licenses/BSD-3-Clause">
    <img src="https://img.shields.io/badge/Open%20Source-%E2%9D%A4-brightgreen.svg">
  </a>
</p>

<p align="center">
    Control your Linux OS from the web with Linux Web Controller (using Apache in your machine). 
    It allows you to see CPU and MEM usage, create cron tasks, see processes running, shutdown the machine, etc.
</p>

## Screenshots

### Login
![Login](img/login.png)

### Dashboard - Monitor your system
![Dashboard](img/dashboard.png)

### Control Processes
![Processes](img/processes.png)

### Set Up Cron Tasks
![Cron](img/cron.png)

### Automount USB Devices with Music
![Music](img/music.png)

## How To Use
```bash
# Install & Configure Apache on your Linux distro

# Clone this project inside the directory where you'll serve from Apache
$ git clone https://github.com/bielcarpi/linux-web-controller.git

# Configure Apache for executing cgi/sh scripts in the directory cgi-bin

# Start Apache and control your system from the Web
```

## Authors
Guillem Godoy (guillem.godoy@students.salle.url.edu)
<br>
Biel Carpi (biel.carpi@students.salle.url.edu)