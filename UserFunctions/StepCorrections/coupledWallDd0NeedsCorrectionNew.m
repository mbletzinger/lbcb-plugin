function needsCorrectionDD0 = coupledWallDd0NeedsCorrectionNew(me)
needsCorrectionDD0 = false;

MyTol = me.getCfg('MyTol');
MyError = me.getDat('MyError');

if abs(MyError) > MyTol
    needsCorrectionDD0 = true;
end
end
