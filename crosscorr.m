function [T,C] = crosscorr( g, h, Fs )
    % CROSSCORR Performs time cross-correlation analysis on given signals
    %   [T,C] = crosscorr( g, h, Fs )
    %   T   :   time axis.
    %   C   :   time cross-correlation function.
    %   Returns two arrays : time axis and the time autocorrelation function.
    %   g   : signal to cross-correlate
    %   h   : signal to cross-correlate
    %   Fs  : Sampling Rate
    % -----------------------------------------------------------------------------------------
    %  file     : crosscorr.m
    %  author   : Antonio Vitor-Grossi Basssi
    % -----------------------------------------------------------------------------------------

    % Time constraints
    Nsg = length( g );
    Nsh = length( h );
    L = Nsh + Nsg;
    Ts = 1 / Fs;
    T = Ts * ( (-L/2 + 1) : 1 : (L/2 - 1) );
    C = zeros( size( T ) );

    % Auto Correlation
    for i = 1 : 1 : Nsh - 1
        for j = 1 : 1 : Nsg - 1
            C( i + j ) = C( i + j ) + g( j ) * h( Nsh - i ); 
        end
    end
    % Scale result to proper magnitude
    C = ( 1 / ( Nsh * Nsg ) ) * C;
end