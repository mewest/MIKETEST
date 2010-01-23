function c = diff(c)

% DIFF differentiate each trace.
%
% C = DIFF(C) differentiate each trace through a call to WAVEFORM/DIFF.
% See WAVEFORM/DIFF for details


c.W = diff(c.W);