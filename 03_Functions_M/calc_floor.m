% Function for calculating floor height depending on the seat height and wheelhouse height

function [pattern_seat_ul1_door_front] = calc_floor (h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth)

% Space calculation

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



end