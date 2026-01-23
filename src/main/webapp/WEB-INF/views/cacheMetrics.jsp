<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cache Performance Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            min-height: 100vh;
            padding: 20px;
            color: #fff;
        }
        .dashboard {
            max-width: 1400px;
            margin: 0 auto;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header h1 {
            font-size: 2.5rem;
            background: linear-gradient(90deg, #00d2ff, #3a7bd5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }
        .header .current-cache {
            font-size: 1.2rem;
            color: #888;
        }
        .header .current-cache span {
            color: #00d2ff;
            font-weight: bold;
        }
        .controls {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(90deg, #00d2ff, #3a7bd5);
            color: #fff;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0, 210, 255, 0.4);
        }
        .btn-danger {
            background: linear-gradient(90deg, #ff416c, #ff4b2b);
            color: #fff;
        }
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255, 65, 108, 0.4);
        }
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 25px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .card h3 {
            font-size: 1rem;
            color: #888;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .card .value {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .card .value.redis { color: #ff6384; }
        .card .value.caffeine { color: #36a2eb; }
        .card .value.nocache { color: #ffce56; }
        .card .value.improvement { color: #4bc0c0; }
        .card .sub-value {
            font-size: 0.9rem;
            color: #666;
        }
        .charts {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .chart-container {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 25px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .chart-container h3 {
            margin-bottom: 20px;
            color: #fff;
        }
        .logs-container {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 25px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            max-height: 400px;
            overflow-y: auto;
        }
        .logs-container h3 {
            margin-bottom: 20px;
            color: #fff;
        }
        .log-item {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .log-item:last-child {
            border-bottom: none;
        }
        .log-cache-type {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
        }
        .log-cache-type.redis { background: rgba(255, 99, 132, 0.3); color: #ff6384; }
        .log-cache-type.caffeine { background: rgba(54, 162, 235, 0.3); color: #36a2eb; }
        .log-cache-type.nocache { background: rgba(255, 206, 86, 0.3); color: #ffce56; }
        .hit { color: #4bc0c0; }
        .miss { color: #ff6384; }
        .benchmark-result {
            background: rgba(75, 192, 192, 0.1);
            border: 1px solid rgba(75, 192, 192, 0.3);
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 30px;
            display: none;
        }
        .benchmark-result h3 {
            color: #4bc0c0;
            margin-bottom: 15px;
        }
        .benchmark-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        .benchmark-item {
            text-align: center;
        }
        .benchmark-item .label {
            color: #888;
            margin-bottom: 5px;
        }
        .benchmark-item .value {
            font-size: 1.8rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <div class="header">
            <h1>Cache Performance Dashboard</h1>
            <p class="current-cache">Current Cache Type: <span>${currentCacheType}</span></p>
        </div>

        <div class="controls">
            <button class="btn btn-primary" onclick="runBenchmark()">Run Benchmark</button>
            <button class="btn btn-primary" onclick="refreshMetrics()">Refresh Metrics</button>
            <button class="btn btn-danger" onclick="resetMetrics()">Reset All</button>
        </div>

        <div class="benchmark-result" id="benchmarkResult">
            <h3>Benchmark Result</h3>
            <div class="benchmark-grid">
                <div class="benchmark-item">
                    <div class="label">No Cache (DB Direct)</div>
                    <div class="value nocache" id="benchNoCacheAvg">-</div>
                </div>
                <div class="benchmark-item">
                    <div class="label">With Cache</div>
                    <div class="value caffeine" id="benchCacheAvg">-</div>
                </div>
                <div class="benchmark-item">
                    <div class="label">Improvement</div>
                    <div class="value improvement" id="benchImprovement">-</div>
                </div>
            </div>
        </div>

        <div class="cards">
            <div class="card">
                <h3>Redis Cache</h3>
                <div class="value redis" id="redisAvg">0ms</div>
                <div class="sub-value">Avg Response Time</div>
                <div class="sub-value" style="margin-top: 10px;">
                    Hit Rate: <span id="redisHitRate">0%</span> |
                    Requests: <span id="redisRequests">0</span>
                </div>
            </div>
            <div class="card">
                <h3>Caffeine (Local)</h3>
                <div class="value caffeine" id="caffeineAvg">0ms</div>
                <div class="sub-value">Avg Response Time</div>
                <div class="sub-value" style="margin-top: 10px;">
                    Hit Rate: <span id="caffeineHitRate">0%</span> |
                    Requests: <span id="caffeineRequests">0</span>
                </div>
            </div>
            <div class="card">
                <h3>No Cache (DB Direct)</h3>
                <div class="value nocache" id="noCacheAvg">0ms</div>
                <div class="sub-value">Avg Response Time</div>
                <div class="sub-value" style="margin-top: 10px;">
                    Requests: <span id="noCacheRequests">0</span>
                </div>
            </div>
            <div class="card">
                <h3>Performance Improvement</h3>
                <div class="value improvement" id="improvement">0%</div>
                <div class="sub-value">vs No Cache</div>
                <div class="sub-value" style="margin-top: 10px;">
                    Caffeine faster than Redis: <span id="caffeineFaster">0%</span>
                </div>
            </div>
        </div>

        <div class="charts">
            <div class="chart-container">
                <h3>Response Time Comparison (Bar)</h3>
                <canvas id="barChart"></canvas>
            </div>
            <div class="chart-container">
                <h3>Response Time Trend (Line)</h3>
                <canvas id="lineChart"></canvas>
            </div>
        </div>

        <div class="charts">
            <div class="chart-container">
                <h3>Cache Hit Rate</h3>
                <canvas id="hitRateChart"></canvas>
            </div>
            <div class="chart-container">
                <h3>Request Distribution</h3>
                <canvas id="pieChart"></canvas>
            </div>
        </div>

        <div class="logs-container">
            <h3>Recent Requests</h3>
            <div id="logsContent">
                <p style="color: #666;">No logs yet. Run some requests to see data.</p>
            </div>
        </div>
    </div>

    <script>
        let barChart, lineChart, hitRateChart, pieChart;

        // 차트 초기화
        function initCharts() {
            const barCtx = document.getElementById('barChart').getContext('2d');
            barChart = new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: ['Redis', 'Caffeine', 'No Cache'],
                    datasets: [{
                        label: 'Avg Response Time (ms)',
                        data: [0, 0, 0],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)'
                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#888' }
                        },
                        x: {
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#888' }
                        }
                    },
                    plugins: {
                        legend: { labels: { color: '#888' } }
                    }
                }
            });

            const lineCtx = document.getElementById('lineChart').getContext('2d');
            lineChart = new Chart(lineCtx, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [
                        {
                            label: 'Redis',
                            data: [],
                            borderColor: 'rgba(255, 99, 132, 1)',
                            backgroundColor: 'rgba(255, 99, 132, 0.1)',
                            fill: true,
                            tension: 0.4
                        },
                        {
                            label: 'Caffeine',
                            data: [],
                            borderColor: 'rgba(54, 162, 235, 1)',
                            backgroundColor: 'rgba(54, 162, 235, 0.1)',
                            fill: true,
                            tension: 0.4
                        },
                        {
                            label: 'No Cache',
                            data: [],
                            borderColor: 'rgba(255, 206, 86, 1)',
                            backgroundColor: 'rgba(255, 206, 86, 0.1)',
                            fill: true,
                            tension: 0.4
                        }
                    ]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#888' }
                        },
                        x: {
                            grid: { color: 'rgba(255, 255, 255, 0.1)' },
                            ticks: { color: '#888' }
                        }
                    },
                    plugins: {
                        legend: { labels: { color: '#888' } }
                    }
                }
            });

            const hitRateCtx = document.getElementById('hitRateChart').getContext('2d');
            hitRateChart = new Chart(hitRateCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Redis Hit', 'Redis Miss', 'Caffeine Hit', 'Caffeine Miss'],
                    datasets: [{
                        data: [0, 0, 0, 0],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(255, 99, 132, 0.3)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(54, 162, 235, 0.3)'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: { color: '#888' }
                        }
                    }
                }
            });

            const pieCtx = document.getElementById('pieChart').getContext('2d');
            pieChart = new Chart(pieCtx, {
                type: 'pie',
                data: {
                    labels: ['Redis', 'Caffeine', 'No Cache'],
                    datasets: [{
                        data: [0, 0, 0],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: { color: '#888' }
                        }
                    }
                }
            });
        }

        // 메트릭 데이터 가져오기
        async function refreshMetrics() {
            try {
                const response = await fetch('/api/cache/metrics');
                const data = await response.json();

                // 카드 업데이트
                document.getElementById('redisAvg').textContent = data.redis.avgResponseTime + 'ms';
                document.getElementById('redisHitRate').textContent = data.redis.hitRate.toFixed(1) + '%';
                document.getElementById('redisRequests').textContent = data.redis.totalRequests;

                document.getElementById('caffeineAvg').textContent = data.caffeine.avgResponseTime + 'ms';
                document.getElementById('caffeineHitRate').textContent = data.caffeine.hitRate.toFixed(1) + '%';
                document.getElementById('caffeineRequests').textContent = data.caffeine.totalRequests;

                document.getElementById('noCacheAvg').textContent = data.noCache.avgResponseTime + 'ms';
                document.getElementById('noCacheRequests').textContent = data.noCache.totalRequests;

                if (data.comparison.redisImprovement) {
                    document.getElementById('improvement').textContent = data.comparison.redisImprovement.toFixed(1) + '%';
                }
                if (data.comparison.caffeineFasterThanRedis) {
                    document.getElementById('caffeineFaster').textContent = data.comparison.caffeineFasterThanRedis.toFixed(1) + '%';
                }

                // 바 차트 업데이트
                barChart.data.datasets[0].data = [
                    data.redis.avgResponseTime,
                    data.caffeine.avgResponseTime,
                    data.noCache.avgResponseTime
                ];
                barChart.update();

                // 파이 차트 업데이트
                pieChart.data.datasets[0].data = [
                    data.redis.totalRequests,
                    data.caffeine.totalRequests,
                    data.noCache.totalRequests
                ];
                pieChart.update();

                // 히트율 차트 업데이트
                hitRateChart.data.datasets[0].data = [
                    data.redis.cacheHits,
                    data.redis.totalRequests - data.redis.cacheHits,
                    data.caffeine.cacheHits,
                    data.caffeine.totalRequests - data.caffeine.cacheHits
                ];
                hitRateChart.update();

                // 시계열 데이터 가져오기
                const timeResponse = await fetch('/api/cache/timeseries');
                const timeData = await timeResponse.json();

                const maxLen = Math.max(
                    timeData.redis.length,
                    timeData.caffeine.length,
                    timeData.noCache.length
                );
                const labels = Array.from({length: maxLen}, (_, i) => i + 1);

                lineChart.data.labels = labels;
                lineChart.data.datasets[0].data = timeData.redis;
                lineChart.data.datasets[1].data = timeData.caffeine;
                lineChart.data.datasets[2].data = timeData.noCache;
                lineChart.update();

                // 로그 가져오기
                const logsResponse = await fetch('/api/cache/logs');
                const logs = await logsResponse.json();
                updateLogs(logs);

            } catch (error) {
                console.error('Failed to fetch metrics:', error);
            }
        }

        // 로그 업데이트
        function updateLogs(logs) {
            const container = document.getElementById('logsContent');
            if (logs.length === 0) {
                container.innerHTML = '<p style="color: #666;">No logs yet.</p>';
                return;
            }

            const html = logs.slice(-20).reverse().map(log => {
                const time = new Date(log.timestamp).toLocaleTimeString();
                return '<div class="log-item">' +
                    '<span class="log-cache-type ' + log.cacheType + '">' + log.cacheType.toUpperCase() + '</span>' +
                    '<span>' + log.methodName + '</span>' +
                    '<span>' + log.responseTime + 'ms</span>' +
                    '<span class="' + (log.cacheHit ? 'hit' : 'miss') + '">' +
                        (log.cacheHit ? 'HIT' : 'MISS') + '</span>' +
                    '<span style="color: #666;">' + time + '</span>' +
                '</div>';
            }).join('');

            container.innerHTML = html;
        }

        // 벤치마크 실행
        async function runBenchmark() {
            try {
                const response = await fetch('/api/cache/benchmark', { method: 'POST' });
                const data = await response.json();

                document.getElementById('benchNoCacheAvg').textContent = data.noCacheAvg + 'ms';
                document.getElementById('benchCacheAvg').textContent = data.cacheAvg + 'ms';
                document.getElementById('benchImprovement').textContent = data.improvement.toFixed(1) + '%';

                document.getElementById('benchmarkResult').style.display = 'block';

                refreshMetrics();
            } catch (error) {
                console.error('Benchmark failed:', error);
            }
        }

        // 메트릭 초기화
        async function resetMetrics() {
            if (!confirm('Reset all metrics?')) return;

            try {
                await fetch('/api/cache/reset', { method: 'POST' });
                refreshMetrics();
                document.getElementById('benchmarkResult').style.display = 'none';
            } catch (error) {
                console.error('Reset failed:', error);
            }
        }

        // 초기화
        document.addEventListener('DOMContentLoaded', function() {
            initCharts();
            refreshMetrics();
            setInterval(refreshMetrics, 5000); // 5초마다 자동 새로고침
        });
    </script>
</body>
</html>
