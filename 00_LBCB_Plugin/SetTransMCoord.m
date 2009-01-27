function handles = SetTransMCoord(handles)
% -------------------------------------------------------------------------------------------------
% --- Set transformation matrix
% -------------------------------------------------------------------------------------------------
Model_Coord_No = get(handles.PM_Model_Coord,'value');
LBCB_Coord_No  = get(handles.PM_LBCB_Coord,'value');

TransM_No = (Model_Coord_No-1)*4 + LBCB_Coord_No;
switch TransM_No
	case 1
		direction_cosine = [	0 	90 	90
					90	90	0
					90	180	90];
	case 2
		direction_cosine = [	90 	180 	90
					90	90	0
					180	90	90];
	
	case 3
		direction_cosine = [	180 	90 	90
					90	90	0
					90	0	90];

	case 4
		direction_cosine = [	90 	 0 	90
					90	90	0
					0	90	90];

	case 5
		direction_cosine = [	0 	90 	90
					90	180	90
					90	90	180];

	case 6
		direction_cosine = [	90 	90 	180
					90	180	90
					180	90	90];

	case 7
		direction_cosine = [	180 	90 	90
					90	180	90
					90	90	0];

	case 8
		direction_cosine = [	90 	90 	0
					90	180	90
					0	90	90];

end
tmp1 = zeros(3,3);
tmp2 = cos(direction_cosine/180*pi) ;
for i=1:3
	for j=1:3
		if abs(tmp2(i,j)) < eps
			tmp2(i,j)=0;
		end
	end
end
handles.MDL.TransM = [tmp2 tmp1; tmp1 tmp2];
% disp('Coordinate transformation matrix is defined as following.');
% disp('   Values in LBCB coordiate = DirectionCosine * Values in Model coordinate');
% disp('   DirectionCosine = ');
% disp(handles.MDL.TransM);

