% Function for calculating seating configuration parameters and layput CL1

function [n_cl1_rear, n_cl1_window, n_cl1_door, n_cl1_passenger, n_cl1_seats, n_cl1_standing, per_cl1_sitting, per_cl1_standing, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, seat_cl1_door] = calc_seat_layout_cl1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth)

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


%% Automatic Interior Urban Layout 2 Calculation

% Calculation of potential seating area dimension

l_cl1_window = l_overall - 2*(t_body + t_seat + (l_seat/2) + 50 + l_leg_clearance + l_seat + t_seat); % l_overall - 2*(wb + (d_tire * 2/3)) + (l_seat + t_seat)Distance between front and rear wheelhouse plus one seat that sits on the wheelhouse
l_cl1_door = ((l_overall - w_door - (2* wb) - (d_tire * 4/3))/2) + (l_seat + t_seat); %Distance between front and rear wheelhouse and door plus one seat that sits on the wheelhouse
l_cl1_rear = w_overall - 2*(t_body + w_tire + d_spring + 50); %Distance between left and right wheelhouse, 50 is distance between tire and air spring

% Number of seats CL1, floor = round down to get integer
n_cl1_window = floor(l_cl1_window / (t_seat + l_seat + l_leg_clearance));
n_cl1_door = floor(l_cl1_door / (t_seat + l_seat + l_leg_clearance));
n_cl1_rear = floor(l_cl1_rear / (w_seat + (2* w_seat_gap)));
n_cl1_seats = 2 * (n_cl1_window + 2 * n_cl1_door + n_cl1_rear); %Multiplication by 2 because of two seats in a row

% Rest Gap Division CL1, modulus to get rest value
w_rest_gap_window_cl1 = mod(l_cl1_window, (n_cl1_window * (t_seat + l_seat + l_leg_clearance)));
w_rest_gap_door_cl1 = mod(l_cl1_door, (n_cl1_door * (t_seat + l_seat + l_leg_clearance)));
w_rest_gap_rear_cl1 = mod(l_cl1_rear, (n_cl1_rear * (w_seat + (2* w_seat_gap))));

% Calculating dead zone area from rest gaps in UL1
a_cl1_rest = (l_seat + t_seat) * w_rest_gap_rear_cl1; %peopple can stand at w_rest_gap_window_cl1 and w_rest_gap_door_cl1

% Calculating standing area for passenger in CL1
a_cl1_standing = a_bus - ((4 * a_wheelhouse) - (3 * (w_seat + (2* w_seat_gap)) * (l_seat + t_seat)) + ((n_cl1_seats) * a_seat) + (2 * a_dead_zone) + a_cl1_rest); %substraction of 3 seats that are over a wheelhouse

% Calculating number of standing people in CL1
n_cl1_standing = floor(a_cl1_standing / a_passenger);

% Calculating number of passenber
n_cl1_passenger = n_cl1_seats + n_cl1_standing;

% Calculating sitting to standing ratio in CL1
per_cl1_sitting = round(n_cl1_seats / n_cl1_passenger *100);
per_cl1_standing = round(n_cl1_standing /n_cl1_passenger * 100);

%% Avoid that CAD pattern for rear,front and door seat assembly contains a number 1 and 0 (otherwise this will cause trouble shout)
% Door Seats
if n_cl1_door >= 1
    seat_cl1_door = 'true';
    
elseif n_cl1_door == 0
    seat_cl1_door = 'false';
end

%Save data for concept vizualization in txt file
check = 'ma';
save([path_base '10_Results\Components\Selection.mat'], 'l_overall', 'w_overall', 'h_overall', 'gc', 'wheelbase', 'h_lift', 'n_cl1_passenger', 'n_cl1_seats', 'n_cl1_standing', 'per_cl1_sitting', 'per_cl1_standing', 'check');


end
