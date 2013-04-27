function sw_addobject(hFigure, hAdd)
% SW_ADDOBJECT(hFigure, hAdd) adds a graphical object to a selected figure
%
% Input:
%
% hFigure   The handle of the figure (number in the figure title bar).
% hAdd      Vector of struct, that contains the handles of the graphical
%           objects, e.g. hAdd.objtype1 = [handle1 handle2 ...].
%
% See also SW.PLOT.
%

cva   = get(gca,'CameraViewAngle');
uData = get(hFigure,'UserData');
h     = uData.h;

if isfield(uData,'handle')
    handle = uData.handle;
else
    handle = struct;
end

if ~isstruct(hAdd)
    temp.newObjects = hAdd;
    hAdd = temp;
end

% Combs together the handles of the old and new graphical objects.
namesAdd = fieldnames(hAdd);
for ii = 1:length(namesAdd)
    if isfield(handle,namesAdd{ii})
        handle.(namesAdd{ii}) = [handle.(namesAdd{ii}) hAdd.(namesAdd{ii})];
    else
        handle.(namesAdd{ii}) = hAdd.(namesAdd{ii});
    end
end

% Delete the light objects.
if isfield(handle,'light')
    delete(handle.light(:));
    handle = rmfield(handle,'light');
end

h2 = hgtransform('Parent',h);
names = fieldnames(handle);

% Add all the objects to the hgtransform object.
% TODO check whether the graphical objects are not duplicated.
staticO = {'tooltip' 'legend' 'lRect' 'lText'};

for ii = 1:length(names)
    if ~any(strcmp(names{ii},staticO))
        h0 = reshape(handle.(names{ii}),1,[]);
        h0(h0 == 0) = [];
        h0(~ishandle(h0)) = [];
        set(h0,'Parent',h2);
        set(h0,'Clipping','Off');
    end
end

set(gca,'CameraViewAngle',cva);

handle.light = camlight('right');

% Shift the origin to center the plot.
if isfield(uData,'param') && isfield(uData.param,'range') && isfield(uData,'obj')
    range       = uData.param.range;
    basisVector = uData.obj.basisvector;
    T           = makehgtform('translate',-sum(basisVector * sum(range,2)/2,2)');
    set(h2,'Matrix',T);
end

% Saves the object handles into the figure UserData property.
uData.handle = handle;
uData.h      = h;
set(hFigure,'UserData',uData);

end