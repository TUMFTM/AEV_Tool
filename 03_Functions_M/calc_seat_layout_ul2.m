% Function for calculating seating configuration parameters and layput UL2

function [n_ul2_rear, n_ul2_window, n_ul2_door, n_ul2_passenger, n_ul2_seats, n_ul2_standing, per_ul2_sitting, per_ul2_standing, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2,  seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear] = calc_seat_layout_ul2 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth)

global path_base

%% Space calculation

% Area Bus including body thickness and 50 curvature distance between body and seat
a_bus = (l_overall - t_body - 50) * (w_overall - t_body - 50);

% Area Seat
a_seat = (l_seat + t_seat + l_leg_clearance) * (w_seat + (2* w_seat_gap));

% Area for standing passenger
a_passenger = p_shoulder_width * p_body_depth;

% Dead area behind front and rear seats because of curved body height
a_dead_zone = (w_overall - 2*(t_body + w_tire + d_spring + 50)) * ((l_seat/2) + t_seat);

%% Automatic Interior Urban Layout 2 Calculation

% Calculation of potential seating area dimension

% Calculation of potential seating area dimensions
l_ul2_window = l_overall - 2*(t_body + t_seat + (l_seat/2) + 50);
l_ul2_door = (l_overall - 2*((w_door/2) +t_body + t_seat + (l_seat/2) + 50))/2;
l_ul2_rear = w_overall - 2*(t_body + t_seat + l_leg_clearance + l_seat + 50);

% Number of seats UL2, round down to get integer
n_ul2_window = floor(l_ul2_window / (w_seat + (2* w_seat_gap)));
n_ul2_door = floor(l_ul2_door / (w_seat + (2* w_seat_gap)));
n_ul2_rear = floor(l_ul2_rear / (w_seat + (2* w_seat_gap)));
n_ul2_seats = n_ul2_window + (2 * n_ul2_door) + (2 * n_ul2_rear);

% Rest Gap Division UL2
w_rest_gap_window_ul2 = mod(l_ul2_window, (n_ul2_window * (w_seat + (2* w_seat_gap))));
w_rest_gap_door_ul2 = mod(l_ul2_door, (n_ul2_door * (w_seat + (2* w_seat_gap))));
w_rest_gap_rear_ul2 = mod(l_ul2_rear, (n_ul2_rear * (w_seat + (2* w_seat_gap))));

% Calculating dead zone area from rest gaps in UL2
a_ul2_rest = (l_seat + t_seat) * (w_rest_gap_window_ul2 + w_rest_gap_door_ul2 + w_rest_gap_rear_ul2);

% Calculating standing area for passenger in UL2
a_ul2_standing = a_bus - ((n_ul2_seats * a_seat) + (2 * a_dead_zone) + a_ul2_rest); %no wheelhouses considered, because seats are over wheelhouse

% Calculating number of standing people in UL2
n_ul2_standing = floor(a_ul2_standing / a_passenger);

% Calculating number of passenber
n_ul2_passenger = n_ul2_seats + n_ul2_standing;

% Calculating sitting to standing ratio in UL2
per_ul2_sitting = round(n_ul2_seats / n_ul2_passenger *100);
per_ul2_standing = round(n_ul2_standing /n_ul2_passenger * 100);

% Avoid that CAD pattern for rear,front and door seat assembly contains a number 1 and 0 (otherwise this will cause trouble shout)
% Front and rear seat
if n_ul2_rear >= 2
    seat_ul2_front = 'true';
    seat_ul2_rear = 'true';
    pattern_seat_ul2_front = 'true';
    pattern_seat_ul2_rear = 'true';
    
elseif n_ul2_rear == 1
    seat_ul2_front = 'true';
    seat_ul2_rear = 'true';
    pattern_seat_ul2_front = 'false';
    pattern_seat_ul2_rear = 'false';
    
elseif n_ul2_rear == 0
    seat_ul2_front = 'false';
    seat_ul2_rear = 'false';
    pattern_seat_ul2_front = 'false';
    pattern_seat_ul2_rear = 'false';
    
end

% Door Seats
if n_ul2_door >= 2
    seat_ul2_door_front = 'true';
    seat_ul2_door_rear = 'true';
    pattern_seat_ul2_door_front = 'true';
    pattern_seat_ul2_door_rear = 'true';
    
elseif n_ul2_door == 1
    seat_ul2_door_front = 'true';
    seat_ul2_door_rear = 'true';
    pattern_seat_ul2_door_front = 'false';
    pattern_seat_ul2_door_rear = 'false';
    
elseif n_ul2_door == 0
    seat_ul2_door_front = 'false';
    seat_ul2_door_rear = 'false';
    pattern_seat_ul2_door_front = 'false';
    pattern_seat_ul2_door_rear = 'false';
    
end

%Save data for concept vizualization in txt file
check = 'ma';
save([path_base '10_Results\Components\Selection.mat'], 'l_overall', 'w_overall', 'h_overall', 'gc', 'wheelbase', 'h_lift', 'n_ul2_passenger', 'n_ul2_seats', 'n_ul2_standing', 'per_ul2_sitting', 'per_ul2_standing','check');

end