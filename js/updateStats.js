let arrCPU = [];
let arrRAM = [];
let arrTime = [];
let chartCPU, chartRAM;
const CHART_VALUES = 20;
const UPDATE_TIME = 1000; //in ms

(function ($) {
    for(let i = 0; i < CHART_VALUES; i++){
        arrCPU.push(0.00);
        arrRAM.push(0.00);
    }

    let ctx = $("#cpu-usage").get(0).getContext("2d");
    chartCPU = new Chart(ctx, {
        type: "line",
        data: {
            labels: arrTime,
            datasets: [{
                label: "CPU Usage",
                data: arrCPU,
                backgroundColor: "rgba(235, 22, 22, .7)",
                fill: true
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    //max: 100,
                    //min: 0
                }
            }
        }
    });

    let ctz = $("#ram-usage").get(0).getContext("2d");
    chartRAM = new Chart(ctz, {
        type: "line",
        data: {
            labels: arrTime,
            datasets: [{
                label: "RAM Usage",
                data: arrRAM,
                backgroundColor: "rgba(235, 22, 22, .7)",
                fill: true
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    //max: 100,
                    //min: 0
                }
            }
        }
    });


    updateStats();
    setInterval(updateStats, UPDATE_TIME);
})(jQuery);


function updateStats(){
    fetch("/cgi-bin/stats.sh", {
        method: 'POST'
    })
        .then((response) => response.text())
        .then((data) => {
            //0 CPU usage, 1 MEM usage, 2 Num of Cores, 3 Total RAM, 4 Disk Used, 5 Total Disk
            let arr = data.split("\n");
            $("#cores").text(arr[2] + " Cores");
            $("#ram").text(arr[3] + " GB");
            $("#disk").text(arr[4] + "/" + arr[5] + " GB");
            $("#uptime").text(arr[6]);
            for(let i = 7; i < 17; i++){ //From lines 7 to 16, last server logins
                console.log(arr[i]);
            }

            arrCPU.pop();
            arrCPU.unshift(arr[0]); //Add element to the start

            arrRAM.pop();
            arrRAM.unshift(arr[1]);

            arrTime = [];
            let d = new Date();
            for(let i = 0; i < CHART_VALUES; i++) arrTime.push(d.getHours() + ":" + d.getMinutes() + ":" + (d.getSeconds()+i));

            chartCPU.data.labels = arrTime;
            chartCPU.data.datasets[0].data = arrCPU;
            chartCPU.update();

            chartRAM.data.labels = arrTime;
            chartRAM.data.datasets[0].data = arrRAM;
            chartRAM.update();
        });
}
