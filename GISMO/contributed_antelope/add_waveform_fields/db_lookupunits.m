function units = lookupunits(w,station,component)
%LOOKUPUNITS checks the antelope database to find out what units are
%   units = lookupunits(waveform);
%   returns the units associated with this particular waveform
%
%   units = lookupunits(waveform, station, component);
%   uses the waveform only to access this function, so you can call this
%   function with the constructor "waveform".  Useful information comes
%   form the station and component.
%
%
% Relies on antelope.  
% See also antelope's DBSUBSET, DBLOOKUP, DBOPEN, DBGETV

% AUTHOR: Celso Reyes, Geophysical Institute, Univ. of Alaska Fairbanks
% $Date: 2010-02-16 14:55:19 -0900 (Tue, 16 Feb 2010) $
% $Revision: 204 $

%This antelope specific routine belongs in contrib, not in waveform
global MASTER_STATION_DBASE

switch nargin
    case 1
        %good, all included.
    case 3
        w = set(w,'station', station, 'channel', component);
    otherwise
        return
end
        
try
    %get the units described by this sensor
    db = dbopen(MASTER_STATION_DBASE, 'r');
    db = dblookup_table(db,'calibration');
    db = dbsubset(db,['sta == "' get(w,'station')...
        '" && chan == "' get(w,'channel') '"']);
      
      % subset for network and location, too
      
    db.record = 0;
    units = dbgetv(db,'units');
catch
    units = 'COUNTS';
end
if exist('db','var')
    dbclose(db);
end
