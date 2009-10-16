function a = getAddress(me)
ncfg = NetworkConfigDao(me.cfg);
address = ncfg.address;
a = address;
end