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
        backgroundColor: "rgba(25, 25, 112, 0.5)",
        // 線の色
        borderColor: "rgba(25, 25, 112)",
        // 線の幅
        borderWidth: 2,
        pointBackgroundColor: "rgba(25, 25, 112)",
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
          fontColor: "rgba(25, 25, 112, 0.5)",
        }
      }
    }
  });
});