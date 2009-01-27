function [TimeString]=TimeCalFun(Starting_time);

Tsec=etime(clock,Starting_time);
TFactor=[3600,60];
tmp_rem=Tsec;
for i=1:2
	tmp2_rem=rem(tmp_rem,TFactor(i));
	tmp_3=tmp_rem/TFactor(i);
	if tmp_3 > 0
		tmp_Tvalue(i)=tmp_3-tmp2_rem/TFactor(i);
	else
		tmp_Tvalue(i)=0;
	end
	tmp_rem=tmp2_rem;
end
tmp_Tvalue(3)=tmp_rem;
if tmp_Tvalue(1)> 0
	    TimeString=sprintf('Elapsed Time: %.0f h %.0f min %.2f sec ',tmp_Tvalue);
else
	if tmp_Tvalue(2)> 0
		TimeString=sprintf('Elapsed Time: %.0f min %.2f sec ',tmp_Tvalue(2),tmp_Tvalue(3));
	else
		TimeString=sprintf('Elapsed Time: %.2f sec ',tmp_Tvalue(3));
	end
end
