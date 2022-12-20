"use strict";

function login(){
    $('#signInBtn').prop('disabled', true);

    fetch("/cgi-bin/login.sh", {
        method: 'POST',
        body: $('#floatingInput').val() + '&' + $('#floatingPassword').val()
    })
        .then((response) => response.text())
        .then((data) => {
            $('#signInBtn').prop('disabled', false);
            if(data.startsWith("/")){
                window.location.href = data;
            }
            else{
                $('#error-text').addClass('alert alert-danger');
                $('#error-text').text(data);
            }
        });
}

function shutdown(){
    fetch("/cgi-bin/shutdown.sh", {
        method: 'POST',
        body: "shutdown"
    }).then(r => {
        insertModal("Server Shutdown", "The server has been shut down successfully.");
    });
}

function restart(){
    fetch("/cgi-bin/shutdown.sh", {
        method: 'POST',
        body: "restart"
    }).then(r => {
        insertModal("Server Restart", "The server has been restarted successfully.");
    });
}

function showProcesses(){
    fetch("/cgi-bin/processes.sh", {
        method: 'POST',
    })
        .then((response) => response.text())
        .then((data) => {
            let arr = data.split("\n");
            for(let i = 0; i < arr.length-2; i++) {
                let element = arr[i].split(' ');
                let html = `
                    <tr>
                        <td>${element[1]}</td>
                        <td>${element[0]}</td>
                        <td>${element[2]}%</td>
                        <td>${element[3]}%</td>
                        <td>${element[4]}</td>
                        <td>${element[5]}</td>
                        <td>${element[7]}</td>
                        <td>${element[8]}</td>
                        <td>${element[10]}</td>
                        <td><div class="input-group mb-2 mt-2">
                            <input id="${element[1]}" type="number" class="form-control" placeholder="Stop X Seconds" aria-label="Seconds" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                            <button onclick="stopProcess(${element[1]})" class="btn btn-primary" type="button">Stop</button>
                            </div>
                        </td>
                        <td>
                            <button onclick="killProcess(${element[1]})" class="btn btn-outline-primary" type="button">Kill ${element[1]}</button>
                        </td>
                    </tr>`;
                $('#process-holder').append(html);
            }
        });
}

function stopProcess(pid){
    let id = "#" + pid;
    let seconds = $(id).val();
    fetch("/cgi-bin/processes.sh", {
        method: 'POST',
        body: pid + '&' + seconds
    });

    insertModal("Process Stopped", "The process with PID " + pid + " has been stopped for " + seconds + " seconds.");
}

function killProcess(pid){
    fetch("/cgi-bin/processes.sh", {
        method: 'POST',
        body: pid + '&kill'
    });

    insertModal("Process Killed", "The process with PID " + pid + " has been killed.");
    setTimeout(() => {location.reload()}, 1000);
}


function showCronTasks(){
    fetch("/cgi-bin/cron.sh", {
        method: 'POST',
    })
        .then((response) => response.text())
        .then((data) => {
            console.log(data);
            let arr = data.split("\n");
            for(let i = 0; i < arr.length-1; i++) {
                let element = arr[i].split(' ');
                let html = `
                    <tr>
                        <td>${element[0]}</td>
                        <td>${element[1]}</td>
                        <td>${element[2]}</td>
                        <td>${element[3]}</td>
                        <td>${element[4]}</td>
                        <td>${element[5]}</td>
                        <td>
                            <button onclick="deleteCronTask(${i+1})" class="btn btn-primary" type="button">Delete</button>
                        </td>
                    </tr>`;
                $('#process-holder').append(html);
            }
        });
}

function addCronTask(){
    let task = $("#minute").val() + " " + $("#hour").val() + " " + $("#dom").val() + " " +$("#month").val() + " " + $("#dow").val() + " " + $("#script").val();

    fetch("/cgi-bin/cron.sh", {
        method: 'POST',
        body: "add&" + task
    });

    insertModal("Cron Task Added", "The task" + task + " has been added to cron.");
    setTimeout(() => {location.reload()}, 1000);
}

function deleteCronTask(taskNum){
    fetch("/cgi-bin/cron.sh", {
        method: 'POST',
        body: "rm&" + taskNum
    });

    insertModal("Cron Task Removed", "The task has been deleted from cron.");
    setTimeout(() => {location.reload()}, 1000);
}


function insertModal(title, message){
    $('#modal').modal('hide');
    $('#modal-title').text(title);
    $('#modal-content').text(message);
    $('#modal').modal('show');
}


(function ($) {
    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner();
    
    
    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });


    // Sidebar Toggler
    $('.sidebar-toggler').click(function () {
        $('.sidebar, .content').toggleClass("open");
        return false;
    });


    // Progress Bar
    $('.pg-bar').waypoint(function () {
        $('.progress .progress-bar').each(function () {
            $(this).css("width", $(this).attr("aria-valuenow") + '%');
        });
    }, {offset: '80%'});


    // Calender
    $('#calender').datetimepicker({
        inline: true,
        format: 'L'
    });


    // Testimonials carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        items: 1,
        dots: true,
        loop: true,
        nav : false
    });


    // Chart Global Color
    Chart.defaults.color = "#6C7293";
    Chart.defaults.borderColor = "#000000";
})(jQuery);

