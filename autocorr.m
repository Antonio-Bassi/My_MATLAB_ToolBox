function [T,R] = autocorr( g, Fs )
    % AUTOCORR Performs time autocorrelation analysis on given signal
    %   [T,R] = autocorr( g, Fs )
    %   T   :   time axis.
    %   R   :   time autocorrelation function.
    %   Returns two arrays : time axis and the time autocorrelation function.
    %   g   : signal to auto-correlate
    %   Fs  : Sampling Rate
    % -----------------------------------------------------------------------------------------
    %  file     : autocorr.m
    %  author   : Antonio Vitor-Grossi Basssi
    % -----------------------------------------------------------------------------------------

    % Time constraints
    Ns = length( g );
    Ts = 1 / Fs;
    T = Ts * (-Ns + 1 : 1 : Ns - 1);
    R = zeros( size( T ) );

    % Auto Correlation
    for i = 1 : 1 : Ns - 1
        for j = 1 : 1 : Ns - 1
            R( i + j ) = R( i + j ) + g( j ) * g( Ns - i ); 
        end
    end

    % Scale result to achieve proper magnitude
    R = ( 1 / (Ns^2) ) * R;
end