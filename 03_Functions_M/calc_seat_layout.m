% Function for calculating seating configuration parameters and layput
function [lay_urban1, lay_urban2, lay_coach, n_ul1_rear, n_ul1_window, n_ul1_door, n_ul1_passenger, n_ul1_seats, n_ul1_standing, per_ul1_sitting, per_ul1_standing, n_cl1_rear, n_cl1_window, n_cl1_door, n_cl1_passenger, n_cl1_seats, n_cl1_standing, per_cl1_sitting, per_cl1_standing,n_ul2_rear, n_ul2_window, n_ul2_door, n_ul2_passenger, n_ul2_seats, n_ul2_standing, per_ul2_sitting, per_ul2_standing, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear] = calc_seat_layout(l_overall, w_overall, wb, d_tire, w_tire, d_spring, t_body, w_door, lay_urban1, lay_urban2, lay_coach, h_seat, w_seat, l_seat, t_seat, h_backrest, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth)

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

%% Interior Layout Calculation

%% Urban Layout 1
% GUI Checkbox Layout Selection (num2string for txt.file)
if lay_urban1 == 1
    lay_urban1 = 'true';
    lay_urban2 = 'false';
    lay_coach = 'false';
    
    % Automatic Layout Urban 1 Calculation
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
    
    % Avoid that CAD pattern for rear,front and door seat assembly contains a number 1 and 0 (otherwise this will cause trouble shout)
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
    
%% Urban Layout 2

elseif lay_urban2 == 1
    lay_urban1 = 'false';
    lay_urban2 = 'true';
    lay_coach = 'false';
    
    % Automatic Layout Urban 2 Calculation
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
    
    
%% Coach Layout

elseif lay_coach == 1
    lay_urban1 = 'false';
    lay_urban2 = 'false';
    lay_coach = 'true';
    
    % Automatic Layout Coach 1 Calculation
    % Calculation of potential seating area dimension
    l_cl1_window = l_overall - 2*(wb + (d_tire * 2/3)) + (l_seat + t_seat); %Distance between front and rear wheelhouse plus one seat that sits on the wheelhouse
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
    
end

end