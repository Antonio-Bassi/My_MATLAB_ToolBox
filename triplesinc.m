%   TRIPLESINC computes triple sinc pulse signal.
%   m = triplesinc(T, dT) 
%       m : Triple sinc pulse signal
%   Returns array containing the resulting pulse.
%       T   :   time axis array
%       dT  :   Parameter equal twice the desired delay. 
% -----------------------------------------------------------------------------------------
%  @file    : triplesinc.m
%  @author  : Antonio Vitor-Grossi Bassi
%  @brief   : this function was provided by the book: 
%               MODERN DIGITAL AND ANALOG COMMUNICATION SYSTEMS 4th EDITION
%               B.P Lathi and Zhi Ding and adapted by Hari M. Gupta         
% ----------------------------------------------------------------------------------------- 

function m = triplesinc(T, dT)
    s1 = sinc( 2 * T/ dT );
    s2 = sinc( 2 * T / dT - 1 );
    s3 = sinc( 2 * T / dT + 1 );
    m = 2 * s1 + s2 + s3;
end
