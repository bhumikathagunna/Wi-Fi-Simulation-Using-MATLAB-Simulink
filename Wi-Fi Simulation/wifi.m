% WiFi Network Simulation in MATLAB with Plotting

% Parameters
numDevices =100;      % Number of devices in the network
networkSize =100;    % Size of the network (in meters)
txPower = 20;         % Transmit power of devices (in dBm)
rxThreshold = -70;    % Received signal strength threshold (in dBm)
pathLossExponent = 2 % Path loss exponent
shadowingStdDev = 4 % Shadowing standard deviation (in dB)

% Generate random device locations
deviceLocations = networkSize * rand(numDevices, 2);

% Initialize counters
numSuccessfulConnections = 0;
numFailedConnections = 0;

% Create figure for network topology plot
figure;
hold on;

% Plot access point
plot(networkSize/2, networkSize/2, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
text(networkSize/2, networkSize/2, 'Access Point', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');

% Plot devices
for i = 1:numDevices
    plot(deviceLocations(i, 1), deviceLocations(i, 2), 'bo');
end

% Perform Monte Carlo simulation
for i = 1:numDevices
    % Calculate distance from device to access point
    distance = sqrt(sum((deviceLocations(i, :) - [networkSize/2, networkSize/2]).^2));
    
    % Calculate received signal strength
    pathLoss = 10 * pathLossExponent * log10(distance) + normrnd(0, shadowingStdDev);
    rss = txPower - pathLoss;
    
    % Check if device can connect to the network
    if rss >= rxThreshold
        plot([deviceLocations(i, 1), networkSize/2], [deviceLocations(i, 2), networkSize/2], 'g--');
        numSuccessfulConnections = numSuccessfulConnections + 1;
    else
        plot([deviceLocations(i, 1), networkSize/2], [deviceLocations(i, 2), networkSize/2], 'r--');
        numFailedConnections = numFailedConnections + 1;
    end
end

% Set plot properties
xlabel('X (m)');
ylabel('Y (m)');
title('WiFi Network Topology');
legend('Access Point', 'Devices', 'Successful Connections', 'Failed Connections', 'Location', 'best');
axis([0 networkSize 0 networkSize]);
grid on;
hold off;

% Calculate connection success rate
successRate = numSuccessfulConnections / numDevices * 100;

% Display results
fprintf('WiFi Network Simulation Results:\n');
fprintf('Number of devices: %d\n', numDevices);
fprintf('Network size: %d meters\n', networkSize);
fprintf('Transmit power: %d dBm\n', txPower);
fprintf('Received signal strength threshold: %d dBm\n', rxThreshold);
fprintf('Path loss exponent: %.2f\n', pathLossExponent);
fprintf('Shadowing standard deviation: %.2f dB\n', shadowingStdDev);
fprintf('Number of successful connections: %d\n', numSuccessfulConnections);
fprintf('Number of failed connections: %d\n', numFailedConnections);
fprintf('Success rate: %.2f%%\n', successRate);
