function pressure = m_p(t, app_press, params)
    % Calculates the applied pressure to the bubble

    addpath(strcat(pwd, '/data'));
    % UNPACK
    P0 = params(1);
    % EVALUATE
    switch app_press
        case '1atm'
            pressure = P0;
        case '2atm'
            pressure = 2*P0;
        case '10atm'
            pressure = 10*P0;
        case '100atm'
            pressure = 100*P0;
        case '0.5atm'
            pressure = 0.5*P0;
        case '0.1atm'
            pressure = 0.1*P0;
        case 'from_data'
            pressure = P0; % TODO !
        otherwise
            pressure = P0 + f_p_ac(t, app_press, params);
    end
end

function pressure = f_p_ac(t, app_press, params)
    % Computes driving acoustical pressure
    
    % UNPACK
    ac_amp = params(19);
    ac_freq = params(18);
    ac_shift = params(17);
    delay = params(23);
    % COMPUTE
    if t < delay
        pressure = 0;
        return
    end
    switch app_press
        case 'sine'
            pressure = ac_amp * sin(2 * pi * ac_freq * (t - ac_shift));
        otherwise
            pressure = 0;
    end
end

