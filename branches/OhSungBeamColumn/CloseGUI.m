function CloseGUI

selection = questdlg('Closing GUI during simulation will interrupt the simulation. Do you want to close GUI?',...
                     'Close Request Function',...
                     'Yes','No','Yes');
switch selection,
   case 'Yes',
     delete(gcf)
   case 'No'
     return
end
