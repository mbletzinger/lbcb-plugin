function transforms = CreateTransforms()
config = ConfigModel2LbcbTransforms();
transforms = cell(2,1);
transforms{1} = Model2LbcbTransform();
lbcb1Xfrm.transform = config.Lbcb1.Model2LbcbTransform;
lbcb1Xfrm.scale = config.Lbcb1.Model2LbcbScale;
transforms{2}= Model2LbcbTransform();
lbcb1Xfrm.transform = config.Lbcb2.Model2LbcbTransform;
lbcb1Xfrm.scale = config.Lbcb2.Model2LbcbScale;
end