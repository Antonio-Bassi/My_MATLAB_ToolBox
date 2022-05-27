function [P] = comparator( c, m, varargin )
    %   COMPARATOR generates a pulse width modulation with given carrier
    %   and modulator signals.
    %
    %   [ arg ] -> Mandatory argument.
    %   < arg > -> Optional/Conditional argument.
    %
    %   Usage
    %   [P] = comparator( c, m, ... )
    %
    %   Takes following arguments:
    %   [ c ]       :   Carrier signal
    %   [ m ]       :   modulator signal
    %   < HiVal >   :   Comaparator's high value.
    %   < LoVal >   :   Comparator's low value.
    %   Returns...
    %   [ P ]   :   Pulse-Width Modulated signal. 
    % -----------------------------------------------------------------------------------------
    %  file     : comparator.m
    %  author   : Antonio Vitor Grossi Bassi
    % ----------------------------------------------------------------------------------------- 

    sizeCheck = isequal( size(c), size(m) );
    
    if nargin > 2
        HiVal = varargin{1};
        LoVal = varargin{2};
    else
        HiVal = 1;
        LoVal = 0; 
    end
    
    if not( sizeCheck )
        error('Error : Arrays are of incompatible sizes!');
    end
    
    P = zeros( size(c) );
    
    for I = 1 : length(c);
        result = m(I) - c(I);
        if result <= 0
            P(I) = LoVal;
        else
            P(I) = HiVal;
        end
    end            
end