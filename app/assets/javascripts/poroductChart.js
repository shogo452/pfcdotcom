$(function () {
  var ctx = document.getElementById("myChart");
  var myChart = new Chart(ctx, {
    type: 'radar',
    data: {
      labels: ['タンパク質', '脂質', '炭水化物'],
      datasets: [{
        label: 'マクロ栄養素',
        data: gon.nutrition,
        // 塗りつぶしの色
        backgroundColor: "rgba(248,184,98,0.5)",
        // 線の色
        borderColor: "rgba(240,131,0,1)",
        // 線の幅
        borderWidth: 2,
        pointBackgroundColor: "rgba(240,131,0,1)",
        pointStyle: "circle",
      }]
    },
    options: {
      legend: {
        labels: {
          fontSize: 15,
        }
      },
      tooltips: {
        titleFontSize: 12,
      },
      scale: {
        pointLabels: {
          display: true,
          fontSize: 15,
          fontColor: "rgba(0,0,0,1)",
        }
      }
    }
  });
});