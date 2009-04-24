function [lbcb1Xfrm lbcb2Xfrm] = createTransforms()
config = configModel2LbcbTransforms();
lbcb1Xfrm = model2LbcbTransform();
lbcb1Xfrm.transform = config.Lbcb1.Model2LbcbTransform;
lbcb1Xfrm.scale = config.Lbcb1.Model2LbcbScale;
lbcb2Xfrm = model2LbcbTransform();
lbcb1Xfrm.transform = config.Lbcb2.Model2LbcbTransform;
lbcb1Xfrm.scale = config.Lbcb2.Model2LbcbScale;
end