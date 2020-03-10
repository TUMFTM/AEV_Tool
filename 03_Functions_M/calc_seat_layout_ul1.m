% Function for calculating seating configuration parameters and layput UL1

function [n_ul1_rear, n_ul1_window, n_ul1_door, n_ul1_passenger, n_ul1_seats, n_ul1_standing, per_ul1_sitting, per_ul1_standing, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front] = calc_seat_layout_ul1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth)

global path_base

%% Space calculation

% Area Bus including body thickness and 50 curvature distance between body and seat
a_bus = (l_overall - t_body - 50) * (w_overall - t_body - 50);

% Area Wheelhouses
a_wheelhouse = (wb + (d_tire * 2/3) * (t_body + w_tire + d_spring + 50));

% Area Seat
a_seat = (l_seat + t_seat + l_leg_clearance) * (w_seat + (2* w_seat_gap));

% Area for standing passenger
a_passenger = p_shoulder_width * p_body_depth;

% Dead area behind front and rear seats because of curved body height
a_dead_zone = (w_overall - 2*(t_body + w_tire + d_spring + 50)) * ((l_seat/2) + t_seat);

%% Automatic Interior Urban Layout 1 Calculation

% Calculation of potential seating area dimension
l_ul1_window = l_overall - 2*(wb + (d_tire * 2/3));              % Distance between front and rear wheelhouse
l_ul1_door = (l_overall - w_door - (2* wb) - (d_tire * 4/3))/2;  % Distance between front and rear wheelhouse and door
l_ul1_rear = w_overall - 2*(t_body + w_tire + d_spring + 50);    % Distance between left and right wheelhouse, 50 is distance between tire and air spring

% Number of seats UL1, floor = round down to get integer
n_ul1_window = floor(l_ul1_window / (w_seat + (2* w_seat_gap)));  % Calculating number of seats window row in UL1
n_ul1_door = floor(l_ul1_door / (w_seat + (2* w_seat_gap)));      % Calculating number of seats door row in UL1
n_ul1_rear = floor(l_ul1_rear / (w_seat + (2* w_seat_gap)));      % Calculating number of seats front and rear row in UL1
n_ul1_seats = n_ul1_window + 2 * n_ul1_door + 2 * n_ul1_rear;     % Calculating total number of seats in UL1

% Rest Gap Division UL1, modulus to get rest value
w_rest_gap_window_ul1 = mod(l_ul1_window, (n_ul1_window * (w_seat + (2* w_seat_gap))));
w_rest_gap_door_ul1 = mod(l_ul1_door, (n_ul1_door * (w_seat + (2* w_seat_gap))));
w_rest_gap_rear_ul1 = mod(l_ul1_rear, (n_ul1_rear * (w_seat + (2* w_seat_gap))));

% Calculating dead zone area from rest gaps in UL1
a_ul1_rest = (l_seat + t_seat) * (w_rest_gap_window_ul1 + w_rest_gap_door_ul1 + w_rest_gap_rear_ul1);

% Calculating standing area for passenger in UL1
a_ul1_standing = a_bus - ((4 * a_wheelhouse) + (n_ul1_seats * a_seat) + (2 * a_dead_zone) + a_ul1_rest);

% Calculating number of standing people in UL1
n_ul1_standing = floor(a_ul1_standing / a_passenger);

% Calculating number of passenber
n_ul1_passenger = n_ul1_seats + n_ul1_standing;

% Calculating sitting to standing ratio in UL1
per_ul1_sitting = round(n_ul1_seats / n_ul1_passenger *100);
per_ul1_standing = round(n_ul1_standing /n_ul1_passenger * 100);

%% Avoid that CAD pattern for rear,front and door seat assembly contains a number 1 and 0 (otherwise this will cause trouble shout)
% Front and rear seat
if n_ul1_rear >= 2
    seat_ul1_front = 'true';
    seat_ul1_rear = 'true';
    pattern_seat_ul1_front = 'true';
    pattern_seat_ul1_rear = 'true';
    
elseif n_ul1_rear == 1
    seat_ul1_front = 'true';
    seat_ul1_rear = 'true';
    pattern_seat_ul1_front = 'false';
    pattern_seat_ul1_rear = 'false';
    
elseif n_ul1_rear == 0
    seat_ul1_front = 'false';
    seat_ul1_rear = 'false';
    pattern_seat_ul1_front = 'false';
    pattern_seat_ul1_rear = 'false';
    
end

% Door Seats
if n_ul1_door >= 2
    seat_ul1_door_front = 'true';
    seat_ul1_door_rear = 'true';
    pattern_seat_ul1_door_front = 'true';
    pattern_seat_ul1_door_rear = 'true';
    
elseif n_ul1_door == 1
    seat_ul1_door_front = 'true';
    seat_ul1_door_rear = 'true';
    pattern_seat_ul1_door_front = 'false';
    pattern_seat_ul1_door_rear = 'false';
    
elseif n_ul1_door == 0
    seat_ul1_door_front = 'false';
    seat_ul1_door_rear = 'false';
    pattern_seat_ul1_door_front = 'false';
    pattern_seat_ul1_door_rear = 'false';
    
end

%Save data for concept vizualization in txt file
check = 'ma';
save([path_base '10_Results\Components\Selection.mat'], 'l_overall', 'w_overall', 'h_overall', 'gc', 'wheelbase', 'h_lift', 'n_ul1_passenger', 'n_ul1_seats', 'n_ul1_standing', 'per_ul1_sitting', 'per_ul1_standing','check');

end